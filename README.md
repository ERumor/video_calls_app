## About

Video Calls App.

Audio/video calling app. The user registers in the application, logs into the application and can call other users.

## Documentation

**Features:**

- **Login Screen:** The user is authorized in the application if already registered, user data is stored on the server.
- **Signup Screen:** A new user registers with the app and can then log into the app and use it to make calls.
- **Main Screen:** After authorization, the user is taken to the main screen of the application, where all users of the application are now displayed. Requests the necessary permissions for the application to work successfully, such as audio recording, camera. It is possible to make audio or video calls to other users.
  
**Stack:**
- Visual Studio Code, Flutter/Dart, Firebase, Firestore, Zegocloud.

**Packages used:** 
-   firebase_core: ^2.24.2
  firebase_auth: ^4.16.0
  cloud_firestore: ^4.14.0
  flutter_screenutil: ^5.6.0
  zego_express_engine: ^3.12.4
  zego_uikit_prebuilt_call: ^4.1.9
  zego_uikit_signaling_plugin: ^2.7.4.

Here are the permissions that an app needs on Xiaomi devices for reference:

- Show on locked screen: Switch to Enable
- Display pop-up windows while running in the background: Switch to Enable
- Display pop-up window: Switch to Enable

## Application show:

| <img src="https://github.com/ERumor/video_calls_app/assets/57027295/8d7c10d1-e6e0-47fa-96a0-a3dab6e5bd30" width="250"/> | <img src="https://github.com/ERumor/video_calls_app/assets/57027295/a1b71a86-bdb4-4cd0-b6e4-ef13bbf9b4e3" width="250"/> | <img src="https://github.com/ERumor/video_calls_app/assets/57027295/3f2b4e2a-d347-4a0c-8d76-ada1aad35eb2" width="250"/> |
| :---: | :---: | :---: |
| Login Screen  | Signup Screen  | Successful Signup |
|<img src="https://github.com/ERumor/video_calls_app/assets/57027295/6b038513-dde7-4d82-88f8-2e7e58726eb2" width="250"/> | <img src="https://github.com/ERumor/video_calls_app/assets/57027295/37812da5-c0ed-45b8-9c10-2ed2afa863ea" width="250"/> | <img src="https://github.com/ERumor/video_calls_app/assets/57027295/d1728715-e6aa-4f13-9787-2a17543d1bbe" width="250"/> |
| Main Screen | Calling | Call invitation |
| <img src="https://github.com/ERumor/video_calls_app/assets/57027295/3e2cf1b7-d865-486c-8a69-26f7a4750e60" width="250"/> | <img src="https://github.com/ERumor/video_calls_app/assets/57027295/fc72d419-0847-4ffb-8027-ebce09d99fd8" width="250"/> | <img src="https://github.com/ERumor/video_calls_app/assets/57027295/ee3eadfe-9d30-4481-8003-ca26a6b9ca29" width="250"/> |
| Audio Call | Video Call | Video Call |
|<img src="https://github.com/ERumor/video_calls_app/assets/57027295/08de6a9d-fe64-4d6e-a282-3c3c9dbd27fb" width="250"/> | <img src="https://github.com/ERumor/video_calls_app/assets/57027295/353a6d7c-21c1-4c6d-9771-bed3ea9d0ba9" width="250"/> | <img src="https://github.com/ERumor/video_calls_app/assets/57027295/02b48d53-072b-4636-926c-4d668292a563" width="250"/> |
| Accidental pressing back | Accidental pressing back | Accidental pressing back |
|<img src="https://github.com/ERumor/video_calls_app/assets/57027295/853ecd78-0da6-437d-b980-ee9138618494" width="250"/> | <img src="https://github.com/ERumor/video_calls_app/assets/57027295/bf3df80a-57d7-40d6-bbb6-0ab6b0b66e4e" width="250"/> | <img src="https://github.com/ERumor/video_calls_app/assets/57027295/521442a2-da78-4d1b-843e-01cd5ea0a32f" width="250"/> |
| Permissions | Wrong Pass or Email | Wrong Pass |
