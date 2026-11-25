# Swift VIPER Persons App

A SwiftUI iOS app that demonstrates the VIPER architecture (View, Interactor, Presenter, Entity, Router) with [Swinject](https://github.com/Swinject/Swinject) for dependency injection. It shows users, their recent posts and comments, and a photo list, all fetched from the public [JSONPlaceholder](https://jsonplaceholder.typicode.com) API.

## Requirements

- Xcode (recent version with SwiftUI and Swift Concurrency support)
- iOS Simulator or device

## Getting started

1. Open `ViperArchitecture.xcodeproj` in Xcode. Swift Package Manager resolves Swinject automatically.
2. Select the `ViperArchitecture` scheme and an iOS simulator.
3. Press Cmd+R to run.

Or build from the command line:

```
xcodebuild -project ViperArchitecture.xcodeproj -scheme ViperArchitecture -destination 'generic/platform=iOS Simulator' build
```

## Architecture

| Layer | Folder | Role |
|-------|--------|------|
| View | `Views/` | SwiftUI screens and shared components |
| Presenter | `Presenter/` | `ObservableObject` view state and loading logic |
| Interactor | `Interactor/` | Business logic, calls the networking layer |
| Entity | `Model/` | `Decodable` models |
| Router | `Routers/` | Builds views and presenters, resolves dependencies |
| Networking | `Networking/`, `Utils/` | `APIClient` and per-resource endpoints |
| DI | `DI/AppContainer.swift` | Swinject container registering endpoints and interactors by protocol |

## License

See [LICENSE](LICENSE).
