import 'package:sqflite/sqflite.dart';
import '../models/photo_model.dart';

abstract class PhotoLocalDataSource {
  Future<void> cachePhotos(int albumId, List<PhotoModel> photos);
  Future<List<PhotoModel>> getCachedPhotos(int albumId);
}

class PhotoLocalDataSourceImpl implements PhotoLocalDataSource {
  final Database database;

  PhotoLocalDataSourceImpl({required this.database});

  static const String _tableName = 'photos';

  @override
  Future<void> cachePhotos(int albumId, List<PhotoModel> photos) async {
    await database.transaction((txn) async {
      await txn.delete(_tableName, where: 'albumId = ?', whereArgs: [albumId]);
      for (var photo in photos) {
        await txn.insert(
          _tableName,
          {'id': photo.id, 'albumId': albumId, 'url': photo.url},
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  @override
  Future<List<PhotoModel>> getCachedPhotos(int albumId) async {
    final List<Map<String, dynamic>> maps = await database.query(
      _tableName,
      where: 'albumId = ?',
      whereArgs: [albumId],
    );

    if (maps.isEmpty) {
      throw Exception('No cached photos found for albumId: $albumId');
    }

    return maps.map((map) => PhotoModel.fromJson(map)).toList();
  }
}
