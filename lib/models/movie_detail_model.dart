import 'dart:convert';

import 'package:app_filmes/models/cast_model.dart';
import 'package:app_filmes/models/genre_model.dart';

class MovieDetailModel {
  final String title;
  final double stars;
  final List<GenreModel> genres;
  final List<String> urlImages;
  final DateTime releaseDate;
  final String overview;
  final List<String> productionCompanies;
  final String originalLanguage;
  final List<CastModel> cast;
  MovieDetailModel({
    required this.title,
    required this.stars,
    required this.genres,
    required this.urlImages,
    required this.releaseDate,
    required this.overview,
    required this.productionCompanies,
    required this.originalLanguage,
    required this.cast,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'vote_average': stars});
    result.addAll({'genres': genres.map((x) => x.toMap()).toList()});
    result.addAll({'urlImages': urlImages});
    result.addAll({'release_date': releaseDate.millisecondsSinceEpoch});
    result.addAll({'overview': overview});
    result.addAll({'production_companies': productionCompanies});
    result.addAll({'original_language': originalLanguage});
    result.addAll({'cast': cast.map((x) => x.toMap()).toList()});

    return result;
  }

  factory MovieDetailModel.fromMap(Map<String, dynamic> map) {
    var urlImagesPosters = map['images']['posters'];
    var urlImages = urlImagesPosters
            ?.map<String>(
                (i) => 'https://image.tmdb.org/t/p/w200${i['file_path']}')
            .toList() ??
        [];

    return MovieDetailModel(
      title: map['title'] ?? '',
      stars: map['vote_average']?.toDouble() ?? 0.0,
      genres: List<GenreModel>.from(
          map['genres'].map((x) => GenreModel.fromMap(x))),
      urlImages: urlImages,
      releaseDate: DateTime.parse(map['release_date']),
      overview: map['overview'] ?? '',
      productionCompanies: List<dynamic>.from(map['production_companies'] ?? [])
          .map<String>((p) => p['name'])
          .toList(),
      originalLanguage: map['original_language'] ?? '',
      cast: List<CastModel>.from(
          map['credits']['cast'].map((x) => CastModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieDetailModel.fromJson(String source) =>
      MovieDetailModel.fromMap(json.decode(source));
}
