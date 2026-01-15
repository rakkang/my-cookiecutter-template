"""FastAPI 依赖注入模块"""
{%- if cookiecutter.use_fastapi == "yes" %}
from fastapi import Depends, HTTPException, status
from typing import Generator

def get_db() -> Generator:
    """数据库依赖（示例）"""
    # 在这里添加数据库连接逻辑
    try:
        yield None
    finally:
        pass

def get_current_user() -> dict:
    """获取当前用户（示例）"""
    # 在这里添加认证逻辑
    return {"user_id": "anonymous"}
{%- else %}
# deps.py 仅在 use_fastapi=yes 时使用
pass
{%- endif %}
