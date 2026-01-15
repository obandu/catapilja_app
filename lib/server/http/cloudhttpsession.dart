import 'dart:math';
import 'dart:convert';

class CloudHttpSession {
  late String _sessionId;
  final _sessionData = <String, dynamic>{};

  // Constructor to initialize session with a generated ID
  CloudHttpSession() {
    _sessionId = _generateSessionId();
  }

  /// Generates a secure session ID using base64 encoding.
  String _generateSessionId([int length = 32]) {
    final random = Random.secure();
    final bytes = List<int>.generate(length, (_) => random.nextInt(256));
    return base64Url.encode(bytes);
  }

  /// Returns the session ID.
  String get sessionId => _sessionId;

  /// Sets a value in the session data.
  void set(String key, dynamic value) {
    _sessionData[key] = value;
  }

  /// Gets a value from the session data.
  dynamic get(String key) {
    return _sessionData[key];
  }
}
