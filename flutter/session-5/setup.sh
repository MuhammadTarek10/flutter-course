#!/bin/bash

# 🚀 Session 5 Setup Script
# This script sets up the local storage workshops

echo "📱 Setting up Session 5: Local Storage Workshops..."
echo

# Navigate to app directory
cd app

echo "📦 Installing dependencies..."
flutter pub get

echo

echo "🔨 Generating Hive type adapters..."
flutter packages pub run build_runner build --delete-conflicting-outputs

echo

echo "✅ Setup complete!"
echo
echo "🎯 Next steps:"
echo "1. cd app"
echo "2. flutter run"
echo
echo "📚 Available workshops:"
echo "  • SharedPreferences Demo (Theme Switcher)"
echo "  • Hive NoSQL Database (Notes App)"  
echo "  • SQLite Database (SQL Notes App)"
echo
echo "📝 Don't forget to check HOMEWORK_INSTRUCTIONS.md!"
echo

echo "🌟 Happy coding!"
