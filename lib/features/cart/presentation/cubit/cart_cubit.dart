import 'package:bloc/bloc.dart';
import 'package:buy_zone/features/cart/presentation/cubit/cart_state.dart';
import 'package:buy_zone/features/home/data/models/product.dart';
import '../../../../core/database/cart_database.dart';

class CartCubit extends Cubit<CartState> {
  final CartDatabase cartDatabase;
  CartCubit(this.cartDatabase) : super(CartInitState()) {
    loadCart();
  }

  Future<void> loadCart() async {
    emit(CartLoadingState());
    try {
      final cartProducts = await cartDatabase.loadProducts();
      emit(CartLoadedState(products: cartProducts));
    } catch (e) {
      emit(CartErrorState(errorMsg: e.toString()));
    }
  }

  bool isProductInCart(int productId) {
    if (state is CartLoadedState) {
      return (state as CartLoadedState).products.any((p) => p.id == productId);
    } else {
      return false;
    }
  }

  Future<void> toggleCart(Product product) async {
    try {
      if (isProductInCart(product.id)) {
        await cartDatabase.removeProductById(product.id);
      } else {
        await cartDatabase.addProduct(product);
      }
      await loadCart();
    } catch (e) {
      emit(CartErrorState(errorMsg: e.toString()));
    }
  }
}
