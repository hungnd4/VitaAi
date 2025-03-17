part of 'camera_bloc.dart';

@freezed
class CameraEvent extends BaseEvent with _$CameraEvent {
  const factory CameraEvent.started() = _Started;
  const factory CameraEvent.cameraInitialized() = _OnCameraInitialized;
  const factory CameraEvent.cameraSwitched() = _OnCameraSwitched;
  const factory CameraEvent.imageFromCamera(CameraController controller) =
      _OnImageFromCamera;
  const factory CameraEvent.imageFromGallery() = _OnImageFromGallery;
}
