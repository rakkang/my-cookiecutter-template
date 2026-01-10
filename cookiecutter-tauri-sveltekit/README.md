# Tauri + Svelte 5 Cookiecutter 模板

基于 Tauri 2.0 和 Svelte 5 (Runes) 的跨平台桌面应用模板。

## 功能特性

- **Tauri 2.0** - 轻量级跨平台桌面框架
- **Svelte 5** - 最新 Runes 响应式语法
- **TypeScript** - 类型安全
- **Vite** - 快速开发构建
- **pnpm** - 高效包管理

### 可选模块

- **TailwindCSS** - 实用优先的 CSS 框架
- **国际化 (i18n)** - 多语言支持
- **系统托盘** - 托盘图标和菜单
- **自动更新** - 应用自动更新
- **文件系统 API** - 文件读写操作

## 使用方法

### 交互式创建

```bash
./create_project.sh
```

### 命令行创建

```bash
./create_project.sh --non-interactive --name my-app --tray --fs
```

### 参数说明

| 参数 | 说明 |
|------|------|
| `--name, -n` | 项目名称 (kebab-case) |
| `--description, -d` | 项目描述 |
| `--author, -a` | 作者名称 |
| `--output-dir, -o` | 输出目录 |
| `--no-tailwind` | 排除 TailwindCSS |
| `--i18n` | 包含国际化 |
| `--locale` | 默认语言 (en/zh) |
| `--tray` | 包含系统托盘 |
| `--updater` | 包含自动更新 |
| `--fs` | 包含文件系统 API |

## 生成后步骤

```bash
cd my-app
pnpm install
pnpm tauri icon <source-image.png>  # 生成应用图标
pnpm tauri dev
```

## 项目结构

```
my-app/
├── src/                    # Svelte 前端
│   ├── lib/
│   │   ├── stores/         # 状态管理
│   │   ├── i18n/           # 国际化
│   │   └── tauri/          # Tauri API 封装
│   ├── App.svelte
│   └── main.ts
├── src-tauri/              # Rust 后端
│   ├── capabilities/       # 权限配置
│   ├── src/
│   │   ├── lib.rs
│   │   └── tray.rs         # 托盘模块
│   └── tauri.conf.json
├── package.json
└── vite.config.ts
```

## 依赖要求

- Python 3.9+
- Rust 1.70+
- pnpm 8+
- Node.js 18+

## License

MIT

