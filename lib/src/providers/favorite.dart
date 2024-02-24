import 'package:flutter/widgets.dart';
import 'package:test_drive/src/models/bird.dart' as bird_model;

class Favorite extends ChangeNotifier {
  final _favorites = <bird_model.Bird>[];

  List<bird_model.Bird> get favorites => _favorites;

  bool isFavorite(bird_model.Bird bird) => _favorites.contains(bird);

  Future<void> add(bird_model.Bird bird) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    _favorites.add(bird);
    notifyListeners();
  }

  Future<void> remove(bird_model.Bird bird) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _favorites.remove(bird);
    notifyListeners();
  }
}
