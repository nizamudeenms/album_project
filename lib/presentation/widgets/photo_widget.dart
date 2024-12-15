import 'package:album_project/domain/entities/photo.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PhotoWidget extends StatelessWidget {
  final List<Photo> photos;

  const PhotoWidget({super.key, required this.photos});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: photos.length * 2, // Infinite scrolling logic
        itemBuilder: (context, index) {
          final photo = photos[index % photos.length];
          print(photo.url);
          return Container(
            width: 100,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CachedNetworkImage(
                imageUrl: photo.url,
                placeholder: (context, url) => const Center(
                    child: SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator())),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
