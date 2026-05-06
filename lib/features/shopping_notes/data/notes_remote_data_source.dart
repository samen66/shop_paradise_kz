import 'package:dio/dio.dart';

/// Best-effort HTTP echo used as a stand-in for a real sync API (MVP demo).
class NotesRemoteDataSource {
  NotesRemoteDataSource({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  /// Posts JSON; failures are ignored by the repository when syncing.
  Future<void> pushNotePayload(Map<String, dynamic> payload) async {
    await _dio.post<Map<String, dynamic>>(
      'https://httpbin.org/post',
      data: payload,
      options: Options(
        sendTimeout: const Duration(seconds: 8),
        receiveTimeout: const Duration(seconds: 8),
      ),
    );
  }
}
