import 'package:bloc/bloc.dart';
import 'package:buy_zone/features/home/data/models/product.dart';
import 'package:buy_zone/features/home/domain/usecase/product_usecase.dart';
import 'package:buy_zone/features/home/presentation/cubit/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductUseCase productUseCase;

  ProductCubit(this.productUseCase) : super(ProductInitState());

  Future<void> fetchProducts() async {
    emit(ProductLoadingState());
    final result = await productUseCase.execute();
    return result.fold(
      (exception) => emit(ProductErrorState(errorMsg: exception.errorMsg)),
      (response) {
        List<Product> parsedProducts = [];
        if (response.data is Map<String, dynamic> &&
            response.data['products'] is List) {
          parsedProducts = (response.data['products'] as List)
              .map((json) => Product.fromJson(json))
              .toList();
        } else if (response.data is List) {
          parsedProducts = (response.data as List)
              .map((json) => Product.fromJson(json))
              .toList();
        } else {
          emit(ProductErrorState(errorMsg: "Unexpected data format"));
          return;
        }
        emit(ProductLoadedState(products: parsedProducts));
      },
    );
  }
}
