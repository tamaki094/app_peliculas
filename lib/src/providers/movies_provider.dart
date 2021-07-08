import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/models.dart';
import 'package:peliculas/src/models/popular_response.dart';

class MoviesProvider extends ChangeNotifier{

  String _apiKey = 'd4b04982949db0aa3f6dbf8c2917be0b';
  String _baseUrl = 'api.themoviedb.org';
  String _language = "es-MX";

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  MoviesProvider(){
    print('MoviesProvider inicializado');

    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  getOnDisplayMovies() async{
     var  url = Uri.https(_baseUrl, '3/movie/now_playing', {
      'api_key' : _apiKey,
      'language': _language
    });

    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);

    onDisplayMovies= nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async{
    var  url = Uri.https(_baseUrl, '3/movie/popular', {
      'api_key' : _apiKey,
      'language': _language,
      'page': "1"
    });

    final response = await http.get(url);
    final popularResponse = PopularResponse.fromJson(response.body);

    popularMovies= [...popularMovies, ...popularResponse.results];
    print(popularMovies[0]);
    notifyListeners();
  }
}