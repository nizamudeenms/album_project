import 'package:flutter/material.dart';
import '../../../domain/entities/album.dart';
import '../../../domain/entities/photo.dart';

class AlbumWidget extends StatelessWidget {
  final Album album;
  final List<Photo> photos;

  const AlbumWidget({Key? key, required this.album, required this.photos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            album.title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: photos.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                photos[index % photos.length].url,
                width: 150,
                height: 150,
              ),
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
