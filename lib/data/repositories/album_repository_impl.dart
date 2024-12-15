import '../../domain/entities/album.dart';
import '../../domain/repositories/album_repository.dart';
import '../data_sources/album_local_data_source.dart';
import '../data_sources/album_remote_data_source.dart';
import '../../core/network_info.dart';

class AlbumRepositoryImpl implements AlbumRepository {
  final AlbumRemoteDataSource remoteDataSource;
  final AlbumLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AlbumRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<Album>> getAlbums() async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      final albums = await remoteDataSource.getAlbums();
      await localDataSource.cacheAlbums(albums);
      return albums;
    } else {
      return await localDataSource.getCachedAlbums();
    }
  }
}
