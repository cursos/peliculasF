import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';

import '../models/movie_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> peliculas;
  const CardSwiper({Key? key, required this.peliculas}) : super(key: key);
//apikey: 298d753abbed0666c78bdb5607179797
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return SizedBox(
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: const AssetImage(
                'assets/img/no-image.jpg',
              ),
              image: NetworkImage(
                peliculas[index].getPosterImg(),
              ),
              fit: BoxFit.cover,
            ),
          );
        },
        itemCount: peliculas.length,
        /*   pagination: const SwiperPagination(),
        control: const SwiperControl(), */
      ),
    );
  }
}
