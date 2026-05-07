# 🍎 Fruits Hub Dashboard

> Admin dashboard for the **Fruits Hub** mobile app — built with Flutter, Firebase, and Supabase.  
> Manages orders, inventory, customers, and push notifications in real-time.

[![Flutter](https://img.shields.io/badge/Flutter-stable-02569B?logo=flutter)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Firestore%20%7C%20Auth%20%7C%20FCM-FFCA28?logo=firebase)](https://firebase.google.com)
[![Supabase](https://img.shields.io/badge/Supabase-Storage-3ECF8E?logo=supabase)](https://supabase.com)
[![CI](https://img.shields.io/badge/CI-Codemagic-F45E3F?logo=codemagic)](https://codemagic.io)

---

## Table of contents

- [Architecture](#architecture)
- [Features](#features)
- [Tech stack](#tech-stack)
- [Getting started](#getting-started)
- [Environment variables](#environment-variables)
- [Git flow & branching strategy](#git-flow--branching-strategy)
- [CI/CD with Codemagic](#cicd-with-codemagic)
- [Project structure](#project-structure)
- [Localization](#localization)

---

## Architecture

Clean Architecture with feature-first folder structure. Each feature owns its `data`, `domain`, and `presentation` layers. State management is handled by **Cubit** (flutter_bloc). Dependency injection is handled by **get_it**.

```
feature/
  orders/
    data/       → models, repo_impl
    domain/     → entities, repos (abstract), usecases
    presentation/
      cubit/    → state management
      views/    → screens & widgets
```

---

## Features

| Module | Description                                                     |
|---|-----------------------------------------------------------------|
| **Orders** | Real-time order tracking, status updates, cancellation handling |
| **Inventory** | Product management with image upload (Supabase Storage)         |
| **Customers** | Customer status management, search, stats                       |
| **Notifications** | Push notifications via FCM for new orders and products          |
| **Auth** | Firebase Auth with email and password                           |

---

## Tech stack

| Layer | Technology |
|---|---|
| Framework | Flutter (stable) |
| State management | flutter_bloc — Cubit |
| DI | get_it |
| Backend / Realtime | Cloud Firestore |
| Auth | Firebase Auth |
| Storage | Supabase Storage |
| Push notifications | Firebase Cloud Messaging (FCM) |
| Image picking | image_picker + cached_network_image_ce |
| Secure storage | flutter_secure_storage + dart_jsonwebtoken |
| Localization | flutter_intl (AR / EN) |
| CI/CD | Codemagic |

---

## Getting started

### Prerequisites

- Flutter SDK `^3.11.0`
- Dart SDK `^3.11.0`
- Java 17 (for Android builds)
- A Firebase project with Firestore, Auth, and FCM enabled
- A Supabase project with Storage enabled

### Local setup

```bash
# 1. Clone
git clone https://github.com/<your-org>/dashboard_fruit_hub.git
cd dashboard_fruit_hub

# 2. Install dependencies
flutter pub get

# 3. Generate localization & asset files
dart run build_runner build --delete-conflicting-outputs

# 4. Create your .env (never commit this file)
cp .env.example .env
# → fill in the values described below

# 5. Add google-services.json (never commit this file)
# Download from Firebase Console → Project Settings → Android app
cp ~/Downloads/google-services.json android/app/google-services.json

# 6. Run
flutter run
```

---

## Environment variables

Create a `.env` file at the **project root** (already in `.gitignore`):

```dotenv
# Supabase
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your_anon_key

# FCM Service Account (server-side push)
FCM_PROJECT_ID=your-firebase-project-id
FCM_CLIENT_EMAIL=firebase-adminsdk@your-project.iam.gserviceaccount.com
FCM_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n"
```

> **Never commit `.env`, `google-services.json`, or `android/key.properties` to git.**  
> These are injected at build time by Codemagic environment groups.

---

## Git flow & branching strategy

This project follows a strict **Git Flow** model. The `codemagic.yaml` file lives at the repo root and is versioned alongside the code — every branch change is automatically reflected in CI behavior.

### Branch structure

```
main          ← production-ready code only; protected branch
develop       ← integration branch; all features merge here first
feature/*     ← individual feature work
hotfix/*      ← urgent production patches (branches off main)
```

### Workflow

```
1. Branch from develop
   git checkout develop && git pull
   git checkout -b feature/your-feature

2. Develop & push (CI builds debug APK automatically)
   git push origin feature/your-feature

3. Open PR → develop
   - Code review required
   - CI must pass (flutter analyze + debug build)

4. Merge to develop
   git checkout develop && git merge --no-ff feature/your-feature
   git push origin develop
   → CI builds debug APK on develop

5. Promote develop → main (release PR)
   git checkout main
   git merge --no-ff develop
   git push origin main
   → CI builds signed APK + AAB

6. Tag for a GitHub Release
   git tag v1.2.0
   git push origin v1.2.0
   → CI builds signed artifacts AND creates GitHub Release

7. Hotfixes
   git checkout -b hotfix/crash-fix main
   # fix, commit, push
   git checkout main && git merge --no-ff hotfix/crash-fix
   git tag v1.2.1 && git push --tags
   git checkout develop && git merge --no-ff hotfix/crash-fix  # keep in sync
```

### Branch protection rules (GitHub)

Configure these on `main` and `develop`:

- ✅ Require pull request reviews before merging (1 reviewer minimum)
- ✅ Require status checks to pass (Codemagic CI)
- ✅ Require branches to be up to date before merging
- ❌ Allow force pushes → **disabled**
- ❌ Allow deletions → **disabled**

---

## CI/CD with Codemagic

### Workflows

| Workflow | Trigger | Artifacts | Signing | GitHub Release |
|---|---|---|---|---|
| `android-debug` | push to `feature/*`, `develop` | debug APK | ❌ | ❌ |
| `android-release` | push/tag to `main` + `v*` tags | split APKs + AAB + debug symbols | ✅ | ✅ on tag |

### Codemagic environment groups

Create these groups in **Codemagic → Teams → Global variables & secrets**:

#### `app_env_vars`

| Variable | Description |
|---|---|
| `SUPABASE_URL` | Supabase project URL |
| `SUPABASE_ANON_KEY` | Supabase anon/public key |
| `FCM_PROJECT_ID` | Firebase project ID |
| `FCM_CLIENT_EMAIL` | FCM service account email |
| `FCM_PRIVATE_KEY` | FCM private key (full PEM string) |
| `GOOGLE_SERVICES_JSON` | Base64-encoded `google-services.json` |

Generate the base64 value:
```bash
base64 -i android/app/google-services.json | tr -d '\n'
```

### Versioning convention

Tags drive automatic version bumps in the build. Pushing `v1.4.2` sets `pubspec.yaml` to `1.4.2+<CM_BUILD_NUMBER>` automatically — no manual edits needed.

```
v1.0.0   →  pubspec: 1.0.0+1
v1.1.0   →  pubspec: 1.1.0+2
v1.1.1   →  pubspec: 1.1.1+3   ← hotfix
```

### Files that must stay out of git

Add these to `.gitignore` if not already present:

```gitignore
# Secrets — never commit
.env
android/app/google-services.json
android/key.properties
android/app/keystore.jks
ios/Runner/GoogleService-Info.plist

# Build outputs
build/
```

---

## Project structure

```
dashboard_fruit_hub/
├── codemagic.yaml              ← CI/CD config (versioned in git ✅)
├── pubspec.yaml
├── .env                        ← local secrets (gitignored ❌)
├── android/
│   ├── app/
│   │   ├── google-services.json  ← gitignored ❌
│   │   └── build.gradle
│   └── key.properties            ← gitignored ❌
└── lib/
    ├── main.dart
    ├── dashboard_app.dart
    ├── firebase_options.dart
    ├── core/
    │   ├── entities/             ← shared domain entities
    │   ├── errors/               ← failures & exceptions
    │   ├── l10n/                 ← localization (AR/EN)
    │   ├── repos/                ← shared repo contracts
    │   └── services/             ← DI, auth, FCM, storage, DB
    └── features/
        ├── auth/
        ├── orders/
        ├── inventory/
        ├── customers/
        └── notifications/
```

---

## Localization

The app supports **Arabic** and **English**. ARB files live in `lib/core/l10n/arb/`.

```bash
# Regenerate after editing .arb files
dart run build_runner build --delete-conflicting-outputs
```

| File | Locale |
|---|---|
| `intl_ar.arb` | Arabic (RTL) |
| `intl_en.arb` | English (LTR) |