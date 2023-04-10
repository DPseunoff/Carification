import 'package:flutter_carification_app/car_data.dart';
import 'package:flutter_carification_app/utils/app_assets.dart';
import 'package:objectbox/objectbox.dart';

mixin GalleryTestData {
  final _testData = [
    CarData(
      imagePath: AppAssets.test1,
      prediction: 'Rolls-Royce',
      liked: false,
    ),
    CarData(
      imagePath: AppAssets.test2,
      prediction: 'Ford',
      liked: true,
    ),
    CarData(
      imagePath: AppAssets.test3,
      prediction: 'Mercedes-benz',
      liked: false,
    ),
    CarData(
      imagePath: AppAssets.test4,
      prediction: 'Lamborghini',
      liked: true,
    ),
  ];

  void initTestData(Box box) {
    for (final car in _testData) {
      box.put(car);
    }
  }
}
