part of 'camera_bloc.dart';

@freezed
class CameraState extends BaseState with _$CameraState {
  const factory CameraState({
    CameraController? cameraController,
    @Default([]) List<CameraDescription> cameras,
    File? image,
  }) = _cameraState;
}
