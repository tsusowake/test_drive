import 'package:flutter/material.dart';

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
