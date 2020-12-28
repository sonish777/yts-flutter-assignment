import 'package:flutter_assingment_2/models/movie_cast_model.dart';
import 'package:flutter_assingment_2/models/quality_size_model.dart';

class MovieModel {
  final String id, imageUrl, title, year, description, rating;
  final int runtime, likeCount;
  final List<QualitySizeModel> qsmodel;
  final List<MovieCastModel> casts;
  MovieModel(
      {this.id,
      this.imageUrl,
      this.title,
      this.year,
      this.description,
      this.rating,
      this.runtime,
      this.likeCount,
      this.qsmodel,
      this.casts});
}
