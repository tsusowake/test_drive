import 'package:test_drive/src/models/bird.dart' as model_bird;

class Bird {
  final List<model_bird.Bird> birds = [];

  List<model_bird.Bird> all() {
    var birds = <model_bird.Bird>[];
    for (var i = 1; i <= 10; i++) {
      var bird = model_bird.Bird(
        i,
        'Bird $i',
        'assets/images/birds/$i.jpg',
        // 'birds/$i.jpg',
      );
      birds.add(bird);
    }
    return birds;
  }
}
