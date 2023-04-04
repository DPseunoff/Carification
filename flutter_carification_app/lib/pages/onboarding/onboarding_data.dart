import 'package:flutter_carification_app/utils/app_assets.dart';

mixin OnBoardingData {
  final onBoardingData = <OnBoardingDataItem>[
    OnBoardingDataItem(
      prefixTitle: 'Добро пожаловать в',
      title: 'CARIFICATION',
      description: 'Приложение для распознавания марок автомобилей',
      backgroundAsset: AppAssets.onBoarding1,
    ),
    OnBoardingDataItem(
      description: 'Сфотографируйте машину на улице, и приложение попробует распознать ее марку',
      backgroundAsset: AppAssets.onBoarding2,
    ),
    OnBoardingDataItem(
      title: 'Приятного\nпользования',
      description: 'Перед использованием рекомендуется ознакомиться с документацией',
      backgroundAsset: AppAssets.onBoarding3,
    ),
  ];
}

class OnBoardingDataItem {
  OnBoardingDataItem({
    this.title,
    required this.description,
    this.prefixTitle,
    required this.backgroundAsset,
  });

  final String? title;
  final String description;
  final String? prefixTitle;
  final String backgroundAsset;
}
