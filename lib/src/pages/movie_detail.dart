import 'package:flutter/material.dart';
import 'package:peliculas/src/models/movie_model.dart';

class MovieDetail extends StatelessWidget {
  const MovieDetail({Key? key, Movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ModalRoute.of(context)?.settings.arguments as Movie?;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _crearAppbar(movie),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(
                  height: 10.0,
                ),
                _posterTitulo(movie: movie, context: context),
                _description(movie),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearAppbar(Movie? movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigo,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie!.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        background: FadeInImage(
          image: NetworkImage(
            movie.getBackgroundImg(),
          ),
          placeholder: const AssetImage('assets/img/loading.gif'),
          fadeInDuration: const Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitulo({
    @required Movie? movie,
    @required BuildContext? context,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: NetworkImage(movie!.getPosterImg()),
              height: 150,
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: Theme.of(context!).textTheme.titleLarge,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  movie.originalTitle,
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Icon(Icons.star_border),
                    Text(
                      movie.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _description(Movie? movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        movie!.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
