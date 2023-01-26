import 'dart:async';
import 'package:chopper/chopper.dart';

// 1
class HeaderInterceptor implements RequestInterceptor {
  // 2
  static const String AUTH_HEADER = "Authorization";
  // 3
  static const String BEARER = "Bearer ";
  // 4
  static const String V4_AUTH_HEADER =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4MjlkY2IwMTcwMjdhMTNiYzI4MDVmZWU4NDQ4OGFjNiIsInN1YiI6IjYzZDBkYWVlYTQxMGM4MTIxNWI1ZTJmMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.owNkIW7k9xOqdRwAeXN2FacW3cVE3QWPGV9VUUk5NGk";

  @override
  FutureOr<Request> onRequest(Request request) async {
    // 5
    Request newRequest = request.copyWith(headers: {AUTH_HEADER: BEARER + V4_AUTH_HEADER});
    return newRequest;
  }

}
