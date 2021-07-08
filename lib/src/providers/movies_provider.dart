import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/models.dart';
import 'package:peliculas/src/models/popular_response.dart';

class MoviesProvider extends ChangeNotifier {
  String _apiKey = 'd4b04982949db0aa3f6dbf8c2917be0b';
  String _baseUrl = 'api.themoviedb.org';
  String _language = "es-MX";

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  int _popularPage = 0;

  MoviesProvider() {
    print('MoviesProvider inicializado');

    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  _getJsonData(String endpoint, [int page]) async {
    var url = Uri.https(_baseUrl, endpoint,
        {'api_key': _apiKey, 'language': _language, 'page': "$page"});
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await this._getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;

    final jsonData = await this._getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);

    popularMovies = [...popularMovies, ...popularResponse.results];
    print(popularMovies[0]);
    notifyListeners();
  }
}
