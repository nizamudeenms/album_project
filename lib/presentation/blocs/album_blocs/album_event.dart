part of 'album_bloc.dart';

abstract class AlbumEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadAlbums extends AlbumEvent {}
