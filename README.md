# local_storage_async_cloud

# 📱 SmartSync App

A Flutter-based mobile application with **offline-first architecture**, designed to work seamlessly with both **local and cloud data sources**. It smartly detects connectivity changes and synchronizes data between local storage (Hive) and remote APIs using Dio when online.

---

## ✨ Features

- ✅ **Offline-first** with Hive local database
- ☁️ **Cloud API integration** using Dio
- 🔄 **Auto sync** between local and cloud when online
- 🌐 **Connectivity-aware** logic using `connectivity_plus`
- ⚙️ Built with **Riverpod** for robust state management
- ⚡ Async API handling with error recovery and retry logic

- | Layer        | Package            | Description                                     |
|--------------|--------------------|-------------------------------------------------|
| Networking   | `dio`              | Advanced HTTP client for Flutter                |
| State Mgmt   | `flutter_riverpod` | Declarative state management                    |
| Local DB     | `hive`             | Lightweight key-value database                  |
| Flutter Hive | `hive_flutter`     | Hive support for Flutter apps                   |
| Code Gen     | `hive_generator`   | Generates type adapters for Hive                |
| Connectivity | `connectivity_plus`| Monitors online/offline state

## 📦 Dependencies

```yaml
dependencies:
  dio: ^5.8.0+1
  flutter_riverpod: ^2.6.1
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  connectivity_plus: ^6.1.4

dev_dependencies:
  hive_generator: ^2.0.1
  build_runner: any
