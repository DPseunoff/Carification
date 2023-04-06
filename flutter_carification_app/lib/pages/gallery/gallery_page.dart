import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carification_app/common/page_template.dart';

@RoutePage()
class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      appBarTitle: 'Gallery',
      body: Container(),
    );
  }
}
