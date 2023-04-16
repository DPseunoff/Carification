import 'package:flutter/material.dart';
import 'package:flutter_carification_app/car_data.dart';
import 'package:flutter_carification_app/common/empty_bar.dart';
import 'package:flutter_carification_app/pages/gallery/ui/gallery_card.dart';

class GalleryScrollView extends StatefulWidget {
  const GalleryScrollView({
    Key? key,
    required this.items,
    this.upperPadding = 0,
  }) : super(key: key);

  final List<CarData> items;
  final double upperPadding;

  @override
  State<GalleryScrollView> createState() => _GalleryScrollViewState();
}

class _GalleryScrollViewState extends State<GalleryScrollView> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(
              left: 15,
              right: 15,
              top: widget.upperPadding,
              bottom: 173,
            ),
            sliver: SliverGrid.count(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              children: [
                ...List.generate(widget.items.length, (i) {
                  final id = widget.items[i].id;
                  final asset = widget.items[i].imagePath;
                  final prediction = widget.items[i].prediction;
                  return GalleryCard(
                    key: UniqueKey(),
                    id: id,
                    imageAsset: asset,
                    prediction: prediction,
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
