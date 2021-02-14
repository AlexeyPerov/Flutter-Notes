# Notes

An example Flutter Notes management app backed by Firebase Firestore

Uses Async Redux (https://pub.dev/packages/async_redux) as a state management approach


![plot](./notes_screenshot.png)

## How to use

### Firebase Account

* Create one at https://firebase.google.com/
* Add apps that you need (iOS/Android/Web)

### Setup it up in your project

* add google-services.json for Android
* add GoogleService-Info.plist for iOS
* add firebaseConfig.js near index.html which should contain code like this:

```javascript
var firebaseConfig = {
    apiKey: "..",
    authDomain: "..",
    projectId: "..",
    storageBucket: ".",
    messagingSenderId: "..",
    appId: "..",
    measurementId: ".."
};

firebase.initializeApp(firebaseConfig);
```

## To build and host Web client use
* cd project_folder
* flutter build web  
* firebase deploy --only hosting

TODO:
- Add Firebase auth
- Serialize/deserialize database entities directly to/from Dart classes
- Settings panel for themes switch
