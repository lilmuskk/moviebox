import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Favorite Movies',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
