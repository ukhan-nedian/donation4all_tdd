class ServerException implements Exception {}

class SocketException implements Exception {}

class ApiException implements Exception {
  final String errorMessage;

  ApiException({required this.errorMessage});
}
