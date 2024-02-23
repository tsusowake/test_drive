import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_drive/src/app.dart';
import 'package:test_drive/src/providers/favorite.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => Favorite()),
    ],
    child: const App(),
  ));
}
