import 'package:equatable/equatable.dart';

abstract class PhotoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadPhotos extends PhotoEvent {
  final int albumId;

  LoadPhotos(this.albumId);

  @override
  List<Object?> get props => [albumId];
}
