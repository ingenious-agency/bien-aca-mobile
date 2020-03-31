# quarantine_control

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Build appbundle (testing for Android)
1. Enter cd <app dir>
  (Replace <app dir> with your application’s directory.)

2. Run flutter build appbundle
  (Running flutter build defaults to a release build.)

For full docs, see https://flutter.dev/docs/deployment/android

## Build and release on TestFlight (testing for iOS)
1. Please check this settings are reviewed before building: https://flutter.dev/docs/deployment/ios#review-xcode-project-settings

2. Run flutter build ios to create a release build (flutter build defaults to --release).
   To ensure that Xcode refreshes the release mode configuration, close and re-open your Xcode workspace. For Xcode 8.3 and later, this step is not required.
   For more details, see https://flutter.dev/docs/deployment/ios#create-a-build-archive

3. Release the app on TestFlight https://flutter.dev/docs/deployment/ios#release-your-app-on-testflight

For full docs, see https://flutter.dev/docs/deployment/ios