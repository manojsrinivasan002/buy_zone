import 'package:buy_zone/features/home/data/models/product.dart';
import 'package:equatable/equatable.dart';

class CartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartInitState extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {
  final List<Product> products;
  CartLoadedState({required this.products});
  @override
  List<Object?> get props => [products];
}

class CartErrorState extends CartState {
  final String errorMsg;
  CartErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}
