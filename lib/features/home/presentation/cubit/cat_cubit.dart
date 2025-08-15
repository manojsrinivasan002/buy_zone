import 'package:bloc/bloc.dart';
import 'package:buy_zone/features/home/data/models/category.dart';
import 'package:buy_zone/features/home/domain/usecase/product_usecase.dart';
import 'package:buy_zone/features/home/presentation/cubit/cat_state.dart';
import 'package:dartz/dartz.dart';

class CatCubit extends Cubit<CatState> {
  final ProductUseCase productUseCase;
  CatCubit(this.productUseCase) : super(CatInitState());

  Future<void> fetchCategories() async {
    emit(CatLoadingState());
    final result = await productUseCase.fetchCategories();
    return result.fold(
      (exception) => emit(CatErrorState(errorMsg: exception.errorMsg)),
      (response) {
        List<Category> parsedCat = [];
        if (response.data is Map<String, dynamic> &&
            response.data['categories'] is List) {
          parsedCat = (response.data['categories'] as List)
              .map((category) => Category.fromJson(category))
              .toList();
        } else if (response.data is List) {
          parsedCat = (response.data as List)
              .map((category) => Category.fromJson(category))
              .toList();
        } else {
          emit(CatErrorState(errorMsg: "Unexpected data format"));
        }
        emit(CatLoadedState(categories: parsedCat));
      },
    );
  }
}
