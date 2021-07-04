import 'package:flutter/material.dart';


class DetailsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //TODO: CAMBIAR LUEFO POR INSTANCIA DE UNA MOVIE
    final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
            _PosterAndTitle()
          ] 
          ))
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true, 
        titlePadding: EdgeInsets.all(0),
        title: Container(
          color: Colors.black12,
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          child: Text('movie.title', style: TextStyle(fontSize: 16)
          )
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/img/loading.gif'),
          image:  NetworkImage('https://via.placeholder.com/300x400'),
          fit: BoxFit.cover,
        )
      )
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage('https://via.placeholder.com/300x400'),
              height: 150,
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'movie.title', 
                style: textTheme.headline5, 
                overflow: TextOverflow.ellipsis, 
                maxLines: 2
              ),
              Text(
                'movie.originalTitle', 
                style: textTheme.subtitle1, 
                overflow: TextOverflow.ellipsis, 
                maxLines: 1
              ),
              Row(
                children: [
                  Icon(Icons.star_outline, size: 15, color: Colors.grey),
                  SizedBox(width: 5),
                  Text('movie.voteAverage', style:textTheme.caption)
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}