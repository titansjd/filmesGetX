import 'package:app_filmes/application/auth/auth_service.dart';
import 'package:app_filmes/application/ui/messages/messages_mixin.dart';
import 'package:app_filmes/models/genre_model.dart';
import 'package:app_filmes/models/movie_model.dart';
import 'package:app_filmes/services/genres/genres_service.dart';
import 'package:get/get.dart';

import '../../services/movies/movies_service.dart';

class MoviesController extends GetxController with MessagesMixin {
  final GenresService _genresService;
  final MoviesService _moviesService;
  final AuthService _authService;

  final _message = Rxn<MessageModel>();

  final genres = <GenreModel>[].obs;

  final popularMovies = <MovieModel>[].obs;
  final topRatedMovies = <MovieModel>[].obs;

  var _popularMoviesOriginal = <MovieModel>[];
  var _topRatedMoviesOriginal = <MovieModel>[];

  final genreSelected = Rxn<GenreModel>();

  MoviesController({
    required GenresService genresService,
    required MoviesService moviesService,
    required AuthService authService,
  })  : _genresService = genresService,
        _moviesService = moviesService,
        _authService = authService;

  @override
  void onInit() {
    super.onInit();
    messageListener(_message);
  }

  @override
  Future<void> onReady() async {
    super.onReady();

    final genresData = await _genresService.getGenres();
    genres.assignAll(genresData);

    await getMovies();
  }

  Future<void> getMovies() async {
    try {
      var popularMoviesData = await _moviesService.getPopularMovies();
      var topRatedMoviesData = await _moviesService.getTopRated();
      final favorites = await getFavorites();

      popularMoviesData = popularMoviesData.map((element) {
        if (favorites.containsKey(element.id)) {
          return element.copyWith(favorite: true);
        } else {
          return element.copyWith(favorite: false);
        }
      }).toList();

      topRatedMoviesData = topRatedMoviesData.map((element) {
        if (favorites.containsKey(element.id)) {
          return element.copyWith(favorite: true);
        } else {
          return element.copyWith(favorite: false);
        }
      }).toList();

      popularMovies.assignAll(popularMoviesData);

      _popularMoviesOriginal = popularMoviesData;
      _topRatedMoviesOriginal = topRatedMoviesData;

      topRatedMovies.assignAll(topRatedMoviesData);
    } catch (e, s) {
      print(e);
      print(s);

      _message(MessageModel.error(
          title: 'Erro', message: 'Erro ao carregar dados da pagina'));
    }
  }

  void filterByName(String title) {
    if (title.isNotEmpty) {
      var newPopularMovies = _popularMoviesOriginal.where((movie) {
        return movie.title.toLowerCase().contains(title.toLowerCase());
      });

      var newTopRatedMovies = _topRatedMoviesOriginal.where((movie) {
        return movie.title.toLowerCase().contains(title.toLowerCase());
      });

      popularMovies.assignAll(newPopularMovies);
      topRatedMovies.assignAll(newTopRatedMovies);
    } else {
      popularMovies.assignAll(_popularMoviesOriginal);
      topRatedMovies.assignAll(_topRatedMoviesOriginal);
    }
  }

  void filterMoviesByGenre(GenreModel? genreModel) {
    var genreFilter = genreModel;

    if (genreFilter?.id == genreSelected.value?.id) {
      genreFilter = null;
    }

    genreSelected.value = genreFilter;

    if (genreFilter != null) {
      var newPopularMovies = _popularMoviesOriginal.where((movie) {
        return movie.genres.contains(genreModel?.id);
      });

      var newTopRatedMovies = _topRatedMoviesOriginal.where((movie) {
        return movie.genres.contains(genreModel?.id);
      });
      popularMovies.assignAll(newPopularMovies);
      topRatedMovies.assignAll(newTopRatedMovies);
    } else {
      popularMovies.assignAll(_popularMoviesOriginal);
      topRatedMovies.assignAll(_topRatedMoviesOriginal);
    }
  }

  Future<void> favoriteMovie({required MovieModel movie}) async {
    final userLogged = _authService.user;

    if (userLogged != null) {
      var newMovie = movie.copyWith(favorite: !movie.favorite);

      await _moviesService.addOrRemoveFavorite(userLogged.uid, newMovie);

      await getMovies();
    }
  }

  Future<Map<int, MovieModel>> getFavorites() async {
    final userLogged = _authService.user;

    if (userLogged != null) {
      final favorites =
          await _moviesService.getFavoritiesMovies(userLogged.uid);

      return <int, MovieModel>{
        for (var fav in favorites) fav.id: fav,
      };
    }

    return {};
  }
}
