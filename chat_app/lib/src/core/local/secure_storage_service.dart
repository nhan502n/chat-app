import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  // Singleton pattern
  static final SecureStorageService _instance =
      SecureStorageService._internal();
  factory SecureStorageService() => _instance;

  SecureStorageService._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  /// Save a secure value
  Future<void> setItem(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Read a secure value
  Future<String?> getItem(String key) async {
    return await _storage.read(key: key);
  }

  /// Delete a single secure value
  Future<void> removeItem(String key) async {
    await _storage.delete(key: key);
  }

  /// Delete **all** secure values
  Future<void> clear() async {
    await _storage.deleteAll();
  }
}
