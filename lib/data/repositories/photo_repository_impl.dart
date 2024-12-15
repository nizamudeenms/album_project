import '../../domain/entities/photo.dart';
import '../../domain/repositories/photo_repository.dart';
import '../data_sources/photo_local_data_source.dart';
import '../data_sources/photo_remote_data_source.dart';
import '../../core/network_info.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoRemoteDataSource remoteDataSource;
  final PhotoLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PhotoRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<Photo>> getPhotos(int albumId) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      final photos = await remoteDataSource.getPhotos(albumId);
      await localDataSource.cachePhotos(albumId, photos);
      return photos;
    } else {
      return await localDataSource.getCachedPhotos(albumId);
    }
  }
}
