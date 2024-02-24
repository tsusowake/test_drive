import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_drive/src/providers/favorite.dart';
import 'package:test_drive/src/widgets/change_button.dart';
import 'package:test_drive/src/widgets/favorite_button.dart';
import 'package:test_drive/src/repositories/bird.dart' as bird_repository;
import 'package:test_drive/src/models/bird.dart' as bird_model;

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final bird_repository.Bird birdRepository = bird_repository.Bird();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder<List<bird_model.Bird>>(
            future: birdRepository.fetchAll(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (!snapshot.hasData) {
                return Text('Error: ${snapshot.error}');
              }
              return BirdListContainer(
                  birds: snapshot.data!,
                  current: snapshot.data!.first,
                  currentIndex: 0);
            },
          ),
        ],
      ),
    );
  }
}

class BirdListContainer extends StatefulWidget {
  final List<bird_model.Bird> birds;
  final bird_model.Bird current;
  final int currentIndex;

  const BirdListContainer({
    super.key,
    required this.birds,
    required this.current,
    required this.currentIndex,
  });

  @override
  State<BirdListContainer> createState() => _BirdListContainerState();
}

class _BirdListContainerState extends State<BirdListContainer> {
  late List<bird_model.Bird> _birds;
  late bird_model.Bird _current;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _birds = widget.birds;
    _current = widget.current;
    _currentIndex = widget.currentIndex;
  }

  bool hasNext() {
    return _birds.indexOf(_current) < _birds.length - 1;
  }

  void _getNext() {
    setState(() {
      _currentIndex += 1;
      _current = _birds[_currentIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    final Favorite favorite = context.watch<Favorite>();

    void toggleFavorite() async {
      if (favorite.isFavorite(_current)) {
        await favorite.remove(_current);
      } else {
        await favorite.add(_current);
      }
      setState(() {});
    }

    bool isFavorite(bird_model.Bird bird) => favorite.isFavorite(bird);

    return Column(
      children: [
        BirdCard(bird: _current),
        const SizedBox(height: 20),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FavoriteButton(
              onPressed: toggleFavorite,
              isFavorite: isFavorite(_current),
            ),
            const SizedBox(width: 10),
            ChangeButton(
              text: 'チェンジだ！チェンジチェンジ！！',
              onPressed: _getNext,
              disabled: !hasNext(),
            ),
          ],
        ),
      ],
    );
  }
}

class BirdCard extends StatelessWidget {
  final bird_model.Bird bird;

  const BirdCard({
    super.key,
    required this.bird,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Image(
        image: AssetImage(bird.thumbnail),
        fit: BoxFit.cover,
      ),
    );
  }
}
