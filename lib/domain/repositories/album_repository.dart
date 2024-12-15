import 'package:album_project/domain/entities/album.dart';

abstract class AlbumRepository {
  Future<List<Album>> getAlbums();
}
