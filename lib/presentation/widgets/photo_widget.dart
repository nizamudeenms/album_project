import 'package:album_project/domain/entities/photo.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PhotoWidget extends StatelessWidget {
  final List<Photo> photos;

  const PhotoWidget({super.key, required this.photos});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(8.0),
        itemCount: photos.length * 2, // Infinite scrolling logic
        itemBuilder: (context, index) {
          final photo = photos[index % photos.length];
          print(photo.url);
          return SizedBox(
            width: 80,
            height: 80,
            child: CachedNetworkImage(
              imageUrl: photo.url,
              placeholder: (context, url) => const Center(
                  child: SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator())),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
