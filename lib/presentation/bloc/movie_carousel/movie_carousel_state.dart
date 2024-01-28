import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';
@immutable
abstract class MovieCarouselState extends Equatable {
  const MovieCarouselState();

  @override
  List<Object> get props => [];
}

class MovieCarouselInitial extends MovieCarouselState {
  const MovieCarouselInitial();

 
}

class MovieCarouselLoaded extends MovieCarouselState {
  const MovieCarouselLoaded({this.movies,this.defaultIndex=0}) : assert(defaultIndex >= 0, 'defaultIndex cannot be less than 0');

  final List<MovieEntity>? movies;
  final int defaultIndex;

  @override
  List<Object> get props => [movies!,defaultIndex];
}

class MovieCarouselError extends MovieCarouselState {
  const MovieCarouselError(this.errorType);

  final AppErrorType errorType;

  @override
  String toString() => 'ErrorMovieCarouselState';

  @override
  List<Object> get props => [errorType];
}
