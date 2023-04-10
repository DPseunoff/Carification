import 'package:objectbox/objectbox.dart';

@Entity()
class CarData {
  @Id()
  int id;
  String imagePath;
  String prediction;
  bool liked;

  CarData({
    this.id = 0,
    required this.imagePath,
    required this.prediction,
    this.liked = false,
  });
}
