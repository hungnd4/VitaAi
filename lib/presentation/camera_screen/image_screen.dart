import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/core/base/page/base_scafold.dart';
import 'package:flutter_base_bloc/core/config/resources/color.dart';
import 'package:flutter_base_bloc/core/config/resources/dimens.dart';
import 'package:flutter_base_bloc/presentation/camera_screen/bloc/camera_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageScreenProvider extends StatelessWidget {
  final CameraBloc cameraBloc;
  const ImageScreenProvider({
    super.key,
    required this.cameraBloc,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cameraBloc,
      child: const ImageScreen(),
    );
  }
}

class ImageScreen extends StatelessWidget {
  const ImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SafeArea(
        child: BlocBuilder<CameraBloc, CameraState>(
          buildWhen: (previous, current) => previous.image != current.image,
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(Dimens.d15),
                            child: Image.file(
                              state.image!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            'Ảnh chụp',
                            style: TextStyle(
                              color: colorBlack,
                              fontSize: Dimens.d20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
