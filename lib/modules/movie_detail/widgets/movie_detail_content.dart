import 'package:app_filmes/models/movie_detail_model.dart';
import 'package:app_filmes/modules/movie_detail/widgets/contents/movie_detail_content_credits.dart';
import 'package:flutter/material.dart';

import 'contents/movie_detail_contant_production_companies.dart';
import 'contents/movie_detail_content_main_cast.dart';
import 'contents/movie_detail_content_title.dart';

class MovieDetailContent extends StatelessWidget {
  final MovieDetailModel? movie;

  const MovieDetailContent({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieDetailContentTitle(movie: movie),
        MovieDetailContentCredits(movie: movie),
        MovieDetailContantProductionCompanies(movie: movie),
        MovieDetailContentMainCast(movie: movie),
      ],
    );
  }
}
