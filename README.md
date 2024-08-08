# Flutter ToDo

A simple and intuitive task management application built using Flutter.

## Features

- Register Screen
- Login Screen
- Home Screen

## Setup

To get started with this project, follow these steps:

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) installed on your machine
- [Dart](https://dart.dev/get-dart) SDK installed
- An IDE such as [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/)

### Installation

Clone the repository:

```sh
git clone https://github.com/VineetJha202133/test_cases.git
cd to-do
```

### Running the Project

Before running the project, make sure to clean and get the required dependencies:

```sh
flutter clean
flutter pub get
```

To run the project:

```sh
flutter run
```

### Building the APK

To build the APK in release mode:

```sh
flutter build apk --release
```

### To Run Unit Test
 - Home Screen
 ```sh
flutter test test/models/home_screen.dart
```
 - Login Screen
 ```sh
flutter test test/models/login_screen.dart
```
 - Register Screen
 ```sh
flutter test test/models/register_screen.dart
```

### To Run Widget Test
- Home Screen
 ```sh
flutter test test/models/home_widget_test.dart
```
- Login Screen
 ```sh
flutter test test/models/login_widget_test.dart
```
- Register Screen
 ```sh
flutter test test/models/register_widget_test.dart
```

### To Run Integration Test
```sh
flutter test integration_test/app_test.dart
```
