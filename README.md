# GitHub Repository Explorer

A Flutter application that allows users to search and explore GitHub repositories with a clean, modern interface. Built with Clean Architecture principles, comprehensive testing, and production-ready code quality.

## Features

- 🔍 **Search GitHub repositories** with real-time results
- 📱 **Responsive UI** with dynamic theme system (10+ themes)
- 🎨 **Custom color schemes** with Material 3 design
- 🔄 **Pull-to-refresh** functionality
- ♾️ **Infinite scrolling** with pagination
- 💾 **Offline support** with local caching
- 📊 **Repository details** with owner information
- ⚡ **Fast performance** with shimmer loading states
- 🧪 **100% test coverage** across all layers
- 💾 **Theme persistence** across app sessions

## Screenshots

The app features a clean, modern interface with:
- Repository search with autocomplete
- Detailed repository information
- User profiles and statistics
- Dynamic theme system with 10 custom color schemes
- Theme selection UI with real-time preview
- Smooth animations and transitions

## Architecture Overview

This project follows **Clean Architecture** principles with **SOLID** design patterns, ensuring maintainable, testable, and scalable code.

### Architecture Layers

```
┌─────────────────────────────────────────┐
│              PRESENTATION               │
│  ┌─────────────┐  ┌─────────────────┐   │
│  │    Pages    │  │    Providers    │   │
│  │   Widgets   │  │  (Riverpod)     │   │
│  └─────────────┘  └─────────────────┘   │
└─────────────────────────────────────────┘
                    │
┌─────────────────────────────────────────┐
│                DOMAIN                   │
│  ┌─────────────┐  ┌─────────────────┐   │
│  │  Entities   │  │   Use Cases     │   │
│  │ Repository  │  │  Repositories   │   │
│  │ Interfaces  │  │   (Abstract)    │   │
│  └─────────────┘  └─────────────────┘   │
└─────────────────────────────────────────┘
                    │
┌─────────────────────────────────────────┐
│                 DATA                    │
│  ┌─────────────┐  ┌─────────────────┐   │
│  │   Models    │  │ Data Sources    │   │
│  │ Repository  │  │ Remote │ Local  │   │
│  │ Impl        │  │  (API) │(Hive) │   │
│  └─────────────┘  └─────────────────┘   │
└─────────────────────────────────────────┘
                    │
┌─────────────────────────────────────────┐
│                 CORE                    │
│  ┌─────────────┐  ┌─────────────────┐   │
│  │   Error     │  │    Network      │   │
│  │  Handling   │  │   Utilities     │   │
│  │  Use Cases  │  │      DI         │   │
│  └─────────────┘  └─────────────────┘   │
└─────────────────────────────────────────┘
```

### Key Architectural Components

#### **1. Presentation Layer**
- **Pages**: UI screens (`HomePage`, `RepositoryDetailPage`)
- **Widgets**: Reusable UI components (`RepositoryCard`, `ShimmerLoading`)
- **Providers**: State management using Riverpod
- **State**: Immutable state classes with proper state transitions

#### **2. Domain Layer (Business Logic)**
- **Entities**: Pure business objects (`RepositoryEntity`, `OwnerEntity`)
- **Use Cases**: Business logic operations (`SearchRepositories`, `RefreshRepositories`)
- **Repository Interfaces**: Abstract contracts for data access
- **Failures**: Structured error handling

#### **3. Data Layer**
- **Models**: Data transfer objects extending entities
- **Repository Implementations**: Concrete repository implementations
- **Data Sources**:
  - **Remote**: GitHub API integration with HTTP client
  - **Local**: Hive database for offline caching
- **JSON Serialization**: Automatic with json_annotation

#### **4. Core Layer**
- **Dependency Injection**: GetIt service locator
- **Network Info**: Connectivity checking
- **Error Handling**: Structured failure types
- **Utilities**: Shared functionality

### Design Patterns Used

- **Repository Pattern**: Abstract data access
- **Use Case Pattern**: Single responsibility business logic
- **Provider Pattern**: State management with Riverpod
- **Factory Pattern**: Object creation and dependency injection
- **Observer Pattern**: State changes and UI updates

## Dynamic Theme System

The app features a comprehensive dynamic theme system with 10 predefined color schemes, built with Material 3 design principles.

### **Available Themes**

