# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

SwiftUI iOS app demonstrating VIPER architecture, with Swinject for dependency injection. It lists users and photos from the public JSONPlaceholder API (`BASE_URL` in `Constants/Constants.swift`). There are no test targets and no linter config.

## Commands

Single Xcode project, one target/scheme: `ViperArchitecture`. The only SPM dependency is Swinject (resolved via the Xcode project).

```
xcodebuild -project ViperArchitecture.xcodeproj -scheme ViperArchitecture -destination 'generic/platform=iOS Simulator' build
```

Run the app from Xcode (Cmd+R) or install the built product on a simulator.

## Architecture

VIPER per feature, with each layer behind a protocol:

- **Networking**: `APIClient` protocol (`get<T: Decodable>(path)`), implemented by `URLSessionAPIClient`, which delegates to `URLSession.get` in `Utils/APIResponses.swift`. That extension prepends `BASE_URL` and maps failures to `NetworkError`. `*Endpoint` structs (`UsersEndpoint`, `PhotosEndpoint`, `CommentsEndpoint`) wrap `APIClient` with typed fetch methods. Endpoints take relative paths.
- **Interactor** (`XxxInteracting` protocol + `XxxInteractor` class): business logic that calls endpoints. `RecentActivityInteractor` combines `UsersEndpoint` (posts) and `CommentsEndpoint`.
- **Presenter** (`XxxPresenting` protocol + `XxxPresenter`): `ObservableObject` with `@Published` state. It loads data via `Task { @MainActor ... }` from `viewDidLoad()` and stores `errorMessage` on failure.
- **View**: SwiftUI views in `Views/` (`Tabs/Users`, `Tabs/Photos`, `Home`, shared `Components` such as `GenericListView`). Views hold a presenter.
- **Router**: `Routers/*Router` types are static factories that build views and presenters and resolve interactors from the container. `HomeRouter.makeHomeView()` is the app's entry point, called from `ViperArchitectureApp.swift`. `UserListRouter.makeUserDetailView` builds navigation destinations.

### Dependency injection

`DI/AppContainer.swift` is the single Swinject container (`AppContainer.shared`). It registers `APIClient` (container-scoped singleton), the endpoints, and the interactors **by protocol**. Routers resolve from it. When adding a feature, register the new endpoint and interactor there, then add a router that resolves them. Presenters are constructed by routers, not the container.

### Conventions

- UI strings, spacing tokens (`Spacing`), and the base URL live in `Constants/Constants.swift`. Strings are global `UPPER_SNAKE_CASE` constants.
- Models in `Model/` (`User`, `Posts`, `Photo`, `Comments`) are `Decodable` types matching the JSONPlaceholder schema.
