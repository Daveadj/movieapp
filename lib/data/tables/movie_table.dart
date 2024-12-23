// ignore_for_file: overridden_fields, annotate_overrides

import 'package:hive/hive.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';

part 'movie_table.g.dart';

@HiveType(typeId: 0)
class MovieTable extends MovieEntity {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? title;

  @HiveField(2)
  final String? posterPath;

  const MovieTable({this.id, this.title, this.posterPath})
      : super(
          posterPath: posterPath,
          id: id,
          backdropPath: '',
          title: title,
          voteAverage: 0,
          releaseDate: '',
        );

  factory MovieTable.fromMovieEntity(MovieEntity movieEntity) {
    return MovieTable(
      id: movieEntity.id,
      title: movieEntity.title,
      posterPath: movieEntity.posterPath,
    );
  }
  @override
  List<Object?> get props => [id, title];
}
