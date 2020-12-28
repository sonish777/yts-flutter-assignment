import 'package:flutter/material.dart';
import 'package:flutter_assingment_2/models/movie_cast_model.dart';
import 'package:flutter_assingment_2/models/movie_model.dart';
import 'package:flutter_assingment_2/models/quality_size_model.dart';
import 'package:flutter_assingment_2/screens/movie_detail/movie_detail_controller.dart';
import 'package:get/get.dart';

class MovieDetail extends StatefulWidget {
  final String id;
  MovieDetail({@required this.id});

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  int currentTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: MovieDetailController(widget.id),
        builder: (MovieDetailController controller) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 60,
              leading: Image.asset("assets/logo.png"),
              backgroundColor: Colors.brown.shade900,
            ),
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.indigo.shade900, Colors.deepOrange])),
              child: ListView(
                children: controller.movieModel == null
                    ? [LinearProgressIndicator()]
                    : [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _topMovieCard(controller.movieModel),
                            _topMovieDetails(controller.movieModel)
                          ],
                        ),
                        _dividerHorizontal(0.5),
                        _actors(controller.movieModel.casts),
                        _dividerHorizontal(0.5),
                        _torrents(controller.movieModel.qsmodel,
                            controller.movieModel.runtime.toString()),
                        _dividerHorizontal(0.5),
                      ],
              ),
            ),
          );
        });
  }

  Widget _actors(List<MovieCastModel> casts) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Text("Casts",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
            if (casts.length > 0)
              for (int i = 0; i < casts.length; i++) _actor(casts[i])
            else
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Text("Not Available", style: TextStyle(color: Colors.grey)),
              )
          ],
        ));
  }

  Widget _actor(MovieCastModel cast) {
    TextStyle style =
        TextStyle(fontWeight: FontWeight.bold, color: Colors.white);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          CircleAvatar(
              backgroundImage: NetworkImage(cast.imageUrl != null
                  ? cast.imageUrl
                  : "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png")),
          SizedBox(width: 10),
          Text(cast.name, style: TextStyle(color: Colors.grey)),
          Text(' as ${cast.characterName}', style: style),
        ],
      ),
    );
  }

  Widget _torrents(List<QualitySizeModel> qsModelList, String runtime) {
    return DefaultTabController(
      length: qsModelList.length,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              color: Colors.black26,
              height: 50,
              child: TabBar(
                indicatorColor: Colors.black45,
                indicatorWeight: 4,
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                onTap: (value) {
                  setState(() {
                    currentTabIndex = value;
                  });
                },
                tabs: [
                  for (int i = 0; i < qsModelList.length; i++)
                    Text(
                        '${qsModelList[i].quality}.${qsModelList[i].type.toUpperCase()}')
                ],
              ),
            ),
            Container(
              color: Colors.black45,
              child: _torrent(qsModelList[currentTabIndex], runtime),
            )
          ],
        ),
      ),
    );
  }

  Widget _torrent(QualitySizeModel qs, String runtime) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _iconText(Icons.folder_open, Colors.white54, qs.size),
          Divider(height: 20, color: Colors.white),
          _iconText(Icons.access_time, Colors.white54, '${runtime} hours'),
          Divider(height: 20, color: Colors.white),
          Row(children: [
            _tag(qs.quality, Colors.green, Colors.white),
            _tag(qs.type.toUpperCase(), Colors.green.shade800, Colors.white),
          ])
        ],
      ),
    );
  }

  Widget _tag(String text, Color backColor, Color textColor) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: backColor, borderRadius: BorderRadius.circular(5)),
      // height: 30,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text,
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _topMovieCard(MovieModel model) {
    TextStyle style = TextStyle(color: Colors.white, fontSize: 18);
    return Container(
      width: Get.width * 0.45,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          Text(model.title, style: style),
          SizedBox(height: 6),
          Text(model.year, style: style),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.white, width: 6)),
            child: Image.network(
              model.imageUrl,
              width: Get.width * 0.45,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _topMovieDetails(MovieModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(height: 15),
        _iconText(Icons.star_rate, Colors.green, model.rating.toString()),
        SizedBox(height: 5),
        _iconText(Icons.favorite, Colors.red, model.likeCount.toString()),
        _dividerHorizontal(0.5),
        Container(
          width: Get.width * 0.40,
          child: Text(
            model.description,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _iconText(IconData icon, Color iconColor, String text) {
    TextStyle style = TextStyle(color: Colors.white, fontSize: 18);
    return Row(children: [
      Icon(icon, color: iconColor),
      SizedBox(width: 20),
      Text(text, style: style),
    ]);
  }

  Widget _dividerHorizontal(double height) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
          height: height,
          child: Container(color: Colors.white54, width: Get.width * 0.40)),
    );
  }
}
