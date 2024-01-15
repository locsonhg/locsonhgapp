import 'package:flutter_application_1/model/movieDetail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import "./model/movie.dart";

class fetchApi {
  final String url = "https://ophim1.com";

  final int totalMovie = 25168;
  final int pageSize = 24;
  final int totalPage = 1049;
  final int currentPage = 1;

  Future<List<Movie>> fetchMovies(String page) async {
    final res = await http
        .get(Uri.parse("${url}/danh-sach/phim-moi-cap-nhat?page=${page}"));
    if (res.statusCode == 200) {
      return paserMovies(res.body);
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<MovieDetail> fetchMovieDetail(String slug) async {
    final res = await http.get(Uri.parse("${url}/phim/${slug}"));
    if (res.statusCode == 200) {
      return paserMovieDetail(res.body);
    } else {
      throw Exception('Failed to load movie detail');
    }
  }

  MovieDetail paserMovieDetail(String responeBody) {
    var data = convert.jsonDecode(responeBody);
    MovieDetail movieDetail = MovieDetail.fromJson(data);
    return movieDetail;
  }

  List<Movie> paserMovies(String responeBody) {
    var list = convert.jsonDecode(responeBody)["items"] as List<dynamic>;
    List<Movie> movies = list.map((e) => Movie.fromJson(e)).toList();
    return movies;
  }
}
