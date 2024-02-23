import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_drive/src/providers/favorite.dart';
import 'package:test_drive/src/widgets/big_card.dart';
import 'package:test_drive/src/widgets/change_button.dart';
import 'package:test_drive/src/widgets/favorite_button.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var current = WordPair.random();
  WordPair? before;

  void _getNext() {
    setState(() {
      before = current;
      current = WordPair.random();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Favorite favorite = context.watch<Favorite>();

    void toggleFavorite() async {
      if (favorite.isFavorite(current)) {
        await favorite.remove(current);
      } else {
        await favorite.add(current);
      }
      setState(() {});
    }

    bool isFavorite(WordPair pair) => favorite.isFavorite(pair);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BigCard(text: 'current: ${current.asLowerCase}'),
          BigCard(text: 'before: ${before?.asLowerCase}'),
          const SizedBox(height: 20),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FavoriteButton(
                onPressed: toggleFavorite,
                isFavorite: isFavorite(current),
              ),
              const SizedBox(width: 10),
              ChangeButton(
                text: 'チェンジだ！チェンジチェンジ！！',
                onPressed: _getNext,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
