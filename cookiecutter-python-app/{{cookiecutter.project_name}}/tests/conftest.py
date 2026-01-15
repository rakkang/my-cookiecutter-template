"""Pytest 配置"""
import pytest
import sys
from pathlib import Path

# 将 src 目录添加到 Python 路径
sys.path.insert(0, str(Path(__file__).parent.parent / "src"))

@pytest.fixture
def sample_data():
    """示例测试数据"""
    return {"key": "value"}
