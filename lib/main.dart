// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/default.dart';
import 'package:flutter_application_1/model/movie.dart';
import 'package:flutter_application_1/model/movieDetail.dart';
import 'package:flutter_application_1/screenMovies/moves.dart';
import 'package:flutter_application_1/screenMovies/movie.dart';
import 'package:flutter_application_1/screenMovies/playVideo.dart';
import "./fetchApi.dart";
import "./screenMovies//sliderMovies.dart";

void main() {
  runApp(MaterialApp(
    title: "myapp",
    initialRoute: "/",
    routes: {
      "/screenMovie": (context) => screenMovie(),
      "/playVideo": (context) => const playVideo(),
    },
    home: const MyHomePage(),
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<MovieDetail> _movies = [];
  List<String> _listPage = [];
  String _selectedPage = "1";

  @override
  void initState() {
    super.initState();
    fetchApi().fetchMovies(_selectedPage).then((value) {
      for (var element in value) {
        fetchApi().fetchMovieDetail(element.slug!).then((movie) {
          setState(() {
            _movies.add(movie);
          });
        });
      }
    });
    for (var i = 1; i <= fetchApi().totalPage; i++) {
      _listPage.add("$i");
    }
  }

  void handleChoosePage(String page) {
    fetchApi().fetchMovies(page).then((value) {
      for (var element in value) {
        fetchApi().fetchMovieDetail(element.slug!).then((movie) {
          setState(() {
            _movies.add(movie);
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Danh sách phim"),
        actions: [
          Text("Tổng số trang: ${fetchApi().totalPage}"),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(10),
        child: Column(
          children: [
            sliderCarousel(movies: _movies),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Expanded(
                    child: Text(
                  "Phim mới nhất",
                  style: TextStyle(fontSize: 20),
                )),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(10),
                      hint: const Text("Chọn trang"),
                      isExpanded: true,
                      value: _selectedPage,
                      items: _listPage.map(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text('Trang $value'),
                          );
                        },
                      ).toList(),
                      onChanged: (String? value) {
                        // Handle onChanged event
                        setState(
                          () {
                            _selectedPage = value!;
                            _movies = [];
                          },
                        );
                        handleChoosePage(value!);
                      },
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            MyWidget(movies: _movies)
          ],
        ),
      ),
    );
  }
}
