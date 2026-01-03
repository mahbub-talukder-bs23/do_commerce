import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final SecureStorage _instance = SecureStorage._internal();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  factory SecureStorage() {
    return _instance;
  }

  SecureStorage._internal();

  /// Write a key-value pair to the secure storage.
  ///
  /// [key] is the key of the value to be written.
  /// [value] is the value to be written.
  ///
  /// Returns a Future<void> that completes when the write operation is complete.
  ///
  /// Throws an exception if the write operation fails.
  Future<void> write({required String key, required String value}) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      throw Exception('Failed to write to secure storage: $e');
    }
  }

  /// Read a value from the secure storage.
  ///
  /// [key] is the key of the value to be read.
  ///
  /// Returns a Future<String?> that completes with the value read from the secure storage.
  ///
  /// Throws an exception if the read operation fails.
  Future<String?> read(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      throw Exception('Failed to read from secure storage: $e');
    }
  }

  /// Delete a value from the secure storage.
  ///
  /// [key] is the key of the value to be deleted.
  ///
  /// Returns a Future<void> that completes when the delete operation is complete.
  ///
  /// Throws an exception if the delete operation fails.
  Future<void> delete(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      throw Exception('Failed to delete from secure storage: $e');
    }
  }

  /// Delete all values from the secure storage.
  ///
  /// Returns a Future<void> that completes when the delete operation is complete.
  ///
  /// Throws an exception if the delete operation fails.
  Future<void> deleteAll() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      throw Exception('Failed to delete all from secure storage: $e');
    }
  }
}
