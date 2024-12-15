import 'package:cached_network_image/cached_network_image.dart';
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
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: photos.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(4.0),
              child: CachedNetworkImage(
                imageUrl: photos[index % photos.length].url,
                placeholder: (context, url) => const Center(
                  child: SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, size: 50, color: Colors.red),
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }
}
