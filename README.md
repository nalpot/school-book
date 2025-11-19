# SchoolBook

A Flutter application for accessing electronic school textbooks, providing students with a complete, easy, and free collection of educational books.

## Features

### 📚 Core Functionality
- **Library Management**: Personal collection of downloaded books
- **Explore**: Browse and discover available textbooks
- **Download Manager**: Track and manage book downloads
- **Theme Switcher**: Light and dark mode support
- **Settings**: Customizable app preferences

### 🎨 UI/UX
- Material Design 3
- Custom color scheme (Primary: `#F8B631`, Secondary: `#006600`)
- Responsive grid layouts for book displays
- Smooth navigation with drawer menu
- Tab-based dashboard interface

### 🏗️ Architecture
- **State Management**: BLoC pattern with flutter_bloc
- **Dependency Injection**: GetIt for service locator pattern
- **Navigation**: GoRouter for declarative routing
- **Type Safety**: Custom safe_convert utilities for JSON parsing

## Getting Started

### Prerequisites
- Flutter SDK 3.7.2 or higher
- Dart 3.7.2 or higher

### Installation

1. Clone the repository
```bash
git clone <repository-url>
cd schoolbook
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

## Project Structure
```
lib/
├── core/
│   ├── blocs/
│   │   └── theme/           # Theme management BLoC
│   ├── utils/
│   │   └── safe_convert.dart # Type-safe JSON utilities
│   ├── widget/
│   │   └── text_logo.dart   # Reusable logo widget
│   ├── di.dart              # Dependency injection setup
│   └── theme.dart           # App theme configuration
├── features/
│   ├── splash/
│   │   ├── di/
│   │   └── presentation/
│   ├── dashboard/
│   │   └── presentation/
│   │       ├── pages/
│   │       │   ├── dashboard_page.dart
│   │       │   ├── library_page.dart
│   │       │   └── explore_page.dart
│   │       └── widgets/
│   │           └── drawer.dart
│   ├── download/
│   ├── setting/
│   └── about/
├── routes/
│   ├── app_route.dart       # Route configuration
│   └── app_route_path.dart  # Route path definitions
└── main.dart
```

## Key Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| flutter_bloc | ^9.1.1 | State management |
| equatable | ^2.0.7 | Value equality |
| get_it | ^9.0.5 | Dependency injection |
| go_router | ^17.0.0 | Declarative routing |
| cupertino_icons | ^1.0.8 | iOS-style icons |

## Development

### Code Quality
The project uses `very_good_analysis` ^8.0.0 for comprehensive linting rules:
- Enforced relative imports within `lib/`
- Mandatory documentation for public APIs (configurable)
- Single quotes preference
- Sorted pub dependencies

### Coding Standards
- Type-safe JSON parsing with `safe_convert` utilities
- BLoC pattern for state management
- Dependency injection for testability
- Feature-based modular architecture

## Routes

| Route | Path | Description |
|-------|------|-------------|
| Splash | `/splash` | Initial loading screen |
| Dashboard | `/` | Main screen with Library/Explore tabs |
| Download | `/download` | Download management |
| Setting | `/setting` | App settings and preferences |
| About | `/about` | App information |

## Theme

### Light Mode
- Primary: `#F8B631` (Yellow)
- Secondary: `#006600` (Green)
- Scaffold: White

### Dark Mode
- Primary: `#F8B631` (Yellow)
- Secondary: `#045535` (Dark Green)
- Scaffold: Black

## Configuration

### Android
- Cleartext traffic enabled for development
- Minimum SDK: As per Flutter requirements

### Assets
- Custom font: Nunito Sans
- Book cover images in `assets/images/`

## Safe Convert Utilities

The project includes comprehensive type-safe conversion utilities:
```dart
// Direct conversions
int value = toInt(dynamic, defaultValue: 0);
double value = toDouble(dynamic, defaultValue: 0.0);
bool value = toBool(dynamic, defaultValue: false);

// JSON extractors
int id = asInt(json, 'id');
String name = asString(json, 'name', defaultValue: 'Unknown');
List<int> ids = asListInt(json, 'ids');
```

## License

This project is licensed under the BSD 3-Clause License - see the LICENSE file for details.

## Version

**Current Version**: 1.0.0 (1)

---

**Note**: This application is designed to provide free access to educational materials for students.
