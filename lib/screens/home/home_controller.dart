import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_assingment_2/models/movie_model.dart';
import 'package:flutter_assingment_2/screens/home/movie_card.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart';

class HomeController extends GetxController {
  List<Widget> _movieCards = [];
  List<Widget> get movieCards => _movieCards;
  int _page = 1;

  HomeController() {
    _movieCards = [CircularProgressIndicator()];
    update();
    init();
  }

  void init() async {
    await loadMovies();
    update();
  }

  void nextPage() async {
    _page++;
    _movieCards = [CircularProgressIndicator()];
    update();
    await loadMovies();
    update();
  }

  void prevPage() async {
    if (_page > 1) {
      _page--;
      _movieCards = [CircularProgressIndicator()];
      update();
      await loadMovies();
      update();
    }
  }

  Future<void> loadMovies({int page}) async {
    String url = "https://yts.mx/api/v2/list_movies.json?page=$_page";
    Response res = await get(url);
    List moviesList = jsonDecode(res.body)["data"]["movies"];
    List<Widget> tempList = [];
    for (int i = 0; i < moviesList.length; i++) {
      MovieModel model = MovieModel(
          id: moviesList[i]["id"].toString(),
          imageUrl: moviesList[i]["medium_cover_image"],
          title: moviesList[i]["title"],
          year: moviesList[i]["year"].toString());
      tempList.add(MovieCard(movie: model));
    }
    _movieCards = tempList;
  }
}
