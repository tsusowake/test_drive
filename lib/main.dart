import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan)),
        home: const MyHomeView(
          title: 'Namer App',
        ),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {}

class MyHomeView extends StatefulWidget {
  const MyHomeView({super.key, required this.title});

  final String title;

  @override
  State<MyHomeView> createState() => _MyHomeViewState();
}

class _MyHomeViewState extends State<MyHomeView> {
  var _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      if (_selectedIndex == index) {
        return;
      }
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (_selectedIndex) {
      case 0:
        page = const GeneratorPage();
        break;
      case 1:
        page = const Text('Favorite');
        break;
      default:
        throw UnimplementedError('Unknown index: $_selectedIndex');
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('❤️初めての Flutter アプリ❤️'),
      ),
      body: page,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '',
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class GeneratorPage extends StatefulWidget {
  const GeneratorPage({
    super.key,
  });

  @override
  State<GeneratorPage> createState() => _GeneratorPageState();
}

class _GeneratorPageState extends State<GeneratorPage> {
  var current = WordPair.random();
  WordPair? before;
  final _favorites = <WordPair>[];

  void _getNext() {
    setState(() {
      before = current;
      current = WordPair.random();
    });
  }

  void _toggleFavorite() {
    setState(() {
      if (_favorites.contains(current)) {
        _favorites.remove(current);
      } else {
        _favorites.add(current);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                onPressed: _toggleFavorite,
                isFavorite: _favorites.contains(current),
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

///////////////////////
// Components
///////////////////////

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          text,
          style: style,
        ),
      ),
    );
  }
}

class ChangeButton extends StatelessWidget {
  const ChangeButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.onPressed,
    required this.isFavorite,
  });

  final void Function() onPressed;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
      label: const Text('お気に入り'),
      onPressed: onPressed,
    );
  }
}
