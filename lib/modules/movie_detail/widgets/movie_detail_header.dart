import 'package:flutter/material.dart';

import '../../../models/movie_detail_model.dart';

class MovieDetailHeader extends StatelessWidget {
  final MovieDetailModel? movie;

  const MovieDetailHeader({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var movieData = movie;
    if (movieData != null) {
      return SizedBox(
        height: 278,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movieData.urlImages.length,
          itemBuilder: ((context, index) {
            final image = movieData.urlImages[index];
            return Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.network(image, fit: BoxFit.cover),
            );
          }),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
