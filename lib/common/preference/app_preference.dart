import 'package:app_base/common/theme/custom_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The `AppPreferences` class serves as a centralized utility for managing application-level
/// preferences using the `SharedPreferences` library. It provides methods to initialize
/// preferences, store and retrieve values, handle type transformations, and delete stored preferences.
///
/// This class supports various data types, including:
/// - `int`
/// - `String`
/// - `double`
/// - `bool`
/// - `List<String>`
/// - `DateTime`
/// - `Enum`
///
/// The main features of `AppPreferences` include:
///
/// - **Initialization**: The `init()` method sets up the `SharedPreferences` instance.
/// - **Setting Values**: The `setValue()` method saves values of generic types to the preferences.
///   If the value is nullable, it removes the key when set to `null`.
/// - **Retrieving Values**: The `getValue()` method retrieves values from the preferences,
///   returning the specified default value if the key does not exist.
/// - **Deleting Values**: The `deleteValue()` method removes a specific key from the preferences.
/// - **Type Transformation**: The `transform()` method converts string-based values into
///   custom types like `DateTime` and custom enums, ensuring flexibility in managing preferences.
///
/// Usage:
///
/// - Define a `PreferenceItem` with a specific key and default value.
/// - Use `setValue()` to store a value and `getValue()` to retrieve it.
/// - Use `deleteValue()` to remove a value from the preferences.
///
/// Example:
/// ```dart
/// final themePreference = PreferenceItem<CustomTheme>('theme', CustomTheme.light);
///
/// // Set a value
/// await AppPreferences.setValue(themePreference, CustomTheme.dark);
///
/// // Get a value
/// CustomTheme theme = AppPreferences.getValue(themePreference);
///
/// // Delete a value
/// await AppPreferences.deleteValue(themePreference);
/// ```
///
/// This class provides type-safe preference management, ensuring a consistent and reliable way
/// to handle persistent application settings.
class AppPreferences {
  static const String prefix = 'AppPreference.'; // change with own preference item prefix
  static late final SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    return;
  }

  static String getPrefKey(PreferenceItem item) {
    return '${AppPreferences.prefix}${item.key}';
  }

  static bool checkIsNullable<T>() => null is T;

  static Future<bool> setValue<T>(PreferenceItem<T> item, T? value) async {
    final String key = getPrefKey(item);
    final isNullable = checkIsNullable<T>();

    if (isNullable && value == null) {
      // Setting it to null is interpreted as deleting the value. You can modify it as needed.
      return _prefs.remove(item.key);
    }

    if (isNullable) {
      switch (T.toString()) {
        case "int?":
          return _prefs.setInt(key, value as int);
        case "String?":
          return _prefs.setString(key, value as String);
        case "double?":
          return _prefs.setDouble(key, value as double);
        case "bool?":
          return _prefs.setBool(key, value as bool);
        case "List<String>?":
          return _prefs.setStringList(key, value as List<String>);
        case "DateTime?":
          return _prefs.setString(key, (value as DateTime).toIso8601String());
        default:
          if (value is Enum) {
            return _prefs.setString(key, value.name);
          } else {
            throw Exception('$T Please add a transform function for the type.');
          }
      }
    } else {
      switch (T) {
        case int:
          return _prefs.setInt(key, value as int);
        case String:
          return _prefs.setString(key, value as String);
        case double:
          return _prefs.setDouble(key, value as double);
        case bool:
          return _prefs.setBool(key, value as bool);
        case const (List<String>):
          return _prefs.setStringList(key, value as List<String>);
        case DateTime:
          return _prefs.setString(key, (value as DateTime).toIso8601String());
        default:
          if (value is Enum) {
            return _prefs.setString(key, value.name);
          } else {
            throw Exception('$T Please add a transform function for the type.');
          }
      }
    }
  }

  static Future<bool> deleteValue<T>(PreferenceItem<T> item) async {
    final String key = getPrefKey(item);
    return _prefs.remove(key);
  }

  static T getValue<T>(PreferenceItem<T> item) {
    final String key = getPrefKey(item);
    switch (T) {
      case int:
        return _prefs.getInt(key) as T? ?? item.defaultValue;
      case String:
        return _prefs.getString(key) as T? ?? item.defaultValue;
      case double:
        return _prefs.getDouble(key) as T? ?? item.defaultValue;
      case bool:
        return _prefs.getBool(key) as T? ?? item.defaultValue;
      case const (List<String>):
        return _prefs.getStringList(key) as T? ?? item.defaultValue;
      default:
        return transform(T, _prefs.getString(key)) ?? item.defaultValue;
    }
  }

  static bool containsKey<T>(PreferenceItem<T> item) {
    final String key = getPrefKey(item);
    return _prefs.containsKey(key);
  }

  static T? transform<T>(Type t, String? value) {
    if (value == null) {
      return null;
    }

    bool isNullableType = checkIsNullable<T>();
    if (isNullableType) {
      switch (t.toString()) {
        case "CustomTheme?":
          return CustomTheme.values.asNameMap()[value] as T?;
        case "DateTime?":
          return DateTime.parse(value) as T?;
        default:
          throw Exception('$t Please add a transform function for the type.');
      }
    } else {
      switch (t) {
        case CustomTheme:
          return CustomTheme.values.asNameMap()[value] as T?;
        case DateTime:
          return DateTime.parse(value) as T?;
        default:
          throw Exception('$t Please add a transform function for the type.');
      }
    }
  }
}

class PreferenceItem<T> {
  final T defaultValue;
  final String key;

  PreferenceItem(this.key, this.defaultValue);

  void call(T value) {
    AppPreferences.setValue<T>(this, value);
  }

  Future<bool> set(T value) {
    return AppPreferences.setValue<T>(this, value);
  }

  T get() {
    return AppPreferences.getValue<T>(this);
  }

  Future<bool> delete() {
    return AppPreferences.deleteValue<T>(this);
  }
}
