part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<Product> items;

  ProductsLoaded({@required this.items});

  @override
  List<Object> get props => [items];
}

class ProductsError extends ProductsState {}
