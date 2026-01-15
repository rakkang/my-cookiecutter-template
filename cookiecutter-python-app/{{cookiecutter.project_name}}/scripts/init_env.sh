#!/bin/bash
# 环境初始化脚本

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

print_step() {
    printf "%b\n" "${CYAN}>${NC} $1"
}

print_success() {
    printf "%b\n" "${GREEN}[OK]${NC} $1"
}

print_warning() {
    printf "%b\n" "${YELLOW}[警告]${NC} $1"
}

print_error() {
    printf "%b\n" "${RED}[错误]${NC} $1"
}

# 显示旋转进度指示器（带日志文件读取）
spin_with_log() {
    local pid=$1
    local msg=$2
    local logfile=$3
    local -a spinchars=('-' '\' '|' '/')
    local i=0
    local last_pkg=""
    local display_msg="$msg"
    
    printf "  ${CYAN}%s${NC} %s" "-" "$display_msg"
    
    while kill -0 "$pid" 2>/dev/null; do
        i=$(( (i + 1) % 4 ))
        
        # 尝试从日志读取当前安装的包
        if [[ -f "$logfile" ]]; then
            # 匹配 uv/pip 的安装输出
            local current_pkg=$(tail -5 "$logfile" 2>/dev/null | grep -oE '(Installing|Downloading|Building|Collecting) [a-zA-Z0-9_-]+' | tail -1 | awk '{print $2}')
            if [[ -n "$current_pkg" && "$current_pkg" != "$last_pkg" ]]; then
                last_pkg="$current_pkg"
                display_msg="$msg (${current_pkg})"
            fi
        fi
        
        # 清除到行末并打印
        printf "\r\033[K  ${CYAN}%s${NC} %s" "${spinchars[$i]}" "$display_msg"
        sleep 0.1
    done
    
    wait "$pid"
    local exit_code=$?
    
    printf "\r\033[K"
    
    return $exit_code
}

# 运行命令并显示进度
run_with_progress() {
    local msg=$1
    shift
    
    "$@" >/dev/null 2>&1 &
    local pid=$!
    
    # 简单 spinner
    local -a spinchars=('-' '\' '|' '/')
    local i=0
    printf "  ${CYAN}%s${NC} %s" "-" "$msg"
    while kill -0 "$pid" 2>/dev/null; do
        i=$(( (i + 1) % 4 ))
        printf "\r  ${CYAN}%s${NC} %s" "${spinchars[$i]}" "$msg"
        sleep 0.1
    done
    wait "$pid"
    local exit_code=$?
    printf "\r\033[K"
    
    if [[ $exit_code -eq 0 ]]; then
        print_success "$msg"
    else
        print_error "$msg 失败"
        return $exit_code
    fi
}

# 运行 pip 安装并显示当前包名
run_pip_install() {
    local msg=$1
    shift
    
    local logfile=$(mktemp)
    
    # 运行命令，输出到日志文件
    "$@" > "$logfile" 2>&1 &
    local pid=$!
    
    spin_with_log $pid "$msg" "$logfile"
    local exit_code=$?
    
    # 清理
    rm -f "$logfile"
    
    if [[ $exit_code -eq 0 ]]; then
        print_success "$msg"
    else
        print_error "$msg 失败"
        # 显示错误日志
        if [[ -f "$logfile" ]]; then
            tail -10 "$logfile"
        fi
        return $exit_code
    fi
}

check_python() {
    local python_version="{{ cookiecutter.python_version }}"
    
    if [ "$python_version" = "3.8" ]; then
        # 检查 pyenv
        if command -v pyenv &> /dev/null; then
            print_step "使用 pyenv 创建 Python 3.8 环境..."
            pyenv install -s 3.8 || true
            pyenv local 3.8
            PYTHON_CMD="python"
            print_success "Python 3.8 (pyenv)"
        elif command -v conda &> /dev/null; then
            print_step "使用 conda 创建 Python 3.8 环境..."
            conda create -n {{ cookiecutter.project_slug }} python=3.8 -y || true
            conda activate {{ cookiecutter.project_slug }}
            PYTHON_CMD="python"
            print_success "Python 3.8 (conda)"
        else
            print_warning "未找到 pyenv 或 conda，使用系统 Python"
            if command -v python3 &> /dev/null; then
                PYTHON_CMD="python3"
            elif command -v python &> /dev/null; then
                PYTHON_CMD="python"
            else
                print_error "未找到 Python，请安装 Python 3.8+"
                exit 1
            fi
        fi
    else
        # 使用系统 Python
        if command -v python3 &> /dev/null; then
            PYTHON_CMD="python3"
        elif command -v python &> /dev/null; then
            PYTHON_CMD="python"
        else
            print_error "未找到 Python，请安装 Python 3.8+"
            exit 1
        fi
    fi
    
    PYTHON_VERSION=$($PYTHON_CMD -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')
    print_success "Python $PYTHON_VERSION"
}

check_pip() {
    if command -v uv &> /dev/null; then
        PIP_CMD="uv pip"
        print_success "uv $(uv --version | cut -d' ' -f2)"
    elif command -v pip3 &> /dev/null; then
        PIP_CMD="pip3"
        print_success "pip3 $(pip3 --version | cut -d' ' -f2)"
    elif command -v pip &> /dev/null; then
        PIP_CMD="pip"
        print_success "pip $(pip --version | cut -d' ' -f2)"
    else
        PIP_CMD="$PYTHON_CMD -m pip"
        print_success "pip (via python -m pip)"
    fi
}

setup_venv() {
    cd "$PROJECT_DIR"
    
    if [ ! -d ".venv" ]; then
        run_with_progress "创建虚拟环境" $PYTHON_CMD -m venv .venv
    fi
    
    source .venv/bin/activate
    
    if [[ "$PIP_CMD" == "uv pip" ]]; then
        run_with_progress "升级 pip" uv pip install --upgrade pip || true
        run_pip_install "安装项目依赖" uv pip install -e .
    else
        run_with_progress "升级 pip" .venv/bin/pip install --upgrade pip
        run_pip_install "安装项目依赖" .venv/bin/pip install -e .
    fi
}

setup_env_file() {
    cd "$PROJECT_DIR"
    
    if [ ! -f ".env" ]; then
        if [ -f "env.example" ]; then
            print_step "复制 env.example 到 .env..."
            cp env.example .env
            print_success ".env 文件已创建"
            print_warning "请编辑 .env 文件，填入必要的配置"
        elif [ -f ".env.example" ]; then
            print_step "复制 .env.example 到 .env..."
            cp .env.example .env
            print_success ".env 文件已创建"
            print_warning "请编辑 .env 文件，填入必要的配置"
        fi
    else
        print_warning ".env 文件已存在，跳过"
    fi
}

main() {
    echo ""
    printf "%b\n" "${CYAN}========================================${NC}"
    printf "%b\n" "${CYAN}  环境初始化                            ${NC}"
    printf "%b\n" "${CYAN}========================================${NC}"
    echo ""
    
    print_step "检查依赖..."
    echo ""
    
    check_python
    check_pip
    
    echo ""
    setup_venv
    
    echo ""
    setup_env_file
    
    echo ""
    print_success "环境初始化完成！"
    echo ""
    echo "后续步骤:"
    echo "  1. 编辑 .env 文件，填入必要的配置"
    echo "  2. source .venv/bin/activate  # 激活虚拟环境"
    echo "  3. ./scripts/dev.sh            # 启动开发服务器"
}

main "$@"
