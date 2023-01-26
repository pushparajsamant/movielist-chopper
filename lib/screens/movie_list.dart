import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/popular.dart';
import '../service/movie_service.dart';

const imageUrl = 'https://image.tmdb.org/t/p/original/';

class MovieList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Popular Movies List'),
        ),
        body: _buildBody(context),
      ),
    );
  }

  // 1
  FutureBuilder<Response<Popular>> _buildBody(BuildContext context) {
    return FutureBuilder<Response<Popular>>(
      // 2
      future: Provider.of<MovieService>(context).getPopularMovies(),
      builder: (context, snapshot) {
        // 3
        if (snapshot.connectionState == ConnectionState.done) {
          // 4
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                textAlign: TextAlign.center,
                textScaleFactor: 1.3,
              ),
            );
          }
          // 5
          final popular = snapshot.data?.body;
          // 6
          return _buildMovieList(context, popular!);
        } else {
          // 7
          // Show a loading indicator while waiting for the movies
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListView _buildMovieList(BuildContext context, Popular popular) {
    // 1
    var popularResults = popular.results!;
    return ListView.builder(
      // 2
      itemCount: popularResults.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        // 3
        return Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 150,
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          // 4
                          image: NetworkImage(
                              imageUrl + popularResults[index].posterPath!),
                          fit: BoxFit.contain)),
                ),
                Expanded(
                  child: Container(
                    height: 200,
                    child: Column(
                      children: <Widget>[
                        // 5
                        Text(
                          popularResults[index].title!,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Expanded(
                            child: Container(
                                child: Text(
                          // 6
                          popularResults[index].overview!,
                          style: const TextStyle(fontSize: 12),
                        ))),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
