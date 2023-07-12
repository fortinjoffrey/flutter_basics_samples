# Google Sign In in Flutter Application

How to implement Google Sign In in Flutter from scratch

## Demo

https://github.com/fortinjoffrey/flutter_basics_samples/assets/36731875/043c7226-3b93-4f78-bbac-919d72cf4fa2

## Implementation steps

1. Create a flutter app (or use an existing one)
2. Create a new project in Firebase console (or use an existing one)
3. Make sure to have a unique application identifier before continuing further
4. Follow the documentation to integrate Firebase in a Flutter app (add Flutter app to Firebase console and use Firebase CLI)
5. (iOS only) 

Add the CFBundleURLTypes attributes below into the [my_project]/ios/Runner/Info.plist file
```
<key>CFBundleURLTypes</key>
<array>
	<dict>
		<key>CFBundleTypeRole</key>
		<string>Editor</string>
		<key>CFBundleURLSchemes</key>
		<array>
			<!-- TODO Replace this value: -->
			<!-- Copied from GoogleService-Info.plist key REVERSED_CLIENT_ID -->
			<string>com.googleusercontent.apps.861823949799-vc35cprkp249096uujjn0vvnmcvjppkn</string>
		</array>
	</dict>
</array>
```

6. Implement the dart code to use Google Sign In
7. In order to sign in with google in debug mode, your need to put your debug SHA1 key into your Android app in Firebase

To get your debug SHA1 key (password: android)

```
keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore
```

8. Create an upload keystore (ignore this step if you already have one)

**Why ?**
A keystore is mandatory in order to sign our app to generate a release app bundle that will be uploaded into the Google Play Console

**How ?**

(replace "\<project-path\>" by any path you want )

```
keytool -genkey -v -keystore ./<project-path>/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

This wil create a .jks file in the specified path. Do not put this file in your VCS (like git)

We want the keystore to be used by the android building system to automatically sign our application

- Create a file named **key.properties** in android/ directory

  ```bash
  storePassword=<password-from-previous-step>
  keyPassword=<password-from-previous-step>
  keyAlias=upload
  storeFile=<keystore-file-location>
  ```

- Configure gradle to use your upload key when building your app in release mode by editing the `[project]/android/app/build.gradle` file.

  1. Add the keystore information from your properties file before the `android` block:

     ```
     def keystoreProperties = new Properties()
     def keystorePropertiesFile = rootProject.file('key.properties')
     if (keystorePropertiesFile.exists()) {
         keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
     }

     android {
       ...
     }
     ```

  2. Create a release signinConfiguration

     ```
     signingConfigs {
           release {
               keyAlias keystoreProperties['keyAlias']
               keyPassword keystoreProperties['keyPassword']
               storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
               storePassword keystoreProperties['storePassword']
           }
       }
       buildTypes {
           release {
               signingConfig signingConfigs.release
           }
       }

     ```

Release builds of your app will now be signed automatically.

    Note: You might need to run `flutter clean` after changing the gradle file. This prevents cached builds from affecting the signing process.

<br>
9. In order for google sign in to work in release mode, the app signing SHA1 key provided by Google has to be in your Firebase Android application SHA certificate fingerprints

To get the google SHA1 app signing key SHA1 key

- On Google Play Console, go to your app > Setup > App Integrity > App Signing
- Copy the **SHA-1 certificate fingerprint** in the **App signing key certificate** section

10. Rerun the flutterfire config command to get the latest firebase project modifications

Google Sign In should now work in debug and release mode
