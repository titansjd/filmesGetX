import 'package:app_filmes/application/rest_client/rest_client.dart';
import 'package:app_filmes/models/movie_model.dart';
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
      final resultData = data[''];

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

    return <MovieModel>[];
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

    return <MovieModel>[];
  }
}
