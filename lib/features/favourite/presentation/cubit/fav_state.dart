import 'package:buy_zone/features/home/data/models/product.dart';
import 'package:equatable/equatable.dart';

class FavState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavInitState extends FavState {}

class FavLoadingState extends FavState {}

class FavLoadedState extends FavState {
  final List<Product> products;
  FavLoadedState({required this.products});
  @override
  List<Object?> get props => [products];
}

class FavErrorState extends FavState {
  final String errorMsg;
  FavErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}
