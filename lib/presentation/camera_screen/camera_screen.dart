import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/core/base/page/base_page_state.dart';
import 'package:flutter_base_bloc/core/base/page/base_scafold.dart';
import 'package:flutter_base_bloc/core/config/resources/dimens.dart';
import 'package:flutter_base_bloc/core/config/themes/app_theme.dart';
import 'package:flutter_base_bloc/gen/assets.gen.dart';
import 'package:flutter_base_bloc/presentation/camera_screen/bloc/camera_bloc.dart';
import 'package:flutter_base_bloc/presentation/camera_screen/image_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CameraProvider extends StatelessWidget {
  const CameraProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CameraBloc(),
      child: const Camera(),
    );
  }
}

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends BasePageState<Camera, CameraBloc> {
  CameraController? _cameraController;
  late List<CameraDescription> _cameras;

  @override
  void initState() {
    super.initState();
    _intitCamera();
  }

  Future<void> _intitCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(
      _cameras.first,
      ResolutionPreset.high,
    );
    await _cameraController!.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    if (_cameraController == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return AppScaffold(
      showBackButton: false,
      showAppBar: false,
      body: BlocListener<CameraBloc, CameraState>(
        listenWhen: (previous, current) => previous.image != current.image,
        listener: (context, state) {
          if (state.image != null) {
            final cameraBloc = context.read<CameraBloc>();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ImageScreenProvider(
                  cameraBloc: cameraBloc,
                ),
              ),
            );
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            CameraPreview(_cameraController!),
            Positioned(
              bottom: Dimens.d20.h,
              left: Dimens.d20.w,
              child: GestureDetector(
                onTap: () {
                  context.read<CameraBloc>().add(
                        const CameraEvent.imageFromGallery(),
                      );
                },
                child: Container(
                  padding: const EdgeInsets.all(Dimens.d19),
                  decoration: BoxDecoration(
                    color: AppTheme.getInstance().chipColor,
                    borderRadius: BorderRadius.circular(Dimens.d30),
                  ),
                  child: Assets.icons.icGallery.svg(
                    colorFilter: ColorFilter.mode(
                      AppTheme.getInstance().primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20.h,
              left: 155.w,
              child: GestureDetector(
                onTap: () {
                  context.read<CameraBloc>().add(
                        CameraEvent.imageFromCamera(_cameraController!),
                      );
                },
                child: Container(
                  padding: const EdgeInsets.all(Dimens.d20),
                  decoration: BoxDecoration(
                    color: AppTheme.getInstance().chipColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppTheme.getInstance().primaryColor,
                      width: Dimens.d4.w,
                    ),
                  ),
                  child: Assets.icons.icCamera2.svg(
                    colorFilter: ColorFilter.mode(
                      AppTheme.getInstance().primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
