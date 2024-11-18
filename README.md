Weather App

Packages used in this project 

Dependencies
The following dependencies are used in the project:

Alarm: For managing alarm functionalities.
Flutter Bloc: For state management.
Geolocator: For obtaining the user's current geographical position.
Permission Handler: For managing app permissions.

Permissions
Location Permission
Method: determinePosition()
Determines and returns the user's current geographical position.
Handles various states of location permissions:
Service disabled.
Permission denied.
Permission denied forever.
Android Notification Permission
Function: checkAndroidNotificationPermission()
Checks and requests notification permission if not granted.
Logs the permission status.
Android External Storage Permission
Function: checkAndroidExternalStoragePermission()
Checks and requests external storage permission if not granted.
Logs the permission status.
Android Schedule Exact Alarm Permission
Function: checkAndroidScheduleExactAlarmPermission()
Checks and requests the exact alarm scheduling permission if not granted.
Logs the permission status.

Utility Functions
determinePosition()
Obtains the user's current location.
Handles permission requests dynamically.



Instructions to Set Up and Run the App Locally
Follow these steps to set up and run the Weather App locally:

Prerequisites
Flutter Installed

Ensure you have Flutter installed on your system.
Refer to the Flutter installation guide for platform-specific instructions.
Dart SDK

The Dart SDK is bundled with Flutter. No separate installation is required.
Code Editor

Recommended: Visual Studio Code or Android Studio.
Dependencies

The following dependencies are required in your pubspec.yaml file:
alarm
flutter_bloc
geolocator
permission_handler
Device/Emulator

A physical device or emulator configured to run the app.
Steps to Set Up
Clone the Repository

Clone the project repository to your local machine using:
bash
Copy code
git clone <repository-url>
Replace <repository-url> with the actual repository link.
Navigate to the Project Directory


Run the following command to fetch all dependencies:

flutter pub get
Update AndroidManifest.xml

Open android/app/src/main/AndroidManifest.xml.
Ensure the following permissions are added:


<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
<uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />

Running the App
Launch Emulator or Connect Device

Start an emulator or connect a physical device via USB.
Ensure the device is recognized by Flutter using:

flutter devices
Run the App

Use the following command to start the app:

flutter run
Debug Mode

To run the app in debug mode and inspect logs, use:

flutter run --verbose
Build Release Version

To build a release APK for deployment:

flutter build apk --release
checkAndroidNotificationPermission()
Verifies and requests notification permissions for Android devices.

checkAndroidExternalStoragePermission()
Verifies and requests external storage permissions for Android devices.

checkAndroidScheduleExactAlarmPermission()
Verifies and requests exact alarm scheduling permissions for Android devices.
