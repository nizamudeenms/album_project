import 'package:album_project/presentation/blocs/album_blocs/album_bloc.dart';
import 'package:album_project/presentation/blocs/photo_blocs/photo_bloc.dart';
import 'package:album_project/presentation/blocs/photo_blocs/photo_event.dart';
import 'package:album_project/presentation/blocs/photo_blocs/photo_state.dart';
import 'package:album_project/presentation/widgets/album_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/service_locator.dart';

class AlbumHomeScreen extends StatelessWidget {
  const AlbumHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Albums")),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, albumState) {
          if (albumState is AlbumLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (albumState is AlbumLoaded) {
            return ListView.builder(
              itemCount: albumState.albums.length,
              itemBuilder: (context, index) {
                final album =
                    albumState.albums[index % albumState.albums.length];
                return SizedBox(
                  height: 180,
                  child: BlocProvider(
                    create: (context) =>
                        sl<PhotoBloc>()..add(LoadPhotos(album.id)),
                    child: BlocBuilder<PhotoBloc, PhotoState>(
                      builder: (context, photoState) {
                        if (photoState is PhotoLoading) {
                          return _buildLoadingPlaceholder();
                        } else if (photoState is PhotoLoaded) {
                          return AlbumWidget(
                              album: album, photos: photoState.photos);
                        } else if (photoState is PhotoError) {
                          return Center(
                              child: Text(
                                  'Failed to load photos: ${photoState.message}'));
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                );
              },
            );
          } else if (albumState is AlbumError) {
            return Center(child: Text(albumState.message));
          }
          return const SizedBox();
        },
      ),
    );
  }

  // Loading Placeholder with Fixed Size
  Widget _buildLoadingPlaceholder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: SizedBox(
            height: 18,
            width: 200,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5, // Placeholder for 3 photos
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }

}
