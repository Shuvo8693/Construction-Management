# Charteur

**A professional construction project management platform built with Flutter.**

[![Flutter](https://img.shields.io/badge/Flutter-3.9%2B-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.9%2B-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Enabled-FFCA28?logo=firebase&logoColor=black)](https://firebase.google.com)
[![License](https://img.shields.io/badge/License-Private-red)]()

---

## 📋 Table of Contents

- [Project Overview](#-project-overview)
- [App Idea & Core Concept](#-app-idea--core-concept)
- [Key Features](#-key-features)
- [Architecture](#-architecture)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [Installation & Run Guide](#-installation--run-guide)
- [Usage](#-usage)
- [Future Improvements](#-future-improvements)
- [Contribution](#-contribution)
- [License](#-license)
- [Author](#-author)

---

## 📖 Project Overview

**Charteur** is a cross-platform mobile application designed to streamline construction project management. The platform bridges the gap between office administrators and field collaborators by providing a centralized hub for managing construction sites, assigning and tracking tasks, sharing documents, and facilitating team communication — all in real time.

---

## 💡 App Idea & Core Concept

Construction projects involve multiple stakeholders — office admins who plan and oversee, and collaborators/workers who execute tasks on-site. Charteur digitizes this workflow by offering:

- **Role-based access control** — Differentiated experiences for Office Admins and Collaborators
- **Site lifecycle management** — Create, track, and manage construction sites with location data
- **Task assignment & tracking** — Assign tasks, update statuses, and monitor progress
- **Document management** — Upload, view, and annotate PDF plans and site files
- **Real-time communication** — Socket-based messaging and push notifications for instant updates

---

## ✨ Key Features

### Authentication & Onboarding
- Email/password login and registration with OTP verification
- Password recovery (forgot/reset/change password)
- Role selection (Office Admin / Collaborator)
- Multi-language onboarding flow

### Site Management
- Create and manage construction sites with GPS coordinates
- Interactive Google Maps integration for site location
- View assigned sites or all sites (role-dependent)
- Site details with building type, status, and owner information

### Task & Workflow Management
- Assign tasks to collaborators with image-based annotations
- Task status tracking and updates
- Drag-and-drop image pin annotation on plans
- Filtering: "Assigned Tasks" vs "My Tasks"

### Document Management
- PDF viewing and editing via Syncfusion
- File upload and download per site
- File picker support for various document types

### Communication
- Real-time messaging via Socket.IO
- Remarks and comments on tasks (chat-bubble UI)
- Firebase Cloud Messaging for push notifications
- Local notifications for foreground/background events

### Profile & Settings
- Editable user profile with photo upload
- Company profile management (for admins)
- Language selection, privacy policy, terms of service
- Support and about screens

### Subscription
- Tiered subscription plans (1 Month, 3 Months, 1 Year)
- In-app subscription management

---

## 🏗 Architecture

The project follows a **feature-first, MVVM-inspired architecture** with clear separation of concerns:

```
┌─────────────────────────────────────────────┐
│                   Presentation               │
│  ┌──────────────┐  ┌─────────────────────┐  │
│  │   Views       │◄─│  ViewModels (GetX)  │  │
│  │  (Screens)    │  │  (Controllers)      │  │
│  └──────────────┘  └─────────────────────┘  │
├─────────────────────────────────────────────┤
│                   Domain/Core                │
│  ┌────────┐ ┌────────┐ ┌────────┐ ┌───────┐ │
│  │ Router │ │Config  │ │Helpers │ │Theme  │ │
│  └────────┘ └────────┘ └────────┘ └───────┘ │
├─────────────────────────────────────────────┤
│                   Services                   │
│  ┌──────────┐ ┌───────┐ ┌────────┐ ┌──────┐ │
│  │ REST API │ │Socket │ │Google  │ │FCM   │ │
│  │ (Dio)    │ │  .IO   │ │ Maps   │ │Push  │ │
│  └──────────┘ └───────┘ └────────┘ └──────┘ │
├─────────────────────────────────────────────┤
│                   Data Layer                 │
│  ┌─────────────────┐  ┌──────────────────┐  │
│  │ SharedPreferences│  │  Hive (Cache)   │  │
│  └─────────────────┘  └──────────────────┘  │
└─────────────────────────────────────────────┘
```

**Key design principles:**
- **Feature-first organization** — Each domain (auth, sites, admin, settings) is self-contained
- **GetX for state management & DI** — Controllers use `Get.put`/`Get.find` with `.obs` observables
- **Declarative routing** — AutoRoute generates type-safe navigation
- **Service layer abstraction** — API calls, sockets, and maps are isolated in `lib/services/`

---

## 🛠 Tech Stack

| Category | Technology |
|---|---|
| **Framework** | Flutter (Dart 3.9+) |
| **State Management** | GetX |
| **Routing** | AutoRoute + auto_route_generator |
| **HTTP Client** | Dio |
| **Real-time** | Socket.IO Client |
| **Backend** | RESTful API (custom backend at `mihad3000.merinasib.shop`) |
| **Database/Storage** | Firebase (FCM), SharedPreferences, Hive |
| **Maps** | Google Maps Flutter + Geolocator + Geocoding |
| **PDF** | Syncfusion Flutter PDF Viewer & PDF |
| **Notifications** | Firebase Cloud Messaging + flutter_local_notifications |
| **UI Utilities** | Flutter ScreenUtil, Shimmer, Cached Network Image, Chat Bubbles, Pinput |
| **File Handling** | Image Picker, File Picker, Path Provider |
| **Code Generation** | build_runner, AutoRoute Generator, Flutter Gen |
| **CI/CD** | FVM (Flutter Version Management) |
| **Analytics/Monitoring** | Firebase Core |

---

## 📁 Project Structure

```
charteur/
├── android/                     # Android platform code
├── ios/                         # iOS platform code
├── assets/
│   ├── icons/                   # SVG/icon assets
│   ├── images/                  # Image assets
│   └── logo/                    # App logo
├── lib/
│   ├── core/                    # Shared core module
│   │   ├── config/              # App constants, config
│   │   ├── helpers/             # Utility helpers (prefs, toast, dialogs, PDF, etc.)
│   │   ├── network/             # Network client (Dio)
│   │   ├── router/              # AutoRoute configuration
│   │   ├── theme/               # App theme definitions
│   │   └── widgets/             # Reusable UI components
│   ├── features/
│   │   ├── views/               # UI screens organized by feature
│   │   │   ├── admin/           # Office admin screens
│   │   │   │   ├── home/        # Dashboard, site details, task assignment
│   │   │   │   └── subscription/
│   │   │   ├── auth/            # Login, signup, OTP, password recovery
│   │   │   ├── bottom_nav/      # Main navigation shell
│   │   │   ├── common/          # Shared features
│   │   │   │   ├── notifications/
│   │   │   │   ├── profile/
│   │   │   │   ├── setting/
│   │   │   │   └── sites/       # Site listing, creation, file management
│   │   │   └── splash_onboarding/
│   │   └── view_models/         # GetX controllers
│   │       ├── bottom_nav/
│   │       ├── location/
│   │       └── site/
│   ├── services/                # External service integrations
│   │   ├── api_client.dart      # Dio HTTP client
│   │   ├── api_urls.dart        # API endpoint definitions
│   │   ├── socket_services.dart # Socket.IO real-time service
│   │   ├── google_api_service.dart
│   │   └── get_fcm_token.dart   # Firebase notification service
│   ├── firebase_options.dart    # Firebase configuration
│   └── main.dart                # App entry point
├── pubspec.yaml                 # Dependencies & assets
├── firebase.json                # Firebase CLI config
├── analysis_options.yaml        # Dart lint rules
└── README.md
```

---

## 🚀 Installation & Run Guide

### Prerequisites

- **Flutter SDK** ≥ 3.9.0 (managed via FVM)
- **Dart SDK** ≥ 3.9.0
- **Android Studio** / **Xcode** for emulators
- **Firebase project** configured (`charteur-15102`)
- **Backend API** running and accessible

### Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd charteur
   ```

2. **Install Flutter version** (if using FVM)
   ```bash
   fvm use
   ```

3. **Install dependencies**
   ```bash
   flutter pub get
   ```

4. **Generate code** (AutoRoute + Flutter Gen)
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

5. **Configure Firebase**
   - Ensure `android/app/google-services.json` is in place
   - Firebase project: `charteur-15102`

6. **Run the app**
   ```bash
   flutter run
   ```

### Build for Release

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release
```

---

## 📱 Usage

### First Launch
1. **Splash Screen** → Auto-redirects to onboarding or home based on auth state
2. **Onboarding** → 3-page carousel introducing the app
3. **Role Selection** → Choose **Office Admin** or **Collaborator**
4. **Authentication** → Sign up or log in with email/password + OTP verification

### Office Admin Workflow
1. **Dashboard** → View all construction sites at a glance
2. **Create Site** → Add site details (owner, title, status, location, building type)
3. **Assign Tasks** → Select collaborators, attach annotated plans (image pins)
4. **Monitor** → Track task statuses, view remarks/comments, manage company profile
5. **Subscription** → Manage subscription plan

### Collaborator Workflow
1. **Assigned Sites** → View sites and tasks assigned by admin
2. **Update Status** → Mark tasks as complete, add remarks
3. **Upload Files** → Attach documents, photos, or plans to sites
4. **Profile** → Manage personal information and expertise area

### Common Features
- **Notifications** → Receive real-time alerts via FCM
- **Settings** → Change password, language, view privacy/terms
- **Maps** → View site locations on Google Maps with GPS navigation

---

## 🔮 Future Improvements

- [ ] **Offline mode** — Cache sites, tasks, and files for offline access
- [ ] **In-app payments** — Integrate Stripe/PayPal for subscription purchases
- [ ] **Team chat** — Dedicated group/DM channels beyond task remarks
- [ ] **Push notification deep links** — Navigate to specific task/site from notification
- [ ] **Analytics dashboard** — Charts and metrics for project progress
- [ ] **Multi-language support** — Full i18n implementation (currently partial)
- [ ] **Dark mode** — Theme toggle (currently light-only)
- [ ] **Automated tests** — Unit, widget, and integration test coverage
- [ ] **CI/CD pipeline** — GitHub Actions or Codemagic for automated builds
- [ ] **Web/Desktop support** — Extend beyond mobile platforms

---

## 🤝 Contribution

Contributions are welcome! To contribute:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

Please ensure your code follows the project's linting rules (`flutter analyze`) and matches the existing code style.

---

## 📄 License

This project is **proprietary and private**. All rights reserved. Unauthorized copying, distribution, or modification of this code is not permitted.

---

## 👤 Author

**Charteur Team**

- 📧 Contact: [Available via in-app Support screen]
- 🌐 Backend API: `https://mihad3000.merinasib.shop/api/v1`
- 📱 Platform: Android & iOS (Flutter)

---

<p align="center">
  <em>Built with ❤️ using Flutter & Dart</em>
</p>
