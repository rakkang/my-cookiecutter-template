# {{cookiecutter.package_name}}

A Swift package by {{cookiecutter.author_name}}.

## Requirements

{% if cookiecutter.platforms == "iOS" -%}
- iOS {{cookiecutter.ios_deployment_target}}+
{% elif cookiecutter.platforms == "macOS" -%}
- macOS {{cookiecutter.macos_deployment_target}}+
{% else -%}
- iOS {{cookiecutter.ios_deployment_target}}+
- macOS {{cookiecutter.macos_deployment_target}}+
{% endif %}
- Swift 5.10+

## Installation

### Swift Package Manager

Add {{cookiecutter.package_name}} to your project using one of these methods:

#### Remote Git Repository

```swift
dependencies: [
    .package(url: "https://github.com/{{cookiecutter.author_name}}/{{cookiecutter.package_name}}.git", from: "1.0.0")
]
```

#### Local Path

```swift
dependencies: [
    .package(path: "../{{cookiecutter.package_name}}")
]
```

Then add the dependency to your target:

```swift
.target(
    name: "YourApp",
    dependencies: ["{{cookiecutter.package_name}}"]
)
```

## Usage

### Core

```swift
import {{cookiecutter.package_name}}

let service = ExampleService()
print(service.greet("World"))  // Hello, World!
print(service.add(2, 3))       // 5
```

{% if cookiecutter.include_ui == "yes" -%}
### SwiftUI

```swift
import {{cookiecutter.package_name}}
import SwiftUI

struct ContentView: View {
    var body: some View {
        ExampleView(title: "My App")
    }
}
```
{% endif %}

## License

MIT License

