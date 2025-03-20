import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/core/base/page/base_page_state.dart';
import 'package:flutter_base_bloc/core/base/page/base_scafold.dart';
import 'package:flutter_base_bloc/core/config/resources/dimens.dart';
import 'package:flutter_base_bloc/core/config/router/router_name.dart';
import 'package:flutter_base_bloc/core/config/themes/app_theme.dart';
import 'package:flutter_base_bloc/gen/assets.gen.dart';
import 'package:flutter_base_bloc/presentation/camera_screen/bloc/camera_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
  @override
  void initState() {
    bloc.add(const CameraEvent.initializeCamera());
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return AppScaffold(
      showBackButton: false,
      showAppBar: false,
      body: BlocListener<CameraBloc, CameraState>(
        listenWhen: (previous, current) => previous.image != current.image,
        listener: (context, state) {
          if (state.image != null) {
            final imagePath = state.image!.path;
            context.pushNamed(
              RoutesName.imageScreen.name,
              extra: imagePath,
            );
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            BlocSelector<CameraBloc, CameraState, CameraController?>(
              selector: (state) => state.cameraController,
              builder: (context, cameraController) {
                if (cameraController == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return CameraPreview(cameraController);
              },
            ),
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
                        const CameraEvent.imageFromCamera(),
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
