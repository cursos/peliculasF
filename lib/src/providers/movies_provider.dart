import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/movie_model.dart';

class MoviesProvider {
  final String _apiKey = '298d753abbed0666c78bdb5607179797';
  final String _url = 'api.themoviedb.org';
  final String _language = 'es-ES';

  int _popularesPage = 0;
  bool _loading = false;

  List<Movie> _populares = [];

  final _popularesStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Movie>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController.close();
  }

  Future<List<Movie>> getInTheathers() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Movie>> getPopulars() async {
    if (_loading) return [];

    _loading = true;
    print("cargando pag: " + _popularesPage.toString());
    _popularesPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularesPage.toString()
    });

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);
    _loading = false;
    return resp;
  }

  Future<List<Movie>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final movies = new Movies.fromJsonList(decodeData['results']);

    return movies.items;
  }
}
