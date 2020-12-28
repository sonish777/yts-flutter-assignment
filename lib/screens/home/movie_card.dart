import 'package:flutter/material.dart';
import 'package:flutter_assingment_2/models/movie_model.dart';
import 'package:flutter_assingment_2/screens/movie_detail/movie_detail.dart';
import 'package:get/get.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;
  MovieCard({@required this.movie});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(MovieDetail(id: movie.id));
      },
      child: Container(
        width: Get.width * 0.45,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.white, width: 5)),
              child: Image.network(
                movie.imageUrl,
              ),
            ),
            SizedBox(height: 8),
            Text(movie.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white, fontSize: 18)),
            SizedBox(height: 8),
            Text(movie.year, style: TextStyle(color: Colors.white54)),
          ],
        ),
      ),
    );
  }
}
