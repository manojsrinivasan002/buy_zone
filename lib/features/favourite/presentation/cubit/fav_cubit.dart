import 'package:bloc/bloc.dart';
import 'package:buy_zone/core/database/fav_database.dart';
import 'package:buy_zone/features/favourite/presentation/cubit/fav_state.dart';
import 'package:buy_zone/features/home/data/models/product.dart';

class FavCubit extends Cubit<FavState> {
  final FavDatabase favDatabase;
  FavCubit(this.favDatabase) : super(FavInitState()) {
    loadFav();
  }

  Future<void> loadFav() async {
    emit(FavLoadingState());
    try {
      final favProducts = await favDatabase.loadProducts();
      emit(FavLoadedState(products: favProducts));
    } catch (e) {
      emit(FavErrorState(errorMsg: e.toString()));
    }
  }

  bool isProductInFav(int productId) {
    if (state is FavLoadedState) {
      return (state as FavLoadedState).products.any((p) => p.id == productId);
    } else {
      return false;
    }
  }

  Future<void> toggleFav(Product product) async {
    try {
      if (isProductInFav(product.id)) {
        await favDatabase.removeProductById(product.id);
      } else {
        await favDatabase.addProduct(product);
      }
      await loadFav();
    } catch (e) {
      emit(FavErrorState(errorMsg: e.toString()));
    }
  }
}
