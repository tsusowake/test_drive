import 'package:test_drive/src/models/bird.dart' as model_bird;
import 'package:test_drive/src/data/bird.dart' as data_bird;

class Bird {
  Future<List<model_bird.Bird>> fetchAll() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    final mockBirds = data_bird.Bird();
    return mockBirds.all();
  }
}
