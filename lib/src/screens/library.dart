import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_drive/src/providers/favorite.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    final Favorite favorite = context.watch<Favorite>();

    return Column(
      children: favorite.favorites.map((bird) {
        return ListTile(
          title: Text(bird.name),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await favorite.remove(bird);
              setState(() {});
            },
          ),
        );
      }).toList(),
    );
  }
}
