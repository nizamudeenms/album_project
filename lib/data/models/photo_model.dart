
import 'package:album_project/domain/entities/photo.dart';

class PhotoModel extends Photo {
  PhotoModel({required int id, required String title, required String url})
      : super(id: id, title: title, url: url);

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      id: json['id'],
      title: json['title'],
      url: json['url'],
    );
  }
}
