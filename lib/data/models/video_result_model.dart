import 'package:movieapp/domain/entities/video_entity.dart';

class VideoResultModel {
  int? id;
  List<VideoModel>? videos;

  VideoResultModel({this.id, this.videos});

  VideoResultModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['results'] != null) {
      videos = <VideoModel>[];
      json['results'].forEach((v) {
        videos!.add(VideoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (videos != null) {
      data['results'] = videos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VideoModel extends VideoEntity{
  final String? iso6391;
  final String? iso31661;
  final String? name;
  final String? key;
  final String? publishedAt;
  final String? site;
  final int? size;
  final String? type;
  final bool? official;
  final String? id;

  const VideoModel(
      {this.iso6391,
      this.iso31661,
      this.name,
      this.key,
      this.publishedAt,
      this.site,
      this.size,
      this.type,
      this.official,
      this.id}) : super(title: name, key: key, type: type);

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      iso6391 : json['iso_639_1'],
    iso31661 :json['iso_3166_1'],
    name : json['name'],
    key : json['key'],
    publishedAt : json['published_at'],
    site : json['site'],
    size : json['size'],
    type : json['type'],
    official :json['official'],
    id :json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iso_639_1'] = iso6391;
    data['iso_3166_1'] = iso31661;
    data['name'] = name;
    data['key'] = key;
    data['published_at'] = publishedAt;
    data['site'] = site;
    data['size'] = size;
    data['type'] = type;
    data['official'] = official;
    data['id'] = id;
    return data;
  }
}
