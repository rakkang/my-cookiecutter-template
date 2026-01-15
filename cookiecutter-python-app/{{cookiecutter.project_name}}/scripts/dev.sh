#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# 颜色
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# 清理函数
cleanup() {
    echo -e "\n${YELLOW}> 停止服务...${NC}"
    # 杀死整个进程组
    [ -n "$BACKEND_PID" ] && kill -- -$BACKEND_PID 2>/dev/null
    [ -n "$FRONTEND_PID" ] && kill -- -$FRONTEND_PID 2>/dev/null
    # 确保所有子进程都被终止
    jobs -p | xargs -r kill 2>/dev/null
    wait 2>/dev/null
    echo -e "${GREEN}> 服务已停止${NC}"
    exit 0
}
trap cleanup SIGINT SIGTERM EXIT

start_backend() {
    echo -e "${CYAN}> 启动后端服务 (port 8000)...${NC}"
    cd "$PROJECT_DIR"
    
    # 激活虚拟环境
    if [ -d ".venv" ]; then
        source .venv/bin/activate
    fi
    
    # 使用 uvicorn 启动 FastAPI
{%- if cookiecutter.use_fastapi == "yes" %}
    python -m uvicorn {{ cookiecutter.project_slug }}.main:app \
        --host 0.0.0.0 \
        --port 8000 \
        --reload
{%- else %}
    python -m {{ cookiecutter.project_slug }}
{%- endif %}
}

start_frontend() {
    echo -e "${CYAN}> 启动前端服务 (port 5173)...${NC}"
    cd "$PROJECT_DIR/frontend"
    
    # 检查 node_modules
    if [ ! -d "node_modules" ]; then
        echo -e "${YELLOW}安装前端依赖...${NC}"
        if command -v pnpm &> /dev/null; then
            pnpm install
        elif command -v npm &> /dev/null; then
            npm install
        else
            echo -e "${YELLOW}未找到 pnpm 或 npm，请先安装${NC}"
            exit 1
        fi
    fi
    
    if command -v pnpm &> /dev/null; then
        pnpm dev
    else
        npm run dev
    fi
}

# 检查前端目录是否存在
has_frontend() {
    [ -d "$PROJECT_DIR/frontend" ] && [ -f "$PROJECT_DIR/frontend/package.json" ]
}

# 解析参数
BACKEND_ONLY=false
case "${1:-}" in
    --backend-only|-b)
        BACKEND_ONLY=true
        ;;
    --help|-h)
        echo "用法: $0 [选项]"
        echo ""
        echo "选项:"
        echo "  (无参数)        启动后端 + 前端 (如果有)"
        echo "  --backend-only, -b  仅启动后端"
        echo "  --help, -h      显示帮助"
        exit 0
        ;;
    "")
        ;;
    *)
        echo "未知参数: $1"
        echo "使用 --help 查看帮助"
        exit 1
        ;;
esac

# 显示服务 URL
show_urls() {
    echo ""
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}  服务已启动${NC}"
    echo -e "${GREEN}========================================${NC}"
    echo ""
    echo -e "  ${CYAN}后端 API:${NC}  http://localhost:8000"
{%- if cookiecutter.use_fastapi == "yes" %}
    echo -e "  ${CYAN}API 文档:${NC}  http://localhost:8000/docs"
{%- endif %}
    if has_frontend; then
        echo -e "  ${CYAN}前端页面:${NC} http://localhost:5173"
    fi
    echo ""
    echo -e "  ${YELLOW}按 Ctrl+C 停止服务${NC}"
    echo ""
}

# 启动服务
if [ "$BACKEND_ONLY" = true ]; then
    echo ""
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}  后端服务${NC}"
    echo -e "${GREEN}========================================${NC}"
    echo ""
    echo -e "  ${CYAN}后端 API:${NC}  http://localhost:8000"
{%- if cookiecutter.use_fastapi == "yes" %}
    echo -e "  ${CYAN}API 文档:${NC}  http://localhost:8000/docs"
{%- endif %}
    echo ""
    start_backend
elif has_frontend; then
    echo -e "${GREEN}> 检测到前端项目，同时启动后端和前端${NC}"
    
    # 启用作业控制以便获取进程组
    set -m
    
    # 后台启动后端（新进程组）
    start_backend &
    BACKEND_PID=$!
    
    # 等待后端启动
    sleep 2
    
    # 后台启动前端（新进程组）
    start_frontend &
    FRONTEND_PID=$!
    
    # 等待前端就绪后显示 URL
    sleep 3
    show_urls
    
    # 等待任意进程退出
    wait $BACKEND_PID $FRONTEND_PID 2>/dev/null
else
    echo -e "${GREEN}> 未检测到前端项目，仅启动后端${NC}"
    echo ""
    echo -e "  ${CYAN}后端 API:${NC}  http://localhost:8000"
{%- if cookiecutter.use_fastapi == "yes" %}
    echo -e "  ${CYAN}API 文档:${NC}  http://localhost:8000/docs"
{%- endif %}
    echo ""
    start_backend
fi
