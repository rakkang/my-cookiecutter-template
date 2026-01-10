# My Cookiecutter Templates

一个包含多个项目模板的 CookieCutter 模板集合，用于快速生成不同类型的项目脚手架。

## 📦 包含的模板

本仓库包含以下 4 个 CookieCutter 模板：

1. **cookiecutter-swift-cli** - Swift 命令行工具模板
2. **cookiecutter-swift-package** - Swift Package 模板
3. **cookiecutter-swiftui-starter** - SwiftUI 应用启动模板（支持 iOS/macOS）
4. **cookiecutter-tauri-sveltekit** - Tauri + SvelteKit 桌面应用模板

## 🚀 如何使用

### 方法一：使用提供的脚本（推荐）

每个模板目录都包含一个 `create_project.sh` 脚本，运行即可启动交互式项目生成：

```bash
# Swift CLI 工具
cd cookiecutter-swift-cli
./create_project.sh

# Swift Package
cd cookiecutter-swift-package
./create_project.sh

# SwiftUI 应用
cd cookiecutter-swiftui-starter
./create_project.sh

# Tauri + SvelteKit 应用
cd cookiecutter-tauri-sveltekit
./create_project.sh
```

脚本会自动：
- 检查 Python 环境
- 创建虚拟环境
- 安装所需依赖
- 启动交互式配置向导

### 方法二：直接使用 CookieCutter

如果你已经安装了 CookieCutter，可以直接使用：

```bash
# 安装 CookieCutter（如果未安装）
pip install cookiecutter

# 使用模板
cookiecutter cookiecutter-swift-cli
cookiecutter cookiecutter-swift-package
cookiecutter cookiecutter-swiftui-starter
cookiecutter cookiecutter-tauri-sveltekit
```

## 📋 环境要求

### 基础环境（所有模板都需要）

- **Python**: 3.9 或更高版本
- **CookieCutter**: >= 2.5.0（脚本会自动安装）

### Swift 相关模板（swift-cli, swift-package, swiftui-starter）

- **Swift**: 5.9+ 
- **Xcode**: 最新版本（macOS）
- **Swift Package Manager**: 随 Xcode 安装

### Tauri + SvelteKit 模板

- **Node.js**: 18+ 和 npm/yarn/pnpm
- **Rust**: 最新稳定版
- **系统依赖**:
  - macOS: Xcode Command Line Tools
  - Linux: `libwebkit2gtk-4.0-dev`, `build-essential`, `curl`, `wget`, `libssl-dev`, `libgtk-3-dev`, `libayatana-appindicator3-dev`, `librsvg2-dev`
  - Windows: Microsoft Visual Studio C++ Build Tools

## 🔧 模板详情

### cookiecutter-swift-cli

生成 Swift 命令行工具项目，包含：
- Swift Package Manager 配置
- 基础 CLI 结构
- 测试框架设置

**配置项：**
- `project_name`: 项目名称
- `author_name`: 作者名称
- `description`: 项目描述
- `macos_deployment_target`: macOS 最低版本要求

### cookiecutter-swift-package

生成 Swift Package 库项目，包含：
- 模块化代码结构（Core/UI）
- 单元测试和 UI 测试
- 多平台支持（iOS/macOS）

**配置项：**
- `package_name`: Package 名称
- `author_name`: 作者名称
- `platforms`: 支持的平台
- `ios_deployment_target`: iOS 最低版本要求
- `macos_deployment_target`: macOS 最低版本要求
- `include_ui`: 是否包含 UI 模块

### cookiecutter-swiftui-starter

生成完整的 SwiftUI 应用项目，包含：
- Clean Architecture 架构（Domain/Data/Presentation）
- 依赖注入容器
- 网络层（可选）
- 数据持久化（SwiftData，可选）
- iCloud 支持（可选）
- Coordinator 模式导航

**配置项：**
- `project_name`: 项目名称
- `bundle_identifier`: Bundle ID
- `author_name`: 作者名称
- `organization_name`: 组织名称
- `platforms`: 支持的平台
- `ios_deployment_target`: iOS 最低版本要求
- `macos_deployment_target`: macOS 最低版本要求
- `include_network`: 是否包含网络层
- `include_persistence`: 是否包含数据持久化
- `include_icloud`: 是否包含 iCloud 支持

### cookiecutter-tauri-sveltekit

生成 Tauri + SvelteKit 桌面应用项目，包含：
- Tauri Rust 后端
- SvelteKit 前端框架
- Tailwind CSS（可选）
- 国际化支持（可选）
- 系统托盘（可选）
- 自动更新（可选）
- 文件系统访问（可选）
- Python 集成（可选）

**配置项：**
- `project_name`: 项目名称
- `project_description`: 项目描述
- `author_name`: 作者名称
- `include_tailwind`: 是否包含 Tailwind CSS
- `include_i18n`: 是否包含国际化
- `include_tray`: 是否包含系统托盘
- `include_updater`: 是否包含自动更新
- `include_fs`: 是否包含文件系统访问
- `include_python`: 是否包含 Python 集成
- `python_interpreter`: Python 解释器类型（rustpython/pyo3）
- `default_locale`: 默认语言

## 📝 示例

### 创建 Swift CLI 工具

```bash
cd cookiecutter-swift-cli
./create_project.sh

# 交互式输入：
# project_name: MyAwesomeCLI
# author_name: Your Name
# description: A powerful CLI tool
# macos_deployment_target: 14.0
```

### 创建 SwiftUI 应用

```bash
cd cookiecutter-swiftui-starter
./create_project.sh

# 交互式输入配置项...
```

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

本项目采用 Apache-2.0 许可证。
