# SATU Equipment Management App

A Flutter-based mobile application for equipment management and inspection, designed specifically for iPad devices.

## 📱 Project Information

- **App Name:** SATU
- **Bundle ID:** com.yotaka46.satu
- **Target Platform:** iPad only
- **Team:** Yotaka46 Co., Ltd.
- **Current Version:** 1.0.7+42

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Xcode (for iOS development)
- iOS Simulator or physical iPad device
- Apple Developer Account (for TestFlight/App Store deployment)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/mawinnattapon/satu-mobile-app-main.git
   cd satu-mobile-app-main
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   cd ios && pod install && cd ..
   ```

## 🏃‍♂️ Development Commands

### Running the App

**Run on iOS Simulator:**
```bash
flutter run -d "iPad Air 11-inch (M3)"
```

**Run on Physical Device:**
```bash
flutter run -d "Mawin"  # Replace with your device name
```

**Run in Debug Mode:**
```bash
flutter run --debug
```

**Run in Release Mode:**
```bash
flutter run --release
```

**Check Available Devices:**
```bash
flutter devices
```

### Building the App

**Build for iOS Release:**
```bash
flutter build ios --release
```

**Build for iOS Debug:**
```bash
flutter build ios --debug
```

**Build for Simulator:**
```bash
flutter build ios --debug --simulator
```

**Clean Build:**
```bash
flutter clean
flutter pub get
cd ios && pod install && cd ..
flutter build ios --release
```

## 📦 Deployment

### TestFlight Deployment

1. **Build the app:**
   ```bash
   flutter build ios --release
   ```

2. **Open Xcode workspace:**
   ```bash
   open ios/Runner.xcworkspace
   ```

3. **Archive and Upload:**
   - In Xcode: Product → Archive
   - Select "Distribute App" → "App Store Connect" → "Upload"

### Version Management

Update version in `pubspec.yaml`:
```yaml
version: 1.0.8+43  # Format: major.minor.patch+buildNumber
```

## 🏗️ Project Structure

```
lib/
├── constants/          # App constants and configurations
├── modules/
│   ├── controller/     # GetX controllers
│   └── repo/          # API repositories
├── screens/           # UI screens
│   ├── systeminfo/    # System information forms
│   └── ...
├── styles/            # Theme and styling
├── utils/             # Utility classes (HTTP, etc.)
└── main.dart          # App entry point
```

## 🔧 Key Dependencies

- **camera**: Camera functionality
- **mobile_scanner**: QR code scanning
- **flutter_inappwebview**: In-app web browser
- **syncfusion_flutter_signaturepad**: Digital signatures
- **dio**: HTTP client
- **sqflite**: Local database
- **get**: State management

## 🌐 API Integration

The app integrates with backend APIs for:
- Equipment form management (`/assm/equipment/forms/`)
- Image upload (`/file/upload/image`)
- System configuration (`/config`)

**API Configuration:**
- Edit `lib/config.dart` to change API endpoints
- Default: `http://localhost:5401` (for local development)

## 🧪 Testing

**Run Tests:**
```bash
flutter test
```

**Run on Simulator for Testing:**
```bash
flutter run -d "iPad Air 11-inch (M3)" --debug
```

## 📋 Features

- **Dynamic Form Generation**: Multiple input types (text, choice, dropdown, checkbox, table)
- **QR Code Scanning**: Equipment identification
- **Camera Integration**: Photo capture and upload
- **Digital Signatures**: Syncfusion signature pad
- **Offline Support**: SQLite local database
- **API Integration**: RESTful API communication

## 🔍 Troubleshooting

**Common Issues:**

1. **Build Errors:**
   ```bash
   flutter clean
   flutter pub get
   cd ios && pod deintegrate && pod install && cd ..
   ```

2. **Signing Issues:**
   - Check Team selection in Xcode
   - Verify Bundle ID matches App Store Connect

3. **Simulator Issues:**
   ```bash
   flutter devices  # Check available simulators
   xcrun simctl list devices  # List iOS simulators
   ```

## 📱 Device Requirements

- **iOS:** 12.0 or later
- **Device:** iPad only (optimized for iPad interface)
- **Architecture:** arm64 (for physical devices)

## 🚀 Deployment History

- **v1.0.9**: Successfully deployed to TestFlight (Build 40)
- **v1.0.7**: Current development version (Build 42)
- **Bundle ID**: com.yotaka46.satu (for new app creation)

## 📞 Support

For technical support or questions:
- **Team:** Yotaka46 Co., Ltd.
- **Repository:** [GitHub](https://github.com/mawinnattapon/satu-mobile-app-main)

## 📄 License

This project is proprietary software owned by Yotaka46 Co., Ltd.

---

**Quick Start Commands:**
```bash
# Development
flutter run -d "iPad Air 11-inch (M3)"

# Production Build
flutter build ios --release
open ios/Runner.xcworkspace

xcrun simctl list devices
open -a Simulator