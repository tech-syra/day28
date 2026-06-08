<div align="center">
  <img src="assets/icon.png.png" width="120" height="120" alt="App Icon"/>
  <h1>Luxe Store</h1>
  <p><strong>A premium, glassmorphism-inspired e-commerce experience built with Flutter.</strong></p>
</div>

<br>

Designed with an intense focus on modern UX/UI, Luxe Store delivers a premium shopping experience featuring crystal-clear glassmorphism, fluid animations, and a stark, OLED-friendly dark mode aesthetic. 

---

## ✨ Features
*   **Real-Time Product Catalog:** Browse a dynamic list of products fetched instantly via our `Dio` network layer.
*   **Detailed Product Views:** Tap into any product to view full-resolution imagery, deep descriptions, and pricing details.
*   **Persistent Shopping Cart:** Add or remove items, adjust quantities, and instantly view your checkout total. Cart state is saved offline using **Hive**.
*   **Localization Support:** Seamlessly switch between multiple languages dynamically.
*   **User Profiles:** Interactive profile screens for users to manage their details and avatars.
*   **Premium Glassmorphism UI:** Custom-built crystal glass containers, fluid gradient blobs, and staggered list animations (`flutter_animate`) for a gorgeous, 60fps OLED-friendly shopping experience.
*   **Reactive State Management:** Fully type-safe and highly scalable state management powered by **Riverpod**.

## 🛠 Tech Stack
*   **Framework:** Flutter 3.29.2 (Dart)
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

## Home 
<img width="324" height="720" alt="screenshot_20260605-181149_720" src="https://github.com/user-attachments/assets/37121051-e6ed-4fee-8dae-1ea4f823c8b2" />

## Cart Screen
<img width="324" height="720" alt="screenshot_20260605-181508_720" src="https://github.com/user-attachments/assets/e707261a-9121-4e94-a5f8-64217c57df11" />

## Product Details
<img width="324" height="720" alt="screenshot_20260605-181525_720" src="https://github.com/user-attachments/assets/e1713105-bebf-40c6-ab93-6836493f5e88" />

## Profile 
<img width="324" height="720" alt="screenshot_20260605-181545_720" src="https://github.com/user-attachments/assets/aab86050-0a5e-4f88-8b4b-68d904ebb9df" />

## 🎥 Demo Video
https://github.com/user-attachments/assets/f0b04d50-c20f-4191-929e-4cb7a04b62a5


*(Note: The demo video may looks low on quality but app runs at a crisp 60fps in high resolution, showcasing the liquid glass background animations!)*

---

## 📦 APK Download
[⬇️ Download Latest APK](https://drive.google.com/file/d/1XViDpV6wQEAXsQmunsDtzJHkOvwO-_OY/view?usp=sharing)

> **Note:** When downloading, Google Drive may show a warning saying "Google Drive can't scan this file for viruses". Please click "Download anyway" — this is normal for all APK files.

---

## 🎯 Submission Note
This project was designed to push the boundaries of Flutter UI capabilities, specifically focusing on highly performant **BackdropFilters** and complex gradient shadows to achieve an authentic crystal glass effect without dropping frames.
