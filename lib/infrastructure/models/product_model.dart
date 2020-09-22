// Product
// ignore: must_be_immutable
import 'package:flutter/foundation.dart';
import 'package:ovoshi/domain/entities/product.dart';

// ignore: must_be_immutable
class ProductModel extends Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  ProductModel({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  }) : super(
          id: id,
          title: title,
          description: description,
          price: price,
          imageUrl: imageUrl,
        );
}
