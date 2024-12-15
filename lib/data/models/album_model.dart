import 'package:album_project/domain/entities/album.dart';

class AlbumModel extends Album {
  AlbumModel({required int id, required String title})
      : super(id: id, title: title);

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      id: json['id'],
      title: json['title'],
    );
  }
}
