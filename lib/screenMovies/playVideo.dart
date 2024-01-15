import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/movieDetail.dart';
import 'package:flutter_application_1/screenMovies/webView.dart';
import 'package:webview_flutter/webview_flutter.dart';

class playVideo extends StatefulWidget {
  static const routeName = '/playVideo';
  const playVideo({super.key});

  @override
  State<playVideo> createState() => _playVideoState();
}

class _playVideoState extends State<playVideo> {
  var controller;
  String? currentUrl;
  MovieDetail? movieDetail;
  String? episode;
  String? serverName;

  @override
  void initState() {
    super.initState();
  }

  Widget hanldeBackButton() {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ],
    );
  }

  List<Widget> renderListEpisode(List<ServerData> serverDatas) {
    List<Widget> listEpisode = [];

    serverDatas.forEach((element) {
      listEpisode.add(Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: InkWell(
          onTap: () => setState(() {
            currentUrl = element.linkEmbed;
            episode = element.name!;
            print(episode);
          }),
          child: Container(
            padding: EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color.fromARGB(255, 40, 39, 39),
            ),
            child: Text(
              element!.name!,
              style: TextStyle(
                color: episode == element!.name! ? Colors.green : Colors.white,
              ),
            ),
          ),
        ),
      ));
    });

    return listEpisode;
  }

  List<Widget> hanldeEpisode(List<Episodes> episodes) {
    List<Widget> listEpisode = [];

    episodes.forEach((element) {
      listEpisode.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            element.serverName!,
            style: TextStyle(color: Colors.white),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: renderListEpisode(element.serverData!)),
          )
        ],
      ));
    });

    return listEpisode;
  }

  @override
  Widget build(BuildContext context) {
    final Object? args = ModalRoute.of(context)?.settings.arguments;
    movieDetail = args as MovieDetail;
    serverName = this.serverName ?? movieDetail!.episodes![0]!.serverName!;
    currentUrl =
        this.currentUrl ?? movieDetail!.episodes![0]!.serverData![0]!.linkEmbed;
    episode = this.episode ?? movieDetail!.episodes![0]!.serverData![0]!.name!;
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(currentUrl!));
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 220,
              child: Container(
                child: controller != null
                    ? WebViewWidget(controller: controller)
                    : Container(),
              ),
            ),
            infoMovie(movieDetail: movieDetail!.movie),
            showActor(actors: movieDetail!.movie!.actor),
            iConActions(),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [...hanldeEpisode(movieDetail!.episodes!)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class infoMovie extends StatelessWidget {
  MovieInfo? movieDetail;
  infoMovie({super.key, this.movieDetail});

  Widget renderBoxsize() {
    return Text("|", style: TextStyle(fontSize: 14, color: Colors.white));
  }

  List renderInfo(dynamic content) {
    return [
      SizedBox(
        width: 5,
      ),
      content,
      SizedBox(
        width: 5,
      ),
      renderBoxsize()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(movieDetail!.name!,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
          Text(
            "${movieDetail!.view} lượt xem",
            style: TextStyle(color: Colors.white),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.star,
                color: Colors.green,
              ),
              Text(
                "10.0 >",
                style: TextStyle(fontSize: 15, color: Colors.green),
              ),
              ...renderInfo(
                Text(
                  "${movieDetail!.year}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
              ...renderInfo(Container(
                padding: EdgeInsets.all(2),
                color: Colors.grey,
                child: Text("${movieDetail!.lang}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                    )),
              )),
              ...renderInfo(Container(
                padding: EdgeInsets.all(2),
                color: Colors.grey,
                child: Text("${movieDetail!.quality}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                    )),
              )),
              ...renderInfo(Container(
                padding: EdgeInsets.all(2),
                color: Colors.grey,
                child: Text("${movieDetail!.country![0].name}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                    )),
              )),
            ],
          ),
        ],
      ),
    );
  }
}

class showActor extends StatelessWidget {
  List<String>? actors;

  showActor({super.key, this.actors});

  List<Widget> renderActors(List<String> actors) {
    List<Widget> listActors = [];
    actors.forEach((element) {
      listActors.add(Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
        child: Row(
          children: [
            Container(
                width: 35,
                height: 35,
                child:
                    Center(child: Text("GO", style: TextStyle(fontSize: 50))),
                decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: CircleBorder(
                            side: BorderSide(width: 10, color: Colors.white)) +
                        CircleBorder(
                            side: BorderSide(width: 20, color: Colors.white)))),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  element,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "Diễn viên",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            )
          ],
        ),
      ));
    });
    return listActors;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...renderActors(actors!),
          ],
        ),
      ),
    );
  }
}

class iConActions extends StatelessWidget {
  const iConActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(children: [
        Icon(
          Icons.download_sharp,
          color: Colors.white,
        ),
        SizedBox(
          width: 15,
        ),
        Icon(
          Icons.plus_one_outlined,
          color: Colors.white,
        ),
        SizedBox(
          width: 15,
        ),
        Icon(
          Icons.share_sharp,
          color: Colors.white,
        ),
      ]),
    );
  }
}
