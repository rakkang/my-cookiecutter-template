# {{cookiecutter.project_name}}

{{cookiecutter.description}}

## 构建

```bash
swift build -c release
```

## 安装

```bash
# 复制到 PATH
cp .build/release/{{cookiecutter.project_name}} /usr/local/bin/
```

## 使用

```bash
# 运行默认命令
{{cookiecutter.project_name | lower}}

# 查看帮助
{{cookiecutter.project_name | lower}} --help

# 显示版本
{{cookiecutter.project_name | lower}} --version

# 运行子命令
{{cookiecutter.project_name | lower}} run --input file.txt --verbose
{{cookiecutter.project_name | lower}} info
```

## 开发

```bash
# 调试构建
swift build

# 运行测试
swift test

# 直接运行
swift run {{cookiecutter.project_name}}
```

## 作者

{{cookiecutter.author_name}}

