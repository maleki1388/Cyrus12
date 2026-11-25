# CYRUS UI Prototype v2

UI-only Flutter prototype (Home, List, Stats, Settings). No VPN/network functionality.

## Build APK (no local setup)
1. Create a new GitHub repo and upload the CONTENTS of this folder to the repo root
   (the `.github` folder must be at the root; it is hidden, so use git or drag-and-drop carefully).
2. Go to Actions > "Build CYRUS UI APK" > Run workflow.
3. When it finishes, download the `CYRUS-UI-APK` artifact (zip) -> app-release.apk.

## Build locally
    flutter create . --platforms=android --project-name cyrus_ui --org com.cyrus.ui
    git checkout lib/main.dart   # or restore your main.dart if overwritten
    flutter pub get
    flutter build apk --release
