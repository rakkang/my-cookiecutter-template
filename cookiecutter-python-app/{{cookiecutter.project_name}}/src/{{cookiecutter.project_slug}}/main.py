"""主入口模块"""

{%- if cookiecutter.use_fastapi == "yes" %}
from fastapi import FastAPI
from .config.env_config import server_config
from .utils.logger import setup_logger, get_logger
{%- if cookiecutter.use_fastapi == "yes" %}
from .api.routes import example
{%- endif %}

logger = get_logger(__name__)

# 初始化日志
setup_logger(
    log_level=server_config.LOG_LEVEL,
    log_dir=server_config.LOG_DIR,
    app_name=server_config.APP_NAME,
)

app = FastAPI(
    title="{{ cookiecutter.project_name }}",
    description="{{ cookiecutter.description }}",
    version="0.1.0",
)

# 注册路由
{%- if cookiecutter.use_fastapi == "yes" %}
app.include_router(example.router, prefix=server_config.API_PREFIX)
{%- endif %}

@app.get("/")
async def root():
    """健康检查"""
    return {"message": "{{ cookiecutter.project_name }} API", "status": "ok"}

@app.get("/health")
async def health():
    """健康检查"""
    return {"status": "healthy"}

def main():
    """CLI 入口"""
    import uvicorn
    uvicorn.run(
        app,
        host=server_config.HOST,
        port=server_config.PORT,
        reload=server_config.DEBUG,
    )
{%- else %}
from .utils.logger import setup_logger, get_logger
from .config.env_config import server_config

logger = get_logger(__name__)

# 初始化日志
setup_logger(
    log_level=server_config.LOG_LEVEL,
    log_dir=server_config.LOG_DIR,
    app_name=server_config.APP_NAME,
)

def main():
    """CLI 入口"""
    logger.info("{{ cookiecutter.project_name }} started")
    # 在这里添加你的业务逻辑
    pass
{%- endif %}

if __name__ == "__main__":
    main()
