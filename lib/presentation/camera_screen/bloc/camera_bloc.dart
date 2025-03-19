import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter_base_bloc/core/base/bloc/base_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'camera_event.dart';
part 'camera_state.dart';
part 'camera_bloc.freezed.dart';

class CameraBloc extends BaseBloc<CameraEvent, CameraState> {
  late final List<CameraDescription> cameras;
  late final CameraController controller;

  CameraBloc() : super(const _cameraState()) {
    on<_OnInitializeCamera>(_initializeCamera);
    on<_OnImageFromCamera>(_onImageFromCamera);
    on<_OnImageFromGallery>(_onImageFromGallery);
  }

  Future<void> _initializeCamera(
      _OnInitializeCamera event, Emitter<CameraState> emit) async {
    cameras = await availableCameras();
    controller = CameraController(
      cameras.first,
      ResolutionPreset.high,
    );
    await controller.initialize();

    emit(
      state.copyWith(
        cameras: cameras,
        cameraController: controller,
      ),
    );
  }

  Future<void> _onImageFromCamera(
      _OnImageFromCamera event, Emitter<CameraState> emit) async {
    if (!controller.value.isInitialized || controller.value.isTakingPicture) {
      return;
    }

    await controller.setFlashMode(FlashMode.auto);
    XFile image = await controller.takePicture();
    emit(
      state.copyWith(
        image: File(image.path),
      ),
    );
  }

  Future<void> _onImageFromGallery(
      _OnImageFromGallery event, Emitter<CameraState> emit) async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      emit(state.copyWith(
        image: File(pickedFile.path),
      ));
    }
  }
}
