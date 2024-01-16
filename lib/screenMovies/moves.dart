import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/movie.dart';
import 'package:flutter_application_1/model/movieDetail.dart';
import 'package:flutter_application_1/screenMovies/movie.dart';
import 'package:transparent_image/transparent_image.dart';

class MyWidget extends StatelessWidget {
  List<MovieDetail> movies = [];
  MyWidget({super.key, required this.movies});

  List<Widget> buildMovies(BuildContext context) {
    List<Widget> list = [];
    for (var i = 0; i < movies.length; i++) {
      list.add(buildMovieInfo(
          movies[i], context)); // Pass an individual Movie object
    }
    return list;
  }

  Widget buildMovieInfo(MovieDetail movie, BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, screenMovie.routeName, arguments: movie);
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black.withOpacity(0.5),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(movie.movie!.posterUrl!),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.2), BlendMode.hardLight),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Text(
                "${movie.movie!.name}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.fade,
                ),
                maxLines: 2,
                textAlign: TextAlign.left,
                textDirection: TextDirection.ltr,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
            Positioned(
              top: 5,
              left: 5,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black.withOpacity(0.5)),
                child: Text(
                  "${movie.movie!.lang}",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView(
      children: [...buildMovies(context)],
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    ));
  }
}
