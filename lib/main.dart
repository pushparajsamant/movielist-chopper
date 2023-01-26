import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:popular_movies_tmdb/screens/movie_list.dart';
import 'package:popular_movies_tmdb/service/movie_service.dart';
import 'package:provider/provider.dart';

import 'models/popular.dart';


void main() {
  _setupLogging();
  runApp(MyApp());
}
void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      dispose: (context, MovieService service) => service.client.dispose(),
      create: (BuildContext context) => MovieService.create(),
      child: MaterialApp(
        home: MovieList(),
      ),
    );
  }

}
