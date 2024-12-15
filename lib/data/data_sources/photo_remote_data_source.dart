import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/photo_model.dart';

abstract class PhotoRemoteDataSource {
  Future<List<PhotoModel>> getPhotos(int albumId);
}

class PhotoRemoteDataSourceImpl implements PhotoRemoteDataSource {
  final http.Client client;

  PhotoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PhotoModel>> getPhotos(int albumId) async {
    final response = await client.get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos?albumId=$albumId'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => PhotoModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch photos');
    }
  }
}
