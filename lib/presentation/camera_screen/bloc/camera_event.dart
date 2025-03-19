part of 'camera_bloc.dart';

@freezed
class CameraEvent extends BaseEvent with _$CameraEvent {
  const factory CameraEvent.started() = _Started;
  const factory CameraEvent.initializeCamera() = _OnInitializeCamera;
  const factory CameraEvent.imageFromCamera() = _OnImageFromCamera;
  const factory CameraEvent.imageFromGallery() = _OnImageFromGallery;
}
