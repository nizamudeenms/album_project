import 'package:album_project/domain/entities/album.dart';
import 'package:album_project/domain/repositories/album_repository.dart';

class GetAlbums {
  final AlbumRepository repository;

  GetAlbums(this.repository);

  Future<List<Album>> call() async {
    return await repository.getAlbums();
  }
}
