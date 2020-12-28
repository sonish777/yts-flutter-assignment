import 'dart:convert';

import 'package:flutter_assingment_2/models/movie_cast_model.dart';
import 'package:flutter_assingment_2/models/movie_model.dart';
import 'package:flutter_assingment_2/models/quality_size_model.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart';

class MovieDetailController extends GetxController {
  String _id;
  MovieDetailController(String id) {
    this._id = id;
    init();
  }
  MovieModel _model;
  MovieModel get movieModel => _model;

  void init() async {
    String url =
        'https://yts.mx/api/v2/movie_details.json?movie_id=$_id&with_cast=true';
    Response res = await get(url);
    Map movieData = jsonDecode(res.body)["data"]["movie"];
    List<QualitySizeModel> qsModelList = [];
    List<MovieCastModel> movieCastModelList = [];
    for (int i = 0; i < movieData["torrents"].length; i++) {
      QualitySizeModel qsModel = QualitySizeModel(
          quality: movieData["torrents"][i]["quality"],
          size: movieData["torrents"][i]["size"],
          type: movieData["torrents"][i]["type"]);
      qsModelList.add(qsModel);
    }
    if (movieData["cast"] != null)
      for (int i = 0; i < movieData["cast"].length; i++) {
        MovieCastModel movieCastModel = MovieCastModel(
          name: movieData["cast"][i]["name"],
          characterName: movieData["cast"][i]["character_name"],
          imageUrl: movieData["cast"][i]["url_small_image"],
        );
        movieCastModelList.add(movieCastModel);
      }
    MovieModel model = MovieModel(
        description: movieData["description_intro"],
        id: movieData["id"].toString(),
        imageUrl: movieData["medium_cover_image"],
        rating: movieData["rating"].toString(),
        runtime: movieData["runtime"],
        likeCount: movieData["like_count"],
        title: movieData["title"],
        year: movieData["year"].toString(),
        casts: movieCastModelList,
        qsmodel: qsModelList);
    _model = model;
    print(_model);
    update();
  }
}
