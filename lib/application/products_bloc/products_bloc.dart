import 'dart:async';
import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ovoshi/infrastructure/repositories/product_repository.dart';
import 'package:ovoshi/infrastructure/repositories/user_repository.dart';
import 'package:ovoshi/providers/product.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final UserRepository userRepository;
  ProductRepository _productRepository;

  ProductsBloc({this.userRepository}) : super(ProductsInitial()) {
    _productRepository =
        ProductRepository(userRepository.token, userRepository.userId);
  }

  @override
  Stream<ProductsState> mapEventToState(
    ProductsEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is FetchProducts) {
      // Loading products
      yield ProductsLoading();
      try {
        await _productRepository.fetchAndSetProducts();
        yield ProductsLoaded(items: _productRepository.items);
      }
      // Error
      catch (_) {
        yield ProductsError();
      }
    }
  }
}
