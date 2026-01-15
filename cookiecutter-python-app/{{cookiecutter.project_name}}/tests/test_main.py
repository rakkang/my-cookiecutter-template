"""主模块测试"""
import pytest
from {{ cookiecutter.project_slug }}.config.env_config import server_config

def test_server_config():
    """测试服务器配置"""
    assert server_config.APP_NAME == "{{ cookiecutter.project_slug }}"
    assert server_config.PORT > 0

def test_basic():
    """基础测试"""
    assert True
