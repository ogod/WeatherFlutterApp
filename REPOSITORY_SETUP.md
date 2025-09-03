# Repository Setup Guide

## 🔐 **API Key Security**

This repository is configured to keep your API keys secure and out of version control.

## **Quick Setup for New Users**

### 1. **Clone the Repository**
```bash
git clone <your-repo-url>
cd weather_flutter_app
```

### 2. **Set Up Your API Key**
Choose one of these methods:

#### **Method A: Local Config File (Recommended)**
1. Copy the template: `cp lib/config/app_config.template.dart lib/config/app_config_local.dart`
2. Edit `lib/config/app_config_local.dart` and replace `'YOUR_API_KEY_HERE'` with your actual API key
3. The local file is already excluded from version control

#### **Method B: Environment Variable**
```bash
export OPENWEATHERMAP_API_KEY="your_actual_api_key_here"
flutter run
```

#### **Method C: Build Time**
```bash
flutter run --dart-define=OPENWEATHERMAP_API_KEY=your_actual_api_key_here
```

### 3. **Install Dependencies**
```bash
flutter pub get
```

### 4. **Run the App**
```bash
flutter run
```

## **What's Protected**

✅ **API Keys** - Never committed to version control  
✅ **Local Config** - `app_config_local.dart` is in `.gitignore`  
✅ **Environment Files** - `.env` files are excluded  
✅ **Build Artifacts** - All build outputs are ignored  
✅ **IDE Files** - Editor-specific files are excluded  

## **Repository Structure**

```
weather_flutter_app/
├── lib/
│   ├── config/
│   │   ├── app_config.dart          # Main config (safe to commit)
│   │   ├── app_config.template.dart # Template for new users
│   │   └── app_config_local.dart    # Your API key (excluded)
│   └── ...
├── .gitignore                       # Excludes sensitive files
├── REPOSITORY_SETUP.md             # This file
└── README.md                       # Main project documentation
```

## **For Contributors**

### **Adding New Configuration**
1. Add new config to `app_config.dart`
2. Update `app_config.template.dart` with placeholder values
3. Update `app_config_local.dart` with your actual values
4. Never commit `app_config_local.dart`

### **Environment Variables**
- Use `String.fromEnvironment()` for build-time configuration
- Document all required environment variables
- Provide fallback values for development

## **Security Best Practices**

1. **Never commit API keys** to version control
2. **Use environment variables** for production deployments
3. **Keep local config files** in `.gitignore`
4. **Rotate API keys** regularly
5. **Use different keys** for development and production

## **Troubleshooting**

### **"API Key Not Found" Error**
- Check that `app_config_local.dart` exists and has your API key
- Verify the API key is valid at OpenWeatherMap
- Try using environment variable method instead

### **Build Errors**
- Ensure all dependencies are installed: `flutter pub get`
- Check Flutter version compatibility
- Clean and rebuild: `flutter clean && flutter pub get`

## **Deployment**

### **CI/CD Pipeline**
```yaml
# Example GitHub Actions
- name: Build Flutter App
  run: |
    flutter build web --dart-define=OPENWEATHERMAP_API_KEY=${{ secrets.OPENWEATHERMAP_API_KEY }}
```

### **Production Environment**
```bash
# Set environment variable
export OPENWEATHERMAP_API_KEY="your_production_api_key"

# Build with environment variable
flutter build web --dart-define=OPENWEATHERMAP_API_KEY=$OPENWEATHERMAP_API_KEY
```

## **Support**

If you encounter issues:
1. Check this setup guide
2. Verify your API key is correct
3. Ensure all files are properly configured
4. Check the main README.md for app-specific help

Your API keys are now secure and won't be exposed in the repository! 🔒✨
