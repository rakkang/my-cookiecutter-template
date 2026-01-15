"""示例路由"""
{%- if cookiecutter.use_fastapi == "yes" %}
from fastapi import APIRouter, Depends
from ..common.response import CommonResponse
from ..deps import get_current_user

router = APIRouter(prefix="/example", tags=["example"])

@router.get("/")
async def example_endpoint(current_user: dict = Depends(get_current_user)):
    """示例端点"""
    return CommonResponse.success(
        data={"message": "This is an example endpoint"},
        message="Success"
    )
{%- else %}
# example.py 仅在 use_fastapi=yes 时使用
pass
{%- endif %}
