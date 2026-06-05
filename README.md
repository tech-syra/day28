<div align="center">
  <img src="assets/icon.png.png" width="120" height="120" alt="App Icon"/>
  <h1>Luxe Store</h1>
  <p><strong>A premium, glassmorphism-inspired e-commerce experience built with Flutter.</strong></p>
</div>

<br>

Designed with an intense focus on modern UX/UI, Luxe Store delivers a premium shopping experience featuring crystal-clear glassmorphism, fluid animations, and a stark, OLED-friendly dark mode aesthetic. 

---

## ✨ Features
*   **Crystal Glassmorphism UI:** Custom-built `CrystalGlassContainer` and liquid app bars that softly blur background elements for a highly premium, 3D frosted glass look.
*   **Dynamic Animations:** Staggered list entrances, fluid background gradient blobs, and micro-interactions powered by `flutter_animate`.
*   **Reactive State Management:** Fully type-safe and performant state management using **Riverpod** ensuring instantaneous cart updates.
*   **Persistent Offline Cart:** Your cart and user preferences are safely stored locally using **Hive** and **SharedPreferences**.
*   **Clean Architecture:** Highly scalable folder structure separating Features (Auth, Cart, Products) and Core utilities.
*   **Deep Dark Mode:** Tailored specifically for modern OLED screens, providing maximum contrast and battery efficiency.

## 🛠 Tech Stack
*   **Framework:** Flutter (Dart)
*   **State Management:** Riverpod (`flutter_riverpod`, `riverpod_annotation`)
*   **Routing:** GoRouter
*   **Networking:** Dio
*   **Local Storage:** Hive, SharedPreferences, Flutter Secure Storage
*   **UI & Animations:** Google Fonts, Lucide Icons, Flutter Animate

## 📱 System Requirements
*   **Minimum Android SDK:** API 21 (Android 5.0) or higher
*   **Minimum iOS Version:** iOS 12.0 or higher
*   **Flutter SDK:** v3.7.2 or higher

---

## 🚀 Getting Started

### Option A: Download ZIP (Easiest)
1. On this GitHub page, click the green **Code** button and select **Download ZIP**.
2. Extract the downloaded ZIP file to a folder on your computer.
3. Open Android Studio or VS Code.
4. Go to `File > Open...` and select the extracted folder.
5. Open a terminal inside the IDE and run `flutter pub get` to install dependencies.
6. Run the app on your emulator or physical device (`flutter run`).

### Option B: Using Git
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/day28.git
   cd day28
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the App:
   ```bash
   flutter run
   ```

---

## 📸 Screenshots

| Splash / Home | Cart Screen | Product Details | Profile |
|:---:|:---:|:---:|:---:|
| <img src="assets/screenshots/home.png" width="200"/> | <img src="assets/screenshots/cart.png" width="200"/> | <img src="assets/screenshots/detail.png" width="200"/> | <img src="assets/screenshots/profile.png" width="200"/> |

*(Note: Replace the screenshot paths above with your actual images once uploaded to GitHub)*

## 🎥 Demo Video

[Watch the Demo Video](assets/screenshots/demo.mp4)
*(Note: The demo video runs at a crisp 60fps in high resolution, showcasing the liquid glass background animations!)*

---

## 📦 APK Download
[⬇️ Download Latest APK](#)

> **Note:** When downloading, Google Drive may show a warning saying "Google Drive can't scan this file for viruses". Please click "Download anyway" — this is normal for all APK files.

---

## 🎯 Submission Note
This project was designed to push the boundaries of Flutter UI capabilities, specifically focusing on highly performant **BackdropFilters** and complex gradient shadows to achieve an authentic crystal glass effect without dropping frames.
