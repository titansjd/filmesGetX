import 'package:app_filmes/application/auth/auth_service.dart';
import 'package:app_filmes/models/movie_model.dart';
import 'package:app_filmes/services/movies/movies_service.dart';
import 'package:get/get.dart';

class FavoritesController extends GetxController {
  final MoviesService _moviesService;
  final AuthService _authService;

  var movies = <MovieModel>[].obs;

  FavoritesController({
    required MoviesService moviesService,
    required AuthService authService,
  })  : _moviesService = moviesService,
        _authService = authService;

  @override
  Future<void> onReady() async {
    super.onReady();

    await getFavorites();
  }

  Future<void> getFavorites() async {
    var userLogged = _authService.user;
    if (userLogged != null) {
      var favorites = await _moviesService.getFavoritiesMovies(userLogged.uid);
      movies.assignAll(favorites);
    }
  }

  Future<void> removeFavorite(MovieModel movie) async {
    var userLogged = _authService.user;

    if (userLogged != null) {
      await _moviesService.addOrRemoveFavorite(
        userLogged.uid,
        movie.copyWith(favorite: false),
      );

      movies.remove(movie);
    }
  }
}
