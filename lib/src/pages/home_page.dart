import 'package:flutter/material.dart';
import 'package:peliculas/src/models/movie_model.dart';
import 'package:peliculas/src/providers/movies_provider.dart';

import '../widgets/card_swiper_widget.dart';
import '../widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final moviesProvider = new MoviesProvider();
  @override
  Widget build(BuildContext context) {
    moviesProvider.getPopulars();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Peliculas en cines"),
        backgroundColor: Colors.indigoAccent,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _swiperTarjetas(),
          _footer(context),
        ],
      ),
    );
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
        future: moviesProvider.getInTheathers(),
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          if (snapshot.hasData) {
            return CardSwiper(peliculas: snapshot.data ?? []);
          } else {
            return const SizedBox(
              height: 400.0,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  Widget _footer(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              "Populares",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          const SizedBox(height: 5.0),
          StreamBuilder(
            stream: moviesProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List<Movie> movies = snapshot.data;
                return MovieHorizontal(
                  movies: movies,
                  nextPage: moviesProvider.getPopulars,
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
