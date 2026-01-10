# {{ cookiecutter.project_name }}

{{ cookiecutter.project_description }}

## 环境要求

- [Node.js](https://nodejs.org/) >= 18
- [pnpm](https://pnpm.io/)
- [Rust](https://www.rust-lang.org/)

## 安装依赖

```bash
pnpm install
```

## 开发模式

启动开发服务器，支持热重载：

```bash
pnpm tauri dev
```

此命令会同时启动：
- Vite 前端开发服务器 (localhost:1420)
- Tauri 桌面应用窗口

## 构建生产版本

构建可分发的应用程序：

```bash
pnpm tauri build
```

构建产物位于 `src-tauri/target/release/bundle/` 目录：
- **macOS**: `.app` 和 `.dmg`
- **Windows**: `.exe` 和 `.msi`
- **Linux**: `.deb` 和 `.AppImage`

## 仅构建前端

```bash
# 构建
pnpm build

# 本地预览构建结果
pnpm preview
```

## 项目结构

```
├── src/                # Svelte 前端源码
│   ├── lib/            # 公共库
│   └── App.svelte      # 主组件
├── src-tauri/          # Tauri/Rust 后端
│   ├── src/            # Rust 源码
│   └── tauri.conf.json # Tauri 配置
└── package.json
```

## 自定义图标

替换默认图标：

```bash
pnpm tauri icon <your-icon.png>
```

需要一张至少 **1024x1024** 的 PNG 图片。

## 许可证

MIT

