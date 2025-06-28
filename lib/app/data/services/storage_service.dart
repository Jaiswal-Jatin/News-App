import 'package:get_storage/get_storage.dart';

class StorageService {
  static final _storage = GetStorage();

  static const String _isLoggedInKey = 'is_logged_in';
  static const String _userNameKey = 'user_name';
  static const String _userEmailKey = 'user_email';
  static const String _favoritesKey = 'favorites';
  static const String _themeKey = 'theme_mode';
  static const String _languageKey = 'language';

  static Future<void> init() async {
    await GetStorage.init();
  }

  static bool get isLoggedIn => _storage.read(_isLoggedInKey) ?? false;

  static String get userName => _storage.read(_userNameKey) ?? '';

  static String get userEmail => _storage.read(_userEmailKey) ?? '';

  static List<String> get favorites =>
      List<String>.from(_storage.read(_favoritesKey) ?? []);

  static String get language => _storage.read(_languageKey) ?? 'hi';

  static bool get isDarkMode => _storage.read(_themeKey) ?? false;

  static Future<void> saveUserData({
    required String name,
    required String email,
  }) async {
    await _storage.write(_userNameKey, name);
    await _storage.write(_userEmailKey, email);
    await _storage.write(_isLoggedInKey, true);
  }

  static Future<void> logout() async {
    await _storage.remove(_userNameKey);
    await _storage.remove(_userEmailKey);
    await _storage.write(_isLoggedInKey, false);
  }

  static Future<void> addToFavorites(String articleId) async {
    List<String> currentFavorites = favorites;
    if (!currentFavorites.contains(articleId)) {
      currentFavorites.add(articleId);
      await _storage.write(_favoritesKey, currentFavorites);
    }
  }

  static Future<void> removeFromFavorites(String articleId) async {
    List<String> currentFavorites = favorites;
    currentFavorites.remove(articleId);
    await _storage.write(_favoritesKey, currentFavorites);
  }

  static Future<void> setLanguage(String languageCode) async {
    await _storage.write(_languageKey, languageCode);
  }

  static Future<void> setThemeMode(bool isDark) async {
    await _storage.write(_themeKey, isDark);
  }
}
