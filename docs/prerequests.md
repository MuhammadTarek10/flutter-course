# 🛠️ Prerequisites & Setup Guide

Before starting this Flutter course, you'll need to set up your development environment. This guide will walk you through everything you need to install and configure.

## 📋 What You'll Need

### Required Knowledge

- **Basic programming concepts** (variables, functions, loops, conditionals)
- **Familiarity with any programming language** (Python, JavaScript, Java, C#, etc.)
- **Understanding of object-oriented programming** (helpful but not required)
- **Basic command line usage** (helpful but we'll cover this)

### System Requirements

- **Operating System**: Windows 10+, macOS 10.14+, or Linux (Ubuntu 18.04+)
- **Storage**: At least 10GB free space (20GB recommended)
- **RAM**: 8GB minimum (16GB recommended for better performance)
- **Internet**: Stable connection for downloads and updates
- **Processor**: Multi-core processor (Intel i5/AMD Ryzen 5 or better)

## 🚀 Installation Guide

### Step 1: Install Flutter SDK

#### Windows

1. **Download Flutter SDK**:

   - Visit [Flutter Installation](https://docs.flutter.dev/get-started/install/windows)
   - Download the latest Flutter SDK zip file
   - Extract to `C:\flutter` (avoid spaces in path)

2. **Add to PATH**:
   - Open System Properties → Environment Variables
   - Add `C:\flutter\bin` to your PATH variable

#### macOS

1. **Using Homebrew** (Recommended):

   ```bash
   brew install flutter
   ```

2. **Manual Installation**:

   - Visit [Flutter Installation](https://docs.flutter.dev/get-started/install/macos)
   - Download and extract to `/Users/<your-name>/flutter`
   - Add to PATH in `~/.zshrc` or `~/.bash_profile`:

     ```bash
     export PATH="$PATH:/Users/<your-name>/flutter/bin"
     ```

#### Linux

1. **Download and Extract**:

   ```bash
   cd ~/development
   wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.16.5-stable.tar.xz
   tar xf flutter_linux_3.16.5-stable.tar.xz
   ```

2. **Add to PATH**:

   ```bash
   export PATH="$PATH:`pwd`/flutter/bin"
   # Add to ~/.bashrc for permanent setup
   ```

### Step 2: Install IDE

#### Visual Studio Code (Recommended)

1. **Download**: [VS Code](https://code.visualstudio.com/download)
2. **Install Flutter Extension**:
   - Open VS Code
   - Go to Extensions (Ctrl+Shift+X)
   - Search for "Flutter"
   - Install "Flutter" extension by Dart Code
   - Install "Dart" extension (auto-installed with Flutter)

#### Android Studio

1. **Download**: [Android Studio](https://developer.android.com/studio)
2. **Install Flutter Plugin**:
   - Open Android Studio
   - Go to Preferences/Settings → Plugins
   - Search for "Flutter"
   - Install Flutter plugin
   - Restart Android Studio

#### IntelliJ IDEA

1. **Download**: [IntelliJ IDEA](https://www.jetbrains.com/idea/download/)
2. **Install Flutter Plugin**:
   - Go to Preferences/Settings → Plugins
   - Search for "Flutter"
   - Install Flutter plugin

### Step 3: Platform-Specific Setup

#### Android Development

1. **Install Android Studio** (if not already installed)
2. **Install Android SDK**:

   - Open Android Studio
   - Go to Tools → SDK Manager
   - Install Android SDK (API level 21 or higher)
   - Install Android SDK Command-line Tools
   - Install Android SDK Build-Tools

3. **Set up Android Emulator**:
   - Go to Tools → AVD Manager
   - Create Virtual Device
   - Choose a device (Pixel 4 recommended)
   - Download and select a system image (API 30+ recommended)

#### iOS Development (macOS only)

1. **Install Xcode**:

   - Download from Mac App Store
   - Install Command Line Tools:

     ```bash
     sudo xcode-select --install
     ```

2. **Set up iOS Simulator**:
   - Open Xcode
   - Go to Xcode → Preferences → Components
   - Download iOS Simulator

#### Web Development

1. **Enable Web Support**:

   ```bash
   flutter config --enable-web
   ```

## ✅ Verification Steps

### 1. Check Flutter Installation

```bash
flutter doctor
```

This command will check your setup and show any issues that need to be resolved.

### 2. Expected Output

You should see something like:

```bash
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.16.5, on macOS 14.1.2 23B81, locale en-US)
[✓] Windows Version (Installed version of Windows is version 10 or higher)
[✓] Android toolchain - develop for Android devices (Android SDK version 34.0.0)
[✓] Chrome - develop for the web
[✓] Visual Studio - develop for Windows (Visual Studio Community 2022 17.8.34330.188)
[✓] VS Code (version 1.85.1)
[✓] Connected device (3 available)
[✓] Network resources

• No issues found!
```

### 3. Test Your Setup

Create and run your first Flutter app:

```bash
# Create a new Flutter project
flutter create my_first_app

# Navigate to the project
cd my_first_app

# Get dependencies
flutter pub get

# Run the app
flutter run
```

## 🔧 Troubleshooting

### Common Issues

#### Flutter Doctor Shows Issues

- **Android SDK not found**: Install Android Studio and SDK
- **Xcode not found**: Install Xcode (macOS only)
- **VS Code not found**: Install VS Code and Flutter extension

#### Permission Issues

```bash
# macOS/Linux
sudo chown -R $(whoami) /path/to/flutter
```

#### Network Issues

```bash
# Set up proxy if needed
export HTTP_PROXY=http://proxy.company.com:port
export HTTPS_PROXY=http://proxy.company.com:port
```

#### Path Issues

- **Windows**: Restart command prompt after adding to PATH
- **macOS/Linux**: Restart terminal or run `source ~/.bashrc`

### Getting Help

- **Flutter Documentation**: [flutter.dev/docs](https://flutter.dev/docs)
- **Flutter Community**: [flutter.dev/community](https://flutter.dev/community)
- **Stack Overflow**: Search for Flutter-related questions
- **GitHub Issues**: [github.com/flutter/flutter/issues](https://github.com/flutter/flutter/issues)

## 🎯 Next Steps

Once you've completed the setup:

1. ✅ **Verify installation** with `flutter doctor`
2. ✅ **Create test app** with `flutter create` and `flutter run`
3. ✅ **Start learning** with [Session 1](session-1.md)

---
