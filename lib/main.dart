import 'package:flutter/material.dart';
import 'package:peliculas/src/pages/home_page.dart';
import 'package:peliculas/src/pages/pelicula_detalle.dart';
import 'package:peliculas/src/screens/details_screen.dart';
import 'package:peliculas/src/screens/home_screen.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pelculas',
      initialRoute: 'home',
      routes: {
        '/' : (BuildContext context) => HomePage(),
        'home' : ( _ ) => HomeScreen(),
        'details' : ( _ ) => DetailsScreen(),
        'detalle' : (BuildContext context) => PeliculaDetalle(),
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          color: Colors.indigo
        )
      ),
    );
  }
}