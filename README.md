# Visionary 🚀
A goal-tracking app to help users set clear objectives, stay consistent, and measure progress over time.
Built with Flutter and Firebase, focused on clean architecture, scalability, and a smooth mobile experience.

---

## Why Visionary ✨
Most goal apps are either too simple (just checklists) or too complex (too many features, no clarity).
Visionary focuses on a clean flow: define a goal → break it into actionable steps → track progress → reflect and iterate.

---

## Key Features ✅
- Goal creation with description, priority and target dates
- Milestones / tasks to break goals into smaller steps
- Progress tracking (completion %, history, and basic insights)
- Firebase Authentication (secure sign-in)
- Cloud data sync (same account across devices)
- Lightweight analytics events (optional) to understand usage

> Update this section to match exactly what your current build includes.

---

## Tech Stack 🧰
- **Flutter (Dart)** — cross-platform mobile development
- **Firebase**
  - Authentication
  - Firestore or Realtime Database (depending on the project setup)
  - Analytics (optional)
- **State management**: (add your choice: Provider / Riverpod / Bloc / Cubit)
- **Architecture**: feature-based structure + separation of concerns

---

## Architecture & Design 🏗️
Visionary is structured to be maintainable and team-friendly:
- **Feature-based folders** (each feature owns its UI, logic, and data layer)
- **Separation of concerns** between presentation, domain, and data
- **Reusable UI components** to keep the design consistent
- **Testability** in mind (domain logic isolated from UI)

---

## Screenshots 📱
Add some screenshots/gifs to make it feel like a product:
- /assets/screenshots/login.png
- /assets/screenshots/home.png
- /assets/screenshots/goal_detail.png

Tip: a simple 3-image grid looks great on GitHub.

---

## Getting Started 🏁

### Prerequisites
- Flutter SDK installed
- Xcode (for iOS) and/or Android Studio
- A Firebase project

### Install dependencies
flutter pub get

### Run (debug)
flutter run

### Run on a specific device
flutter devices
flutter run -d <device_id>

---

## Firebase Setup 🔥

### 1) Create a Firebase project
Enable:
- Authentication (Email/Password, Google, etc.)
- Firestore or Realtime Database

### 2) Add platform config files
- iOS: place GoogleService-Info.plist in ios/Runner/
- Android: place google-services.json in android/app/

### 3) iOS pods (if needed)
cd ios
pod install
cd ..

---

## Configuration 🔐
If you use environment variables, create:
.env

Example:
FIREBASE_PROJECT_ID=your_project_id

Never commit secrets. Add .env to .gitignore.

---

## Build & Release 🏗️

### Android release
flutter build apk --release

### iOS release
Open ios/Runner.xcworkspace in Xcode and use:
Product → Archive

---

## Roadmap 🛣️
- [ ] Reminders and habit loops (notifications)
- [ ] Streaks and weekly review
- [ ] Better analytics dashboard (personal insights)
- [ ] Offline-first improvements
- [ ] Sharing / accountability (friends / groups)

---

## Contributing 🤝
Contributions are welcome:
1) Fork the repo
2) Create a branch: git checkout -b feature/my-feature
3) Commit: git commit -m "Add my feature"
4) Push: git push origin feature/my-feature
5) Open a Pull Request

---

## License 📄
Choose one and add a LICENSE file:
- MIT
- Apache-2.0
- GPL-3.0
