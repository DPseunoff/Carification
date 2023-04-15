import 'package:auto_route/auto_route.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carification_app/common/button.dart';
import 'package:flutter_carification_app/common/page_template.dart';
import 'package:flutter_carification_app/pages/camera/image_controller.dart';
import 'package:get/get.dart';

@RoutePage()
class ImagePreviewPage extends StatefulWidget {
  const ImagePreviewPage({Key? key}) : super(key: key);

  @override
  State<ImagePreviewPage> createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends State<ImagePreviewPage> {
  final _imageController = Get.find<ImageController>();

  @override
  void dispose() {
    super.dispose();
    _imageController.clearImage();
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.file(
              _imageController.getImageFile(),
              fit: BoxFit.fitHeight,
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: _toolBar(),
            ),
          )
        ],
      ),
    );
  }

  Widget _toolBar() {
    return BlurryContainer(
      height: 135,
      blur: 2,
      borderRadius: BorderRadius.zero,
      color: Colors.black.withOpacity(0.4),
      child: Center(
        child: Row(
          children: [
            const SizedBox(width: 17),
            Expanded(
              child: MainButton(
                buttonTitle: 'No',
                onTap: context.router.pop,
              ),
            ),
            const SizedBox(width: 17),
            Expanded(
              child: MainButton(
                buttonTitle: 'Use photo',
                onTap: () async {
                  _imageController.onUseTap();
                  context.router.pop();
                }
              ),
            ),
            const SizedBox(width: 17),
          ],
        ),
      ),
    );
  }
}
