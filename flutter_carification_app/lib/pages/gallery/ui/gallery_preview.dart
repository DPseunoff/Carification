import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carification_app/common/button.dart';

import '../../../utils/app_textstyles.dart';

@RoutePage()
class GalleryPreview extends StatelessWidget {
  const GalleryPreview(
      {Key? key, required this.imagePath, required this.imagePrediction})
      : super(key: key);

  final String imagePath;
  final String imagePrediction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () => context.router.pop([false]),
            ),
          ),
          Positioned.fill(
            child: Column(
              children: [
                const Spacer(flex: 1),
                Hero(
                  tag: 'CarHero',
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: FileImage(File(imagePath)),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(4, 4),
                            blurRadius: 7,
                          ),
                        ],
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 45,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 11,
                            vertical: 14,
                          ),
                          child: BlurryContainer(
                            borderRadius: BorderRadius.circular(10),
                            blur: 10,
                            color: Colors.black.withOpacity(0.3),
                            child: Center(
                              child: Text(
                                imagePrediction,
                                style: AppTextStyles.onBoardingDescription(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: MainButton(
                    buttonTitle: 'Delete',
                    onTap: () => context.router.pop(true),
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
