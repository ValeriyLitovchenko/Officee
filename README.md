#  Officee

## Version

### 1.0

## Build and Runtime Requirements

+ Xcode 13.4 or later
+ iOS 14.0 or later
+ MacOS macOS 12.3 or later


## Code Style

For code style used [`SwiftLint`](https://github.com/realm/SwiftLint). <br>
Definition from the oficial documentation: <br>

> A tool to enforce Swift style and conventions, loosely based on the now archived GitHub Swift Style Guide.

<br>
Install `SwiftLint` via Homebrew

```
brew install swiftlint
```

## About Officee

Application for office workers allow them to observe all their colleagues contact details and which rooms in the office are currently occupied for meetings.

## Project infrastructure

Project consists of three modules:
- `Officee` - contains [Network Layer](/Officee/Officee/Infrastructure/Network/), [Core Data Storage](/Officee/Officee/Infrastructure/CoreData/) and Domain models.
- `OfficeeiOSCore` - contains [Base Scene Classes](/Officee/OfficeeiOSCore/BaseSceneClasses/) and [Base Table View Scene Classes](/Officee/OfficeeiOSCore/BaseTableViewSceneClasses/) for building scene.
- `OfficeeApp` - contains all `Officee` application files.

## How to use app

After opening the app and passing splash screen user will see Home screen with available `People` and `Rooms` tabs and preselected People tab. User can search through `People` by name as well as through the `Rooms` and view person details. To activate search simply tap the search button at the right of the top bar. Also user can send an email to colleague from Person details screen by tapping compose button at the right of the top bar.
