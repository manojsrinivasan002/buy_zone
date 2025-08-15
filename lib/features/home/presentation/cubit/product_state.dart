import 'package:buy_zone/features/home/data/models/product.dart';
import 'package:equatable/equatable.dart';

class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  final List<Product> products;
  ProductLoadedState({required this.products});
  @override
  List<Object?> get props => [products];
}

class ProductErrorState extends ProductState {
  final String errorMsg;
  ProductErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}
