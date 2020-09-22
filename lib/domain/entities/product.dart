import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

// Product
// ignore: must_be_immutable
class Product extends Equatable {
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

  @override
  List<Object> get props =>
      [id, title, description, price, imageUrl, isFavorite];

  // Change fav value
  setFavValue(bool newValue) {
    isFavorite = newValue;
  }
}
