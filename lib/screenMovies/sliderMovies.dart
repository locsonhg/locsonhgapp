import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/movieDetail.dart';
import 'package:flutter_application_1/screenMovies/movie.dart';

class sliderCarousel extends StatelessWidget {
  List<MovieDetail>? movies = [];
  sliderCarousel({super.key, this.movies});

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
                child: Column(
                  children: [
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(movie.movie!.posterUrl!),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.2),
                                BlendMode.hardLight),
                          )),
                    )),
                  ],
                )),
            Positioned(
              bottom: 10,
              left: 10,
              child: Text("${movie.movie!.name}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.fade,
                  ),
                  maxLines: 2,
                  softWrap: false),
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
    return CarouselSlider.builder(
      itemCount: movies?.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          movies!.length > 0 && movies != null
              ? buildMovieInfo(movies![itemIndex], context)
              : Container(),
      options: CarouselOptions(
        height: 200,
        viewportFraction: 0.8,
        enlargeCenterPage: true,
        autoPlay: true,
      ),
    );
  }
}
