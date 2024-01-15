import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/movie.dart';
import 'package:flutter_application_1/model/movieDetail.dart';
import 'package:flutter_application_1/screenMovies/playVideo.dart';

class screenMovie extends StatefulWidget {
  static const routeName = '/screenMovie';
  MovieDetail? movie;
  screenMovie({super.key, this.movie});

  @override
  State<screenMovie> createState() => _screenMovieState();
}

class _screenMovieState extends State<screenMovie> {
  MovieDetail? movieDetail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieDetail = widget.movie;
  }

  String _renderStringWithList(List<String> list) {
    String result = "";
    for (var i = 0; i < list.length; i++) {
      result += list[i];
      if (i < list.length - 1) {
        result += ", ";
      }
    }
    return result;
  }

  String _renderStringWithListMap(List<dynamic> list) {
    String result = "";
    for (var i = 0; i < list.length; i++) {
      result += list[i]!.name;
      if (i < list.length - 1) {
        result += ", ";
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final Object? args = ModalRoute.of(context)?.settings.arguments;
    this.movieDetail = args as MovieDetail?;
    print(movieDetail.toString());
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: NetworkImage(movieDetail!.movie!.thumbUrl!),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.7), BlendMode.hardLight),
          )),
        ),
        Positioned(
          top: 30,
          left: 5,
          right: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => {Navigator.pop(context)},
                    icon: Icon(Icons.arrow_back_ios_new_rounded),
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () => {Navigator.pop(context)},
                    icon: Icon(Icons.search),
                    color: Colors.white,
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 250,
                    width: 150,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(movieDetail!.movie!.thumbUrl!),
                            fit: BoxFit.fill,
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Flexible(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${movieDetail!.movie!.name}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.fade,
                              ),
                              maxLines: 3,
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.left,
                              softWrap: true),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.black.withOpacity(0.5)),
                            child: Text(
                              "${movieDetail!.movie!.lang} - ${movieDetail!.movie!.quality} - ${movieDetail!.movie!.year}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Text(
                              "Tập: ${movieDetail!.movie!.episodeTotal ?? "1"}",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                          Text("Thời gian: ${movieDetail!.movie!.time ?? "1"}",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                          Text("${movieDetail!.movie!.view} lượt xem",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () => {
                              Navigator.pushNamed(context, playVideo.routeName,
                                  arguments: movieDetail)
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 10),
                                textStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            child: const Text(
                              "Xem phim",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  "Tác giả: ${_renderStringWithList(movieDetail!.movie!.actor!)}",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.ltr,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  "Thể loại: ${_renderStringWithListMap(movieDetail!.movie!.category!)}",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.ltr,
                ),
              ),
              Row(
                children: [
                  Flexible(
                      child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      "Nội dung phim: ${movieDetail!.movie!.content}",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                      maxLines: 10,
                      textAlign: TextAlign.justify,
                      textDirection: TextDirection.ltr,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
                ],
              )
            ],
          ),
        )
      ],
    ));
  }
}
