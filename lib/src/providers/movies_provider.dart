import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/models.dart';

class MoviesProvider extends ChangeNotifier{

  String _apiKey = 'd4b04982949db0aa3f6dbf8c2917be0b';
  String _baseUrl = 'api.themoviedb.org';
  String _language = "es-MX";

  List<Movie> onDisplayMovies = [];

  MoviesProvider(){
    print('MoviesProvider inicializado');

    this.getOnDisplayMovies();
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
}