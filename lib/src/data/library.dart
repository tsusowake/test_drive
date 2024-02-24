import 'package:test_drive/src/data/bird.dart';

class Library {
  final List<Bird> allBirds = [];

  void addBird(Bird bird) {
    allBirds.add(bird);
  }
}