import 'package:album_project/domain/usecases/get_albums.dart';
import 'package:album_project/domain/usecases/get_photos.dart';
import 'package:album_project/presentation/blocs/album_blocs/album_bloc.dart';
import 'package:album_project/presentation/blocs/photo_blocs/photo_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../data/data_sources/album_local_data_source.dart';
import '../data/data_sources/album_remote_data_source.dart';
import '../data/data_sources/photo_local_data_source.dart';
import '../data/data_sources/photo_remote_data_source.dart';
import '../data/repositories/album_repository_impl.dart';
import '../data/repositories/photo_repository_impl.dart';
import '../core/network_info.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  final database = await openDatabase(
    join(await getDatabasesPath(), 'albums.db'),
    version: 1,
    onCreate: (db, version) {
      db.execute('CREATE TABLE albums (id INTEGER PRIMARY KEY, title TEXT)');
      db.execute(
          'CREATE TABLE photos (id INTEGER PRIMARY KEY, albumId INTEGER, url TEXT)');
    },
  );

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(Connectivity()));

  sl.registerLazySingleton<AlbumRemoteDataSource>(
      () => AlbumRemoteDataSourceImpl(client: http.Client()));
  sl.registerLazySingleton<AlbumLocalDataSource>(
      () => AlbumLocalDataSourceImpl(database: database));

  sl.registerLazySingleton<PhotoRemoteDataSource>(
      () => PhotoRemoteDataSourceImpl(client: http.Client()));
  sl.registerLazySingleton<PhotoLocalDataSource>(
      () => PhotoLocalDataSourceImpl(database: database));

  sl.registerLazySingleton(() => AlbumRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton(() => PhotoRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));

  // Use Cases
  sl.registerLazySingleton(() => GetAlbums(sl<AlbumRepositoryImpl>()));
  sl.registerLazySingleton(() => GetPhotos(sl<PhotoRepositoryImpl>()));

  // Blocs
  sl.registerFactory(() => AlbumBloc(sl<GetAlbums>()));
  sl.registerFactory(() => PhotoBloc(sl<GetPhotos>()));
}
