class ServerException implements Exception {
  final String message;

  const ServerException({required this.message});

  @override
  String toString() {
    return 'ServerException: $message';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServerException &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}

class CacheException implements Exception {
  final String message;

  const CacheException({required this.message});

  @override
  String toString() {
    return 'CacheException: $message';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CacheException &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}

class LocationException implements Exception {
  final String message;

  const LocationException({required this.message});

  @override
  String toString() {
    return 'LocationException: $message';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationException &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}
