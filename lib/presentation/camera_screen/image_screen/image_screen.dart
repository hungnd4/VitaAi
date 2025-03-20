import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/core/base/page/base_scafold.dart';
import 'package:flutter_base_bloc/core/config/resources/color.dart';
import 'package:flutter_base_bloc/core/config/resources/dimens.dart';
import 'package:flutter_base_bloc/gen/assets.gen.dart';

class ImageScreen extends StatelessWidget {
  final String? image;
  const ImageScreen({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(Dimens.d15),
                        child: image != null
                            ? Image.file(
                                File(image!),
                                fit: BoxFit.cover,
                                width: double.infinity,
                              )
                            : Assets.images.defaultImage.image(
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                      ),
                    ),
                    //TODO:Hau
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
        ),
      ),
    );
  }
}
