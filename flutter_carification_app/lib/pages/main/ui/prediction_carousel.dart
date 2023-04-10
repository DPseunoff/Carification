import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carification_app/pages/main/ui/prediction_card.dart';

import '../../../car_data.dart';

class PredictionsCarousel extends StatelessWidget {
  const PredictionsCarousel({
    required this.items,
    required this.likeCallback,
    required this.slideCallback,
    Key? key,
  }) : super(key: key);

  final List<CarData> items;
  final void Function(int id) likeCallback;
  final void Function(int i, CarouselPageChangedReason reason) slideCallback;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        ...List.generate(
          items.length,
          (i) {
            final id = items[i].id;
            final asset = items[i].imagePath;
            final prediction = items[i].prediction;
            final liked = items[i].liked;
            return GestureDetector(
              onTap: () => likeCallback(id),
              child: PredictionCard(
                imageAsset: asset,
                prediction: prediction,
                liked: liked,
              ),
            );
          },
        ),
      ],
      options: CarouselOptions(
        aspectRatio: 1,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: false,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        scrollDirection: Axis.horizontal,
        onPageChanged: slideCallback,
      ),
    );
  }
}
