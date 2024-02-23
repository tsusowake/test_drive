import 'package:english_words/english_words.dart';
import 'package:flutter/widgets.dart';

class Favorite extends ChangeNotifier {
  final _favorites = <WordPair>[];

  List<WordPair> get favorites => _favorites;

  bool isFavorite(WordPair pair) => _favorites.contains(pair);

  Future<void> add(WordPair pair) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _favorites.add(pair);
    notifyListeners();
  }

  Future<void> remove(WordPair pair) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _favorites.remove(pair);
    notifyListeners();
  }
}
