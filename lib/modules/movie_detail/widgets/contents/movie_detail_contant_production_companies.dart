import 'package:flutter/material.dart';

import '../../../../models/movie_detail_model.dart';

class MovieDetailContantProductionCompanies extends StatelessWidget {
  final MovieDetailModel? movie;

  const MovieDetailContantProductionCompanies({Key? key, required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(bottom: 5),
      child: RichText(
        text: TextSpan(
            text: 'Companhia(s) produtora(s):',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF222222),
            ),
            children: [
              TextSpan(
                text: movie?.productionCompanies.join(', ') ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF222222),
                ),
              ),
            ]),
      ),
    );
  }
}
