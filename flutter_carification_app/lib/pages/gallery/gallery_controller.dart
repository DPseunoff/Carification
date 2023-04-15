import 'dart:io';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter_carification_app/common/error_receiver.dart';
import 'package:flutter_carification_app/common/object_box.dart';
import 'package:flutter_carification_app/objectbox.g.dart';
import 'package:flutter_carification_app/pages/gallery/gallery_test_data.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../car_data.dart';

class GalleryController extends GetxController with GalleryTestData {
  GalleryController({
    required this.objectBox,
  });

  final ObjectBox objectBox;
  late Box _box;

  final lastPredictions = <int, CarData>{}.obs;
  final gallery = <int, CarData>{}.obs;
  final predictionsIndex = 0.obs;

  final carouselController = CarouselController();

  @override
  void onInit() {
    super.onInit();
    _box = objectBox.store.box<CarData>();
    /// Init once for testing
    // initTestData(_box);
    // _box.removeAll();
    loadCarsFromStore();
  }

  void loadCarsFromStore() {
    final galleryList =
        _box.query(CarData_.liked.equals(true)).build().find() as List<CarData>;
    final predictionsFullList = (_box.query().build().find() as List<CarData>);
    final predictionsList =
        predictionsFullList.sublist(0, min(3, predictionsFullList.length));

    lastPredictions.value = {for (final val in predictionsList) val.id: val};
    gallery.value = {for (final val in galleryList) val.id: val};
  }

  Future<void> onSaveImageToDevice({
    required String prediction,
    required XFile image,
  }) async {
    final errorReceiver = Get.find<ErrorReceiver>();

    try {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/${image.name}';
      await image.saveTo(imagePath);
      final localImage = File(imagePath);
      onNewCarAdd(imagePath: localImage.path, prediction: prediction);
    } catch (e) {
      errorReceiver.onError('Error while saving image');
    }
  }

  void onNewCarAdd({
    required String imagePath,
    required String prediction,
  }) {
    final car = CarData(imagePath: imagePath, prediction: prediction);
    car.id = _box.put(car);
    if (lastPredictions.values.length == 3) {
      final CarData lastPredictedCar = lastPredictions.values.first;
      lastPredictions.remove(lastPredictedCar.id);
      if (!lastPredictedCar.liked) {
        _box.remove(lastPredictedCar.id);
      }
    }
    lastPredictions[car.id] = car;
    predictionsIndex.value = 0;
    carouselController.jumpToPage(0);
  }

  void onLikeTap(int id) {
    final CarData car = _box.get(id);
    car.liked = !car.liked;
    _box.put(car);
    if (car.liked) {
      gallery[car.id] = car;
    } else {
      gallery.remove(car.id);
    }
    lastPredictions[car.id] = car;
  }

  void onSlide(int i, CarouselPageChangedReason reason) {
    predictionsIndex.value = i;
  }

  Future<void> deleteImage(int i) async {
    _box.remove(i);
    gallery.remove(i);
    lastPredictions.remove(i);
  }
}
