import 'package:buy_zone/core/database/cart_database.dart';
import 'package:buy_zone/core/database/fav_database.dart';
import 'package:buy_zone/core/network/services/api_client.dart';
import 'package:buy_zone/features/home/data/datasource/product_ds.dart';
import 'package:buy_zone/features/home/data/repo%20imp/product_repo_imp.dart';
import 'package:buy_zone/features/home/domain/usecase/product_usecase.dart';
import 'package:get_it/get_it.dart';
import '../../features/home/domain/repo ab/product_repo_ab.dart';

final sl = GetIt.instance;

class DependencyInjection {
  static Future<void> init() async {
    // Database
    sl.registerLazySingleton(() => FavDatabase());
    sl.registerLazySingleton(() => CartDatabase());

    // Api
    sl.registerLazySingleton(() => ApiClient());

    // Data source
    sl.registerLazySingleton(() => ProductDs(sl()));

    // Repositories
    sl.registerLazySingleton<ProductRepoAb>(() => ProductRepoImp(sl()));

    // Usecases
    sl.registerLazySingleton(() => ProductUseCase(sl()));
  }
}
