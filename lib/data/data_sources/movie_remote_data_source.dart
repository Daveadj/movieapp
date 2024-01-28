// ignore_for_file: avoid_print

import 'package:movieapp/data/core/api_client.dart';
import 'package:movieapp/data/models/cast_crew_result_data_model.dart';
import 'package:movieapp/data/models/movie_detail_model.dart';
import 'package:movieapp/data/models/movie_model.dart';
import 'package:movieapp/data/models/movies_result_model.dart';
import 'package:movieapp/data/models/video_result_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>?> getTrending();
  Future<List<MovieModel>?> getPopular();
  Future<List<MovieModel>?> getPlayingNow();
  Future<List<MovieModel>?> getCommingSoon();
  Future<List<MovieModel>?> getSearchMovies(String searchTerm);
  Future<MovieDetailsModel> getMovieDetail(int id);
  Future<List<CastModel>?> getCastCrew(int id);
  Future<List<VideoModel>?> getVideos(int id);
}

class MovieRemoteDataSourceImpl extends MovieRemoteDataSource {
  final ApiClient _client;

  MovieRemoteDataSourceImpl(this._client);

  @override
  Future<List<MovieModel>?> getTrending() async {
    final response = await _client.get('trending/movie/day');
    final movies = MoviesResultModel.fromJson(response).movies;

    return movies;
  }

  @override
  Future<List<MovieModel>?> getPopular() async {
    final response = await _client.get('movie/popular');
    final movies = MoviesResultModel.fromJson(response).movies;

    return movies;
  }

  @override
  Future<List<MovieModel>?> getCommingSoon() async {
    final response = await _client.get('movie/upcoming');
    final movies = MoviesResultModel.fromJson(response).movies;

    return movies;
  }

  @override
  Future<List<MovieModel>?> getPlayingNow() async {
    final response = await _client.get('movie/now_playing');
    final movies = MoviesResultModel.fromJson(response).movies;

    return movies;
  }

  @override
  Future<MovieDetailsModel> getMovieDetail(int id) async {
    final response = await _client.get('movie/$id');
    final movie = MovieDetailsModel.fromJson(response);

    return movie;
  }

  @override
  Future<List<CastModel>?> getCastCrew(int id) async {
    final response = await _client.get('movie/$id/credits');
    print('response cast:$response');
    final castcrew = CastCrewResultModel.fromJson(response).cast;

    return castcrew;
  }

  @override
  Future<List<VideoModel>?> getVideos(int id) async {
    final response = await _client.get('movie/$id/videos');
    print('response cast:$response');
    final videos = VideoResultModel.fromJson(response).videos;

    return videos;
  }

  @override
  Future<List<MovieModel>?> getSearchMovies(String searchTerm) async {
    final response = await _client.get('search/movie', params: {
      'query': searchTerm,
    });
    final movies = MoviesResultModel.fromJson(response).movies;
    print(movies);
    return movies;
  }
}
