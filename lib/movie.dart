import 'package:flutter/material.dart';
import 'package:projec_04/home.dart';
import 'package:projec_04/home_bloc.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({@required this.movie});

  final Movie movie;

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  Widget build(BuildContext context) {
    final Movie movie = widget.movie;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          movie.title,
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                child: Image.network(
                  'http://image.tmdb.org/t/p/w780/' + movie.posterPath,
                ),
              ),
              Container(
                child: Text(
                  movie.popularity.toString(),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                child: Text(
                  movie.overview,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