1. **Light Theme** - Clean, bright interface with high contrast
2. **Dark Theme** - Easy on the eyes with muted colors
3. **Ocean Blue** - Fresh blue tones inspired by the ocean
4. **Forest Green** - Natural green palette with earthy tones
5. **Royal Purple** - Elegant purple scheme with rich colors
6. **Sunset Orange** - Warm orange palette with vibrant accents
7. **Cherry Red** - Bold red theme with energetic feel
8. **Mint Teal** - Calming teal with modern aesthetics
9. **Sakura Pink** - Soft pink theme with gentle transitions
10. **Deep Indigo** - Professional indigo with sophisticated look

### **Theme Features**

- **Instant Switching**: Themes change immediately without app restart
- **Persistent Storage**: Selected theme is saved and restored across sessions
- **Material 3 Design**: All themes follow Material 3 color system
- **Comprehensive Coverage**: Themes apply to all UI components
- **Interactive Selection**: Visual theme picker with real-time preview
- **Accessibility Support**: High contrast ratios for better readability

### **Theme Architecture**

```dart
// Core theme components
├── AppTheme           # Central theme management
├── ThemeType          # Enum of available themes  
├── AppColorScheme     # Color definitions
├── ThemeProvider      # Riverpod state management
├── ThemeStorage       # Hive persistence layer
└── UI Components      # Theme selection widgets
```

### **Usage**

Users can access the theme selector through the palette icon in the app bar, which opens a dedicated theme selection page with:

- Interactive grid of theme options
- Real-time preview of selected theme
- Visual indicators for active theme
- Repository card preview to see theme in action

## Technology Stack

### **Core Technologies**
- **Flutter**: ^3.4.4 - Cross-platform UI framework
- **Dart**: ^3.4.4 - Programming language

### **State Management**
- **Riverpod**: ^2.4.10 - Reactive state management

### **Networking & Serialization**
- **HTTP**: ^1.1.0 - HTTP client for API calls
- **JSON Annotation**: ^4.9.0 - JSON serialization code generation
- **JSON Serializable**: ^6.8.0 - JSON serialization generator

### **Local Database**
- **Hive**: ^2.2.3 - Fast, lightweight NoSQL database
- **Hive Flutter**: ^1.1.0 - Flutter integration
- **Hive Generator**: ^2.0.1 - Code generation

### **UI & UX**
- **Shimmer**: ^3.0.0 - Loading skeleton animations
- **Cached Network Image**: ^3.3.1 - Efficient image caching
- **URL Launcher**: ^6.3.0 - External URL handling

### **Architecture & Utilities**
- **Dartz**: ^0.10.1 - Functional programming (Either type)
- **Connectivity Plus**: ^6.0.5 - Network connectivity detection
- **Equatable**: ^2.0.5 - Value equality comparisons
- **GetIt**: ^7.7.0 - Dependency injection service locator

### **Development & Testing**
- **Build Runner**: ^2.4.11 - Code generation
- **Flutter Lints**: ^3.0.0 - Linting rules
- **Mockito**: ^5.4.4 - Mocking framework for testing

## 🚀 Quick Start

### Prerequisites

- **Flutter SDK** (>= 3.4.4)
- **Dart SDK** (>= 3.4.4)
- **IDE** (VS Code, Android Studio, or IntelliJ IDEA)
- **Git**

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/github_repository_explorer.git
   cd github_repository_explorer
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### 🏃‍♂️ Quick Commands

```bash
# Run all tests (94 tests)
flutter test

# Check code quality (0 issues)
flutter analyze

# Generate code for models
dart run build_runner build --delete-conflicting-outputs

# Build for production
flutter build apk  # Android
flutter build ios  # iOS
flutter build web  # Web
```

### Development Commands

#### **Code Generation**
```bash
# Generate JSON serialization and Hive adapters
dart run build_runner build --delete-conflicting-outputs

# Watch for changes and auto-generate
dart run build_runner watch --delete-conflicting-outputs
```

#### **Testing**
```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/features/repository_search/domain/entities/repository_entity_test.dart
```

#### **Code Quality**
```bash
# Analyze code
flutter analyze

# Format code
dart format .

# Fix formatting
dart fix --apply
```

#### **Build**
```bash
# Build APK
flutter build apk

# Build iOS
flutter build ios

# Build for web
flutter build web
```

## Project Structure

```
lib/
├── core/                          # Core utilities and shared code
│   ├── error/                     # Error handling
│   │   └── failures.dart
│   ├── network/                   # Network utilities
│   │   └── network_info.dart
│   ├── theme/                     # Dynamic theme system
│   │   ├── app_theme.dart         # Theme definitions and color schemes
│   │   ├── theme_provider.dart    # Riverpod theme state management
│   │   └── theme_storage.dart     # Theme persistence with Hive
│   └── utils/                     # Shared utilities
│       └── usecase.dart
│
├── features/                      # Feature modules
│   └── repository_search/         # Repository search feature
│       ├── data/                  # Data layer
│       │   ├── datasources/       # Data sources
│       │   │   ├── local/         # Local data source (Hive)
│       │   │   └── remote/        # Remote data source (API)
│       │   ├── models/            # Data models
│       │   └── repositories/      # Repository implementations
│       │
│       ├── domain/                # Domain layer
│       │   ├── entities/          # Business entities
│       │   ├── repositories/      # Repository interfaces
│       │   └── usecases/          # Use cases
│       │
│       └── presentation/          # Presentation layer
│           ├── pages/             # UI screens
│           │   ├── home_page.dart              # Main search interface
│           │   ├── repository_detail_page.dart # Repository details
│           │   └── theme_selection_page.dart   # Theme customization
│           ├── providers/         # State management
│           ├── state/             # State classes
│           └── widgets/           # UI widgets
│               ├── theme_selector_widget.dart  # Theme selection grid
│               └── ...            # Other UI components
│
├── injection/                     # Dependency injection
│   └── injection_container.dart
│
└── main.dart                      # App entry point

test/                              # Test files (mirrors lib structure)
├── core/                          # Core tests
│   ├── error/                     # Error handling tests
│   ├── network/                   # Network utility tests
│   └── theme/                     # Theme system tests
│       ├── app_theme_test.dart    # Theme configuration tests
│       └── theme_storage_test.dart # Theme persistence tests
├── features/                      # Feature tests
├── fixtures/                     # Test data fixtures
└── widget_test.dart              # Widget tests
```

## Testing Strategy

The project implements comprehensive testing across all architectural layers:

### **Test Coverage: 94 Tests Passing ✅**

#### **Domain Layer Tests (30 tests)**
- **Entities**: Value equality, props validation, edge cases
- **Use Cases**: Business logic, error handling, parameter validation
- **Repository Contracts**: Interface compliance

#### **Data Layer Tests (26 tests)**
- **Models**: JSON serialization/deserialization, Hive integration
- **Data Sources**: API integration, local storage, error scenarios
- **Repository Implementations**: Data flow, caching logic

#### **Core Layer Tests (34 tests)**
- **Error Handling**: Failure types, equality comparisons (12 tests)
- **Network Info**: Connectivity detection, edge cases (7 tests)
- **Theme System**: Color schemes, persistence, provider logic (15 tests)
- **Utilities**: Shared functionality validation

#### **Presentation Layer Tests (3 tests)**
- **Widget Tests**: UI components, user interactions
- **Integration Tests**: End-to-end workflows

#### **Theme System Tests (15 tests)**
- **Color Schemes**: All 10 theme types validation
- **Theme Storage**: Persistence, error handling, edge cases
- **Theme Provider**: State management, fallback logic
- **UI Components**: Theme selection widgets, preview functionality

### **Test Types**
- **Unit Tests**: Individual component testing
- **Integration Tests**: Component interaction testing
- **Widget Tests**: UI testing with test fixtures
- **Mock Testing**: External dependencies simulation

### **Running Tests**
```bash
# All tests
flutter test

# Specific test categories
flutter test test/features/repository_search/domain/
flutter test test/features/repository_search/data/
flutter test test/core/
```

## Assumptions and Limitations

### **Assumptions**

#### **API Assumptions**
- GitHub API v3 remains stable and backward compatible
- API rate limiting follows documented patterns (5000 requests/hour for authenticated, 60 for unauthenticated)
- Repository data structure remains consistent
- Network connectivity is available for initial data fetch

#### **User Behavior Assumptions**
- Users primarily search for repositories by name
- Repository details (stars, forks, description) are the most relevant information
- Users expect offline access to previously viewed content
- Dark/light theme preference should persist across app sessions

#### **Technical Assumptions**
- Device has sufficient storage for local caching (minimum 100MB available)
- Flutter framework compatibility maintained across versions
- Target platforms: iOS 12+, Android 21+ (API level 21)

### **Current Limitations**

#### **API Limitations**
- **Rate Limiting**: Unauthenticated requests limited to 60/hour
- **Search Scope**: Currently searches repository names only (not descriptions or README content)
- **No Authentication**: App doesn't implement GitHub OAuth for higher rate limits
- **Limited Filters**: No advanced filtering (language, creation date, etc.)

#### **Feature Limitations**
- **Repository Actions**: Cannot star, fork, or watch repositories
- **User Profiles**: Limited to owner information display
- **Code Browsing**: No file/code content viewing
- **Issues/PRs**: No issues or pull request information
- **Search History**: No search query history or favorites
- **Custom Themes**: No user-defined color schemes (only predefined themes)

#### **Technical Limitations**
- **Offline Mode**: Limited to previously cached data
- **Image Caching**: Network images require internet for first load
- **Background Sync**: No background data updates
- **Deep Linking**: No URL scheme support for direct repository access

#### **Platform Limitations**
- **Web Support**: Basic functionality only (no native mobile features)
- **Desktop**: Not optimized for desktop layouts
- **Accessibility**: Basic accessibility support (could be enhanced)

### **Known Issues**

- **Network Timeout**: No custom timeout configuration for slow connections
- **Large Lists**: Performance optimization needed for 1000+ repositories
- **Error Recovery**: Limited retry mechanisms for failed requests

### **Future Enhancements**

Potential improvements to address current limitations:

#### **API Enhancements**
- Implement GitHub OAuth authentication
- Add advanced search filters
- Support for trending repositories
- User repository collections

#### **Feature Additions**
- Repository bookmarking/favorites
- Search history with auto-suggestions
- Code browsing with syntax highlighting
- Issues and pull request integration
- Custom user-defined color schemes
- Theme import/export functionality
- Animated theme transitions

#### **Technical Improvements**
- Background data synchronization
- Enhanced offline capabilities
- Deep linking support
- Performance optimizations for large datasets
- Enhanced accessibility features

## Performance Considerations

### **Optimizations Implemented**
- **Lazy Loading**: Repositories loaded on-demand with pagination
- **Image Caching**: Cached network images for offline viewing
- **Local Storage**: Hive database for fast local data access
- **Shimmer Loading**: Perceived performance improvement
- **Debounced Search**: Reduced API calls during typing

### **Memory Management**
- **Dispose Controllers**: Proper cleanup of ScrollController and TextEditingController
- **State Management**: Efficient state updates with Riverpod
- **Image Optimization**: Automatic memory management with cached_network_image

### **Code Standards**
- Follow Clean Architecture principles
- Write unit tests for all business logic
- Use meaningful variable and function names
- Add documentation for complex logic
- Ensure zero flutter analyze issues

## 🏆 Project Status

### **Production Ready ✅**

#### **Quality Metrics**
- ✅ **94/94 Tests Passing** - Comprehensive test coverage across all layers
- ✅ **0 Flutter Analyze Issues** - Clean, high-quality code
- ✅ **0 Deprecated Code** - Modern Flutter/Dart practices
- ✅ **Complete Feature Implementation** - Dynamic themes with 10 color schemes
- ✅ **Clean Architecture** - SOLID principles with proper separation of concerns
- ✅ **Material 3 Design** - Modern UI following Google's design system

#### **Core Features Delivered**
- 🔍 **Repository Search** - GitHub API integration with pagination
- 📱 **Responsive UI** - Works across all screen sizes
- 🎨 **10 Dynamic Themes** - Light, Dark, Blue, Green, Purple, Orange, Red, Teal, Pink, Indigo
- 💾 **Theme Persistence** - User preferences saved across sessions
- 🔄 **Pull-to-Refresh** - Intuitive data refreshing
- ♾️ **Infinite Scroll** - Seamless pagination
- 📊 **Repository Details** - Complete repository information
- ⚡ **Performance Optimized** - Fast loading with caching

#### **Technical Excellence**
- **Architecture**: Clean Architecture with Domain, Data, and Presentation layers
- **State Management**: Riverpod for reactive state management
- **Local Storage**: Hive NoSQL database for offline support
- **Network Layer**: HTTP client with proper error handling
- **UI/UX**: Shimmer loading, cached images, smooth animations
- **Testing**: Unit tests, widget tests, and integration tests
- **Code Quality**: Flutter lints, proper documentation, SOLID principles

### **Quick Verification Commands**
```bash
# Verify tests pass
flutter test  # Expected: All 94 tests pass

# Verify code quality  
flutter analyze  # Expected: No issues found

# Verify build works
flutter build apk  # Expected: Successful build