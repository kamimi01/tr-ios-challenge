# The challenge

## Develpment Environment

- Xcode 16.4
- iOS 18.5
- Device: iPhone 16 (Simulator)

## Packages I've used

|Package Name|Why|
|--|--|
|[SwiftLint](https://github.com/realm/SwiftLint)|To improve readability and maintenability by enforcing Swift style and conventions.|

## What I built beyond the core requirements

- **UI/UX**
  - Dark Mode support
  - Lightweight caching
    - Text data is cached, so previously loaded content is available offline (images not yet cached)
    - Pull-to-refresh triggers a revalidation to fetch the latest data
- **Unit Tests**
- **CI/CD**
  - Run unit tests in GitHub Actions via Fastlane
- **Development**
  - MVVM with a **partial** Clean Architecture (see Trade-offs)
  - SwiftLint for linting

## Tradeoffs in this project

### Partial vs Full Clean Architecture

Choice: Partial implementation (no Use Cases layer)

  ✅ Gains:
  - Less boilerplate code
  - Simpler to understand and maintain
  - Faster development
  - Appropriate for small project scope

  ❌ Loses:
  - Business logic mixed in ViewModels/Repositories
  - Less reusability of business rules
  - Harder to scale if app grows significantly

```
  Movie/
  ├── Presentation/     ✅ MVVM ViewModels + Views
  │   ├── MovieList/
  │   ├── MovieDetail/
  │   └── FavoriteMovie/
  ├── Data/             ✅ Repository pattern + Network layer
  │   ├── Network/
  │   └── Repositories/
  ├── Entities/         ✅ Domain models (Movie, MovieDetail)
  └── Application/      ✅ App entry point
```

## What I'd do next

- **UI/UX**
  - Show a “Last updated …” timestamp (update on successful revalidation; default view uses cached data)
  - Cache images as well (so posters/thumbnails show offline)
  - Add micro-interactions/animations for state changes (e.g., the heart button)
- **Development**
  - Adopt the `@Observable` macro to reduce boilerplate versus `ObservableObject`
  - Make the API base URL configurable via Info.plist / build configs to support multiple environments (dev/stg/prod)
  - Replace `print` with structured logging
- **Tests**
  - Add UI tests for critical flows (list → detail, favorite toggle, pull-to-refresh)

# Below this point is the original README ⬇️ 

## Goal
Build a simple movie browser app using **Swift 5+** and **SwiftUI**.  
Load a list of movies, navigate to a details screen, show recommended movies, and support “likes”.
Functionality and code quality matter more than pixel perfection.

## Requirements
- **Language & UI:** Swift 5+, SwiftUI.
- **Concurrency:** Use Swift Concurrency (`async/await`).
- **Package Management:** Swift Package Manager.
- **Architecture:** MVVM or a similarly clean pattern.
- **Networking:** Handle loading, error, and empty states gracefully.
- **Environment:** In your README, specify the **Xcode version**, **iOS version**, and **device/simulator model** you used for testing.
- **Repo:** Fork this repo and keep your fork public until review.

## API
- **List:**  
  `https://raw.githubusercontent.com/TradeRev/tr-ios-challenge/master/list.json`  

- **Details:**  
  `https://raw.githubusercontent.com/TradeRev/tr-ios-challenge/master/details/{id}.json`  

- **Recommended:**  
  `https://raw.githubusercontent.com/TradeRev/tr-ios-challenge/master/details/recommended/{id}.json`  

## What to Build
- **Movie List:** fetch and display the list.
- **Details Screen:** show details for a movie and its recommendations.
- **Navigation:** tapping a recommended movie opens its details.
- **Likes:** allow marking a movie as liked/favorited and reflect this state across list and details (persist locally; your choice of method).

## Bonus
- Unit tests.
- Lightweight caching (e.g., images or responses).
- Dark Mode support.
- Brief README notes on trade-offs and “what you’d do next”.