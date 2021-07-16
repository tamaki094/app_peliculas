import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/models.dart';
import 'package:peliculas/src/models/popular_response.dart';
import 'package:peliculas/src/models/search_movie_response.dart';

class MoviesProvider extends ChangeNotifier {
  String _apiKey = 'd4b04982949db0aa3f6dbf8c2917be0b';
  String _baseUrl = 'api.themoviedb.org';
  String _language = "es-MX";

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;

  MoviesProvider() {
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  _getJsonData(String endpoint, [int page]) async {
    var url;
    if (page != null) {
      url = Uri.https(_baseUrl, endpoint,
          {'api_key': _apiKey, 'language': _language, 'page': "$page"});
    } else {
      url = Uri.https(
          _baseUrl, endpoint, {'api_key': _apiKey, 'language': _language});
    }
    print(url);
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
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId];
    print('pididendo info al servidor - Cast');

    final jsonData = await this._getJsonData('3/movie/$movieId/credits');
    final creditResponse = CreditsResponse.fromJson(jsonData);

    moviesCast[movieId] = creditResponse.cast;

    return creditResponse.cast;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': "$query"});

    final response = await http.get(url);
    final searchMovieResponse = SearchMovieResponse.fromJson(response.body);

    return searchMovieResponse.results;
  }
}
