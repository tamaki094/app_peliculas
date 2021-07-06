import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:peliculas/src/models/models.dart';


class CardSwiper extends StatelessWidget {

  final List<Movie> movies;

  const CardSwiper({Key key, this.movies}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      color: Colors.white,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.9,
        itemBuilder: (BuildContext context, int index){

          final movie = movies[index];
          print(movie.fullPosterImg);

          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: 'movie-details'),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child:  FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                fit: BoxFit.cover
              )
            ),
          );    
        }
      )
    );
  }
}