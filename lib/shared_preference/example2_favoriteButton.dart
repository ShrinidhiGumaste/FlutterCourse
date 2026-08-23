import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    loadFavorite();
  }

  Future<void> loadFavorite() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      isFavorite = prefs.getBool('favorite') ?? false;
    });
  }

  Future<void> toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      isFavorite = !isFavorite;
    });

    await prefs.setBool('favorite', isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorite',
          style: TextStyle(
            fontSize: 25,
            color: Colors.cyan,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        backgroundColor: Colors.deepOrange,
      ),

      body: Center(
        child: IconButton(
          onPressed: toggleFavorite,

          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            size: 100,
            color: isFavorite ? Colors.red : Colors.grey,
          ),
        ),
      ),
    );
  }
}
