import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

// Product change notifier
class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  // Change fav value
  _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  // Change favorite status
  Future<void> toggleFavoriteStatus(String token, String userId) async {
    // Save old status
    final oldStatus = isFavorite;
    // Invert status
    isFavorite = !isFavorite;
    notifyListeners();

    // Try change favorite status
    final url =
        'https://flutter-shop-apps.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
    try {
      // Put requst
      final response = await http.put(
        url,
        body: json.encode(
          isFavorite,
        ),
      );

      // If response is error
      if (response.statusCode >= 400) {
        // Return old value
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }
}
