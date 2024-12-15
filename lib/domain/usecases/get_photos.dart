import 'package:album_project/domain/entities/photo.dart';
import 'package:album_project/domain/repositories/photo_repository.dart';

class GetPhotos {
  final PhotoRepository repository;

  GetPhotos(this.repository);

  Future<List<Photo>> call(int albumId) async {
    return await repository.getPhotos(albumId);
  }
}
