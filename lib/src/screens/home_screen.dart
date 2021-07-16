import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/movies_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';
import 'package:peliculas/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //ve la arbol de widgets, y taeme la isntancia de moviesProvider
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: true);

    return Scaffold(
        appBar: AppBar(
          title: Text('Peliculas en cines'),
          elevation: 0,
          actions: [
            IconButton(
                icon: Icon(Icons.search_outlined),
                onPressed: () {
                  showSearch(context: context, delegate: MovieSearchDelegate());
                })
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //Tarjetas Principales
              CardSwiper(movies: moviesProvider.onDisplayMovies),
              //Slider de peliculas
              MovieSlider(
                movies: moviesProvider.popularMovies,
                title: 'Populares',
                onNextPage: () {
                  moviesProvider.getPopularMovies();
                },
              )
            ],
          ),
        ));
  }
}
