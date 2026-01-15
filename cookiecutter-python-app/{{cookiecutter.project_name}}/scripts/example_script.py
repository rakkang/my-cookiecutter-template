#!/usr/bin/env python3
"""
示例脚本 - 展示如何在项目根目录运行脚本并调用项目模块
"""
import sys
from pathlib import Path

# 将 src 目录添加到 Python 路径
sys.path.insert(0, str(Path(__file__).parent.parent / "src"))

# 现在可以正常导入项目模块
from {{ cookiecutter.project_slug }}.utils.logger import logger
from {{ cookiecutter.project_slug }}.config.env_config import server_config

def main():
    """主函数"""
    logger.info("Script started")
    logger.info(f"App name: {server_config.APP_NAME}")
    logger.info(f"Log level: {server_config.LOG_LEVEL}")
    # 在这里添加你的业务逻辑
    print("示例脚本运行成功！")

if __name__ == "__main__":
    main()
