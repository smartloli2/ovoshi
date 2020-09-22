import 'package:flutter/material.dart';
import 'package:ovoshi/domain/entities/product.dart';
import 'package:ovoshi/infrastructure/repositories/product_repository.dart';
import 'package:ovoshi/infrastructure/repositories/user_repository.dart';

class ProductBloc with ChangeNotifier {
  final UserRepository userRepository;
  ProductRepository _productRepository;

  ProductBloc({this.userRepository}) {
    _productRepository =
        ProductRepository(userRepository.token, userRepository.userId);
  }

  Future<void> toggleFavoriteStatus(Product product) async {
    // Save old status
    final oldStatus = product.isFavorite;
    // Invert status
    product.isFavorite = !product.isFavorite;
    notifyListeners();

    // Try change favorite status
    try {
      await _productRepository.toggleFavoriteStatus(product);
    } catch (error) {
      product.setFavValue(oldStatus);
      notifyListeners();
    }
  }
}
