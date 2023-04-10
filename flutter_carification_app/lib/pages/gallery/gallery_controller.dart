import 'package:flutter_carification_app/common/object_box.dart';
import 'package:flutter_carification_app/objectbox.g.dart';
import 'package:flutter_carification_app/pages/gallery/gallery_test_data.dart';
import 'package:get/get.dart';

import '../../car_data.dart';

class GalleryController extends GetxController with GalleryTestData {
  GalleryController({
    required this.objectBox,
  });

  final ObjectBox objectBox;
  late Box _box;

  final lastPredictions = <int, CarData>{}.obs;
  final gallery = <int, CarData>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _box = objectBox.store.box<CarData>();

    /// Init once for testing
    initTestData(_box);
    loadCarsFromStore();
  }

  void loadCarsFromStore() {
    final galleryList =
        _box.query(CarData_.liked.equals(true)).build().find() as List<CarData>;
    final predictionsList =
        (_box.query().build().find() as List<CarData>).sublist(0, 3);

    lastPredictions.value = {for (var val in predictionsList) val.id: val};
    gallery.value = {for (var val in galleryList) val.id: val};
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
  }

  void onLikeTap({required int id}) {
    final CarData car = _box.get(id);
    car.liked = !car.liked;
    _box.put(car);
    if (car.liked) {
      gallery[car.id] = car;
    } else {
      gallery.remove(car.id);
    }
  }
}
