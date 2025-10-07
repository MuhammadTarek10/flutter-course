#!/bin/bash

# Session 7 Setup Script
# Asynchronous Programming & API Integration

echo "🌐 Setting up Session 7: Asynchronous Programming & API Integration"
echo "=================================================================="

# Navigate to the app directory
cd "$(dirname "$0")/app" || exit 1

echo "📦 Installing dependencies..."
flutter pub get

if [ $? -eq 0 ]; then
    echo "✅ Dependencies installed successfully!"
else
    echo "❌ Failed to install dependencies"
    exit 1
fi

echo ""
echo "🚀 Setup complete! You can now run the app with:"
echo "   cd app && flutter run"
echo ""
echo "📚 Workshop Structure:"
echo "   1. Async Programming Basics - Learn Future, async, await"
echo "   2. HTTP API Integration - Make requests and parse JSON"
echo "   3. FutureBuilder UI Patterns - Handle loading, error, success states"
echo "   4. Photo Gallery Solution - Complete homework implementation"
echo ""
echo "📝 Don't forget to check HOMEWORK_INSTRUCTIONS.md for the assignment!"
echo ""
echo "Happy coding! 🎯"
