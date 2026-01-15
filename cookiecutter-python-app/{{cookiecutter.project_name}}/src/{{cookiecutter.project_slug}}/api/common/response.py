from typing import Any, Dict, Optional

from pydantic import BaseModel


class CommonResponse(BaseModel):
    """
    通用响应结构
    """
    code: int
    message: str
    data: Optional[Any] = None

    @classmethod
    def success(cls, data: Any = None, message: str = "success") -> Dict[str, Any]:
        """返回成功响应"""
        return cls(code=200, message=message, data=data).model_dump()
    
    @classmethod
    def error(cls, code: int = 400, message: str = "error", data: Any = None) -> Dict[str, Any]:
        """返回错误响应"""
        return cls(code=code, message=message, data=data).model_dump()
    
    @classmethod
    def server_error(cls, message: str = "服务器内部错误") -> Dict[str, Any]:
        """返回服务器错误响应"""
        return cls(code=500, message=message, data=None).model_dump()
