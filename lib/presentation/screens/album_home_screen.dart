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
                return BlocProvider(
                  create: (context) =>
                      sl<PhotoBloc>()..add(LoadPhotos(album.id)),
                  child: BlocBuilder<PhotoBloc, PhotoState>(
                    builder: (context, photoState) {
                      if (photoState is PhotoLoading) {
                        return const Center(child: CircularProgressIndicator());
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
}
