# {{ cookiecutter.project_name }}

{{ cookiecutter.description }}

## 项目结构

```
{{ cookiecutter.project_name }}/
├── src/
│   └── {{ cookiecutter.project_slug }}/
│       ├── config/          # 配置模块
│       ├── utils/           # 通用工具
{%- if cookiecutter.use_fastapi == "yes" %}
│       ├── api/             # FastAPI 路由
│       └── model/           # 数据模型
{%- endif %}
{%- if cookiecutter.use_langchain == "yes" %}
│       └── executor/        # LLM 执行器
{%- endif %}
{%- if cookiecutter.project_structure == "layered" %}
│       ├── domain/          # 领域层
│       └── infra/           # 基础设施层
{%- endif %}
├── scripts/                 # 脚本目录
├── tests/                   # 测试目录
{%- if cookiecutter.use_react == "yes" %}
└── frontend/                # React 前端
{%- endif %}
```

## 快速开始

### 1. 环境初始化

```bash
./scripts/init_env.sh
```

### 2. 安装依赖

```bash
# Python 依赖
pip install -e .

# {%- if cookiecutter.use_react == "yes" %}
# 前端依赖
cd frontend && pnpm install
{%- endif %}
```

### 3. 配置环境变量

```bash
cp env.example .env
# 编辑 .env 文件，填入必要的配置
```

### 4. 启动开发服务器

```bash
# 启动后端（{%- if cookiecutter.use_react == "yes" %}和前端{%- endif %}）
./scripts/dev.sh

# 或仅启动后端
./scripts/dev.sh --backend-only
```

## 开发

### 运行测试

```bash
pytest
```

### 运行脚本

```bash
# 方式1: 使用 python -m
python -m {{ cookiecutter.project_slug }}

# 方式2: 使用脚本模板
python scripts/example_script.py
```

## 技术栈

- **Python**: {{ cookiecutter.python_version }}
{%- if cookiecutter.use_fastapi == "yes" %}
- **Web框架**: FastAPI
{%- endif %}
{%- if cookiecutter.use_react == "yes" %}
- **前端**: React 18 + TailwindCSS + Vite
{%- endif %}
{%- if cookiecutter.use_langchain == "yes" %}
- **LLM**: LangChain
{%- endif %}

## License

MIT
