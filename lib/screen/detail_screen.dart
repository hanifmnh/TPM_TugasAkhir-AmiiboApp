import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.character}) : super(key: key);

  final dynamic character;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = FavoriteCharacter().isFavorite(widget.character);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.character['name']),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.white : null,
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
                if (isFavorite) {
                  FavoriteCharacter().addFavorite(widget.character);
                } else {
                  FavoriteCharacter().removeFavorite(widget.character);
                }
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              widget.character['image'],
              width: 250,
              height: 250,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            Text(
              widget.character['name'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Amiibo Series: ${widget.character['amiiboSeries']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Game Series: ${widget.character['gameSeries']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Type: ${widget.character['type']}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteCharacter {
  static final FavoriteCharacter _instance = FavoriteCharacter._internal();

  factory FavoriteCharacter() {
    return _instance;
  }

  FavoriteCharacter._internal();

  List<dynamic> favoriteCharacter = [];

  void addFavorite(dynamic character) {
    favoriteCharacter.add(character);
  }

  void removeFavorite(dynamic character) {
    favoriteCharacter.remove(character);
  }

  bool isFavorite(dynamic character) {
    return favoriteCharacter.contains(character);
  }
}
