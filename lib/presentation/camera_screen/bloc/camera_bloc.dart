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
  CameraBloc() : super(const _cameraState()) {
    on<_OnImageFromCamera>(_onImageFromCamera);
    on<_OnImageFromGallery>(_onImageFromGallery);
  }

  Future<void> _onImageFromCamera(
      _OnImageFromCamera event, Emitter<CameraState> emit) async {
    final CameraController cameraController = event.controller;
    if (!cameraController.value.isInitialized ||
        cameraController.value.isTakingPicture) {
      return;
    }

    await cameraController.setFlashMode(FlashMode.auto);
    XFile image = await cameraController.takePicture();
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
