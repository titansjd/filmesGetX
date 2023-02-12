import 'dart:convert';

class MovieModel {
  final int id;
  final String title;
  final String releaseDate;
  final String posterPath;
  final List<int> genres;
  final bool favorite;

  MovieModel({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.posterPath,
    required this.genres,
    required this.favorite,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'release_date': releaseDate});
    result.addAll({'poster_path': posterPath});
    result.addAll({'genre_ids': genres});
    result.addAll({'favorite': favorite});

    return result;
  }

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      releaseDate: map['release_date'] ?? '',
      posterPath: map['poster_path'],
      genres: List<int>.from(map['genre_ids']),
      favorite: map['favorite'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieModel.fromJson(String source) =>
      MovieModel.fromMap(json.decode(source));

  MovieModel copyWith({
    int? id,
    String? title,
    String? releaseDate,
    String? posterPath,
    List<int>? genres,
    bool? favorite,
  }) {
    return MovieModel(
      id: id ?? this.id,
      title: title ?? this.title,
      releaseDate: releaseDate ?? this.releaseDate,
      posterPath: posterPath ?? this.posterPath,
      genres: genres ?? this.genres,
      favorite: favorite ?? this.favorite,
    );
  }
}
