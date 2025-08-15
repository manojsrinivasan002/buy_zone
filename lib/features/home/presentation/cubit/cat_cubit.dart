import 'package:bloc/bloc.dart';
import 'package:buy_zone/features/home/data/models/category.dart';
import 'package:buy_zone/features/home/domain/usecase/product_usecase.dart';
import 'package:buy_zone/features/home/presentation/cubit/cat_state.dart';

class CatCubit extends Cubit<CatState> {
  final ProductUseCase productUseCase;

  CatCubit(this.productUseCase) : super(CatInitState());

  void fetchCategories() async {
    emit(CatLoadingState());
    final result = await productUseCase.fetchCategories();
    result.fold(
      (exception) => emit(CatErrorState(errorMsg: exception.message)),
      (categoryResponse) {
        List<Category> parsedCat = categoryResponse.categories ?? [];
        emit(CatLoadedState(categories: parsedCat));
      },
    );
  }
}
