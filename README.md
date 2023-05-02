# Firebase Analytics example

This project shows on to implement firebase_analytics to a flutter app and how to log events

## 📦 Packages

- [x] firebase_core
- [x] firebase_analytics 

## 🚀 Demo 1 (Firebase console - DebugView)

https://user-images.githubusercontent.com/36731875/235675275-b059b290-95e0-4449-a1c5-8f3f24ae4ce0.mp4

## 🚀 Demo 2 (Google Analytics console - Realtime overview)

https://user-images.githubusercontent.com/36731875/235675317-d1d152d3-3b7c-467b-bf66-e2d297bd6e95.mp4

---
## 📚 Below my written documentation (with links to official documetation)
--- 

# Setup analytics a flutter app

## Prerequisites

- A project on firebase console
- The app is linked to the firebase project and has initialized firebase correctly
- **firebase_analytics** dependencies in **pubspec.yaml**
- Add the ******************************firebase_analytics****************************** dependency in ********pubspec.yaml********

# Use the DebugView to verify that events are logged

[Official documentation](https://firebase.google.com/docs/analytics/debugview)

## What is the DebugView ?

In the Firebase console, click on the ******************DebugView****************** button

<img width="237" alt="CleanShot 2023-05-01 at 5 07 55@2x" src="https://user-images.githubusercontent.com/36731875/235675149-76932d29-c6d4-4939-8217-d1c2e2af0e23.png">

The debug view shows the logged events in real-time (in my experience expect at least 15 seconds up to 3 minutes delay to show events)

To send events to the DebugView instead of the true analytics dashboard, the app must be launched using Firebase Debug Mode

> Even with debug mode activated on android emulator or ios simulator, debugview does not show the logged events. Try to open the Google Firebase Analytics Realtime view to see the events [here](https://analytics.google.com/analytics/web/#/p373384317/realtime/overview?params=_u..nav%3Dmaui%26_u..comparisons%3D%5B%7B%22name%22:%22All%20Users%22,%22filters%22:%5B%7B%22isCaseSensitive%22:true,%22expression%22:%220%22,%22fieldName%22:%22audience%22%7D%5D%7D%5D&collectionId=app)
> 

## Enable debug mode on iOS

### **To enable Analytics debug mode on your development device:**

- Product > Scheme > Edit Scheme
- Click on ********Run Debug******** in the left panel
- Go to ********************Arguments******************** tab
- In the ******************************************Arguments Passed On Launch******************************************, add the following flag (with the - char!)

```bash
-FIRAnalyticsDebugEnabled
```

> **NB** : The ********************************************************-FIRAnalyticsDebugEnabled******************************************************** is equivalent as **-FIRDebugEnabled**, each of them enables the debug mode
> 

> **NB2** : Even if you uncheck/remove the **-FIRDebugEnabled** argument, the debug mode is still on until a disabled argument is set.
> 

### **To disable Analytics debug mode on your development device:**

- In the ******************************************Arguments Passed On Launch******************************************, add the following flag (with the - char!)

```bash
-noFIRAnalyticsDebugEnabled
```

> **NB** : The ********************************************************-noFIRAnalyticsDebugEnabled******************************************************** is equivalent as ************************************-FIRDebugDisabled************************************,  each of them disables the debug mode. (-********************************************************FIRAnalyticsDebugDisabled******************************************************** does not exist!). But you should use the ********************************************************-noFIRAnalyticsDebugEnabled******************************************************** in case you want Analytics verbose logging on and debug mode off. ************************************-FIRDebugDisabled************************************ will also disable verbose logging regardless of analytics verbose logging argument being on.
> 

### **Run the app to use debug mode**

Once the arguments setup is done, you might want to run the app via VSCode or Android Studio or even via CLI. You might see in your debug console that there are no logs about debug mode being on.

<aside>
⚠️ In my experience, I always have to run the app via Xcode once an argument has been added/checked/unchecked/remove. After one launch via Xcode, launching the flutter app via your IDE/CLI will do the same as launch via Xcode.

</aside>

> **NB** : The debug mode can still be on even on if the flutter app is launched in profile/release mode. Remember to uncheck/remove the arguments responsible of setting on the debug mode and launch once via Xcode to make sure the debug mode is disabled for future launches.
> 

## Enable debug mode on Android

[Official documentation](https://firebase.google.com/docs/analytics/debugview#enable_debug_mode)

To enable Analytics debug mode on an Android device, execute the following commands:

```bash
adb shell setprop debug.firebase.analytics.app PACKAGE_NAME
# PACKAGE_NAME can be found in android/app/build.gradle see applicationId
```

This behavior persists until you explicitly disable debug mode by executing the following command:

```bash
adb shell setprop debug.firebase.analytics.app .none.
```

The flutter app can be run from IDE, toggling on of off debug mode can be done even during runtime. There is no need to restart the app.

# Verbose loggging the logged events

At the moment (May 1st 2023), there is no verbose option or method on flutter FirebaseAnalytics package. We have access to verbose loggins via logcat (for android) or Xcode console (for iOS)

## Android

[Official documentation](https://firebase.google.com/docs/analytics/events?platform=android#view_events_in_the_android_studio_debug_log)

Run these command to print in terminal the logcat for analytics events

```bash
adb shell setprop log.tag.FA VERBOSE
adb shell setprop log.tag.FA-SVC VERBOSE
adb logcat -v time -s FA FA-SVC
```

## iOS

[Official documentation](https://firebase.google.com/docs/analytics/events?platform=ios#view_events_in_the_xcode_debug_console)

The analytics verbose logging must be enabled

- Open the **Runner.xcworkspace** in Xcode
- Product > Scheme > Edit Scheme
- Click on ********Run Debug******** in the left panel
- Go to ********************Arguments******************** tab
- In the ******************************************Arguments Passed On Launch******************************************, add the following flag (with the - char!)

```bash
--FIRAnalyticsVerboseLoggingEnabled
```

Then run your app in Xcode, verbose logs should be printed in Xcode console (filter by “FirebaseAnalytics” to see clearer)

# Troubleshooting

### iOS device in debug mode does not show up in DebugView on firebase console

1. Make sure to have `-FIRAnalyticsDebugEnabled` argument in your scheme
2. Remove the app from your device and re-run the app via Xcode
3. (recommended)Verify in the Xcode debug console that the debug mode is on.
    
    > **[FirebaseAnalytics][I-ACS024000] Debug mode is on**
    > 
4. Do the thing on your app to log one event
5. Your device should show up in the DebugView after a few seconds
