import 'package:flutter/material.dart';
import 'package:flutter_carification_app/common/object_box.dart';
import 'package:flutter_carification_app/navigation/app_router.dart';
import 'package:flutter_carification_app/pages/gallery/gallery_controller.dart';
import 'package:get/get.dart';
import 'pages/camera/image_controller.dart';

late ObjectBox objectBox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.create();
  Get.put(GalleryController(objectBox: objectBox));
  Get.put(ImageController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _appRouter.config(),
      title: 'Flutter Carification',
    );
  }
}
