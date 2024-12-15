

import 'package:album_project/domain/usecases/get_photos.dart';
import 'package:album_project/presentation/blocs/photo_blocs/photo_event.dart';
import 'package:album_project/presentation/blocs/photo_blocs/photo_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final GetPhotos getPhotos;

  PhotoBloc(this.getPhotos) : super(PhotoInitial()) {
    on<LoadPhotos>((event, emit) async {
      emit(PhotoLoading());
      try {
        final photos = await getPhotos(event.albumId);
        emit(PhotoLoaded(photos));
      } catch (e) {
        emit(PhotoError('Failed to fetch photos'));
      }
    });
  }
}
