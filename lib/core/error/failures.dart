import 'package:dio/dio.dart';

/// Base failure used by repositories and presentation.
sealed class Failure {
  const Failure(this.message);

  final String message;
}

final class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Network connection failed.']);
}

final class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server responded with an error.']);
}

final class ParsingFailure extends Failure {
  const ParsingFailure([super.message = 'Failed to parse server response.']);
}

Failure mapDioExceptionToFailure(DioException exception) {
  if (exception.type == DioExceptionType.connectionError ||
      exception.type == DioExceptionType.connectionTimeout ||
      exception.type == DioExceptionType.sendTimeout ||
      exception.type == DioExceptionType.receiveTimeout) {
    return const NetworkFailure();
  }
  return ServerFailure(exception.message ?? 'Request failed.');
}
