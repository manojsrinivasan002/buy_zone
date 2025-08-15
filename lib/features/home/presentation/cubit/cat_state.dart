import 'package:buy_zone/features/home/data/models/category.dart';
import 'package:equatable/equatable.dart';

class CatState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CatInitState extends CatState {}

class CatLoadingState extends CatState {}

class CatLoadedState extends CatState {
  final List<Category> categories;
  CatLoadedState({required this.categories});
  @override
  List<Object?> get props => [categories];
}

class CatErrorState extends CatState {
  final String errorMsg;
  CatErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}
