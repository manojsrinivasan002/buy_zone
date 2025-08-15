import 'package:bloc/bloc.dart';
import 'package:buy_zone/features/home/data/models/product.dart';
import 'package:buy_zone/features/home/domain/usecase/product_usecase.dart';
import 'package:buy_zone/features/home/presentation/cubit/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductUseCase productUseCase;

  ProductCubit(this.productUseCase) : super(ProductInitState());

  void fetchProducts() async {
    emit(ProductLoadingState());
    final result = await productUseCase.fetchProducts();
    result.fold(
      (exception) => emit(ProductErrorState(errorMsg: exception.message)),
      (productResponse) {
        List<Product> products = productResponse.products ?? [];
        emit(ProductLoadedState(products: products));
      },
    );
  }
}
