// 1
import 'package:chopper/chopper.dart';

import '../models/popular.dart';
// 2
import 'header.interceptor.dart';

import 'model_converter.dart';
// 3
part 'movie_service.chopper.dart';

// 4
@ChopperApi()
// 5
abstract class MovieService extends ChopperService {

  // 6
  @Get(path: 'movie/popular')
  // 7
  Future<Response<Popular>> getPopularMovies();

  // 8
  static MovieService create() {
    // 9
    final client = ChopperClient(
      // 10
      baseUrl: Uri.parse('https://api.themoviedb.org/3'),
      interceptors: [HeaderInterceptor(), HttpLoggingInterceptor()],
      converter: ModelConverter(),
      // 11
      services: [
        _$MovieService(),
      ],
    );
    // 12
    return _$MovieService(client);
  }
}