import 'package:app_filmes/application/rest_client/rest_client.dart';
import 'package:app_filmes/models/movie_detail_model.dart';
import 'package:app_filmes/models/movie_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import './movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final RestClient _restClient;
  MoviesRepositoryImpl({required RestClient restClient})
      : _restClient = restClient;

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final result = await _restClient.get('/movie/popular', query: {
      'api_key': FirebaseRemoteConfig.instance.getString('api_token'),
      'language': 'pt-br',
      'page': '1'
    }, decoder: (data) {
      final resultData = data['results'];

      if (resultData != null) {
        return resultData
            .map<MovieModel>((movie) => MovieModel.fromMap(movie))
            .toList();
      }
      return <MovieModel>[];
    });

    if (result.hasError) {
      print('Erro  ao buscar popular movies [${result.statusText}]');
      throw Exception('Erro ao buscar popular Filmes');
    }

    return result.body;
  }

  @override
  Future<List<MovieModel>> getTopRated() async {
    final result = await _restClient.get('/movie/top_rated', query: {
      'api_key': FirebaseRemoteConfig.instance.getString('api_token'),
      'language': 'pt-br',
      'page': '1'
    }, decoder: (data) {
      final resultData = data['results'];

      if (resultData != null) {
        return resultData
            .map<MovieModel>((movie) => MovieModel.fromMap(movie))
            .toList();
      }
      return <MovieModel>[];
    });

    if (result.hasError) {
      print('Erro  ao buscar top movies [${result.statusText}]');
      throw Exception('Erro ao buscar top Filmes');
    }

    return result.body;
  }

  @override
  Future<MovieDetailModel?> getDetail(int id) async {
    final result = await _restClient.get<MovieDetailModel?>(
      '/movie/$id',
      query: {
        'api_key': FirebaseRemoteConfig.instance.getString('api_token'),
        'language': 'pt-br',
        'append_to_response': 'images,credits',
        'include_image_language': 'en,pt-br',
      },
      decoder: (data) => MovieDetailModel.fromMap(data),
    );

    if (result.hasError) {
      print('Erro ao buscar detalhe do filme [${result.statusText}]');
      throw Exception('Erro ao buscar detalhe do filme');
    }

    return result.body;
  }

  @override
  Future<void> addOrRemoveFavorite(String userId, MovieModel movie) async {
    try {
      var favoriteCollection = FirebaseFirestore.instance
          .collection('favorities')
          .doc(userId)
          .collection('movies');

      if (movie.favorite) {
        favoriteCollection.add(movie.toMap());
      } else {
        var favoriteData = await favoriteCollection
            .where('id', isEqualTo: movie.id)
            .limit(1)
            .get();

        favoriteData.docs.first.reference.delete();

        // var docs = favoriteData.docs;

        // for (var doc in docs) {
        //   doc.reference.delete();
        // }
      }
    } catch (e) {
      print('Erro ao favoritar filme');
      rethrow;
    }
  }

  @override
  Future<List<MovieModel>> getFavoritiesMovies(String userId) async {
    var favoritiesMovies = await FirebaseFirestore.instance
        .collection('favorities')
        .doc(userId)
        .collection('movies')
        .get();

    var listFavorites = <MovieModel>[];

    for (var movie in favoritiesMovies.docs) {
      listFavorites.add(MovieModel.fromMap(movie.data()));
    }

    return listFavorites;
  }
}
