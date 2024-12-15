
import 'package:album_project/domain/entities/album.dart';
import 'package:album_project/domain/usecases/get_albums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



part 'album_event.dart';

part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final GetAlbums getAlbums;

  AlbumBloc(this.getAlbums) : super(AlbumInitial()) {
    on<LoadAlbums>((event, emit) async {
      emit(AlbumLoading());
      try {
        final albums = await getAlbums();
        emit(AlbumLoaded(albums));
      } catch (e) {
        emit(AlbumError('Failed to fetch albums'));
      }
    });
  }
}


