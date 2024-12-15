import 'package:sqflite/sqflite.dart';
import '../models/album_model.dart';

abstract class AlbumLocalDataSource {
  Future<void> cacheAlbums(List<AlbumModel> albums);
  Future<List<AlbumModel>> getCachedAlbums();
}

class AlbumLocalDataSourceImpl implements AlbumLocalDataSource {
  final Database database;

  AlbumLocalDataSourceImpl({required this.database});

  static const String _tableName = 'albums';

  @override
  Future<void> cacheAlbums(List<AlbumModel> albums) async {
    await database.transaction((txn) async {
      await txn.delete(_tableName); // Clear old cache
      for (var album in albums) {
        await txn.insert(
          _tableName,
          {'id': album.id, 'title': album.title},
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  @override
  Future<List<AlbumModel>> getCachedAlbums() async {
    final List<Map<String, dynamic>> maps = await database.query(_tableName);

    if (maps.isEmpty) {
      throw Exception('No cached albums found');
    }

    return maps.map((map) => AlbumModel.fromJson(map)).toList();
  }
}
