# Bien Acá

A geolocator and geotracking project.

## Getting Started

```bash
cd bien-aca-mobile
# Initial installation
make install
# To run application
make run
# To run all commands at once
make all
```

## Build appbundle (testing for Android)
1. Go to: cd <app_dir>
  (Replace <app_dir> with your application’s directory.)

2. Run flutter build appbundle
  (Running flutter build defaults to a release build.)

For full docs, see https://flutter.dev/docs/deployment/android

## Build and release on TestFlight (testing for iOS)
1. Please check this settings are reviewed before building: https://flutter.dev/docs/deployment/ios#review-xcode-project-settings

2. Go to: cd <app_dir>
  (Replace <app_dir> with your application’s directory.)

3. Run flutter build ios to create a release build (flutter build defaults to --release).
   To ensure that Xcode refreshes the release mode configuration, close and re-open your Xcode workspace. For Xcode 8.3 and later, this step is not required.
   For more details, see https://flutter.dev/docs/deployment/ios#create-a-build-archive

4. Release the app on TestFlight https://flutter.dev/docs/deployment/ios#release-your-app-on-testflight

For full docs, see https://flutter.dev/docs/deployment/ios