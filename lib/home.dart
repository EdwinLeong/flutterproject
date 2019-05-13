import 'dart:core';
import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:projec_04/main.dart';
import 'package:projec_04/movie.dart';
import 'package:projec_04/home_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc _bloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    _bloc.fetchData();
  }

  Widget _buildItem(Movie m) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  //Padding(
                  //  padding: EdgeInsets.only(right: 6.0),
                  //),
                  Image.network(
                    'http://image.tmdb.org/t/p/w780/' + m.posterPath,
                    width: 150.0,
                    height: 150.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 200.0,
                        child: Text(m.title,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 1.0),
                      ),
                      Row(
                        textBaseline: TextBaseline.alphabetic,
                        //crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: <Widget>[
                          Container(
                              width: 200.0,
                              height: 50.0,
                              child: Text(
                                m.overview,
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),
                              ))
                        ],
                      )
                    ],
                  )
                ],
              )

              //Text(m.popularity.toString()),
              // Text(m.overview)
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push<Widget>(
          context,
          MaterialPageRoute<Widget>(
              builder: (BuildContext context) => MoviePage(movie: m)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.black,
        title: const Text('Movie'),
      ),
      body: StreamBuilder<List<Movie>>(
        stream: _bloc.getMovies,
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: const CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int i) {
              return _buildItem(snapshot.data[i]);
            },
          );
        },
      ),
    );
  }
}
