import 'package:buy_zone/core/database/cart_database.dart';
import 'package:buy_zone/core/database/fav_database.dart';
import 'package:buy_zone/core/dependency%20injection/dependency_injection.dart';
import 'package:buy_zone/core/network/services/api_client.dart';
import 'package:buy_zone/core/utiils/my_bottom_nav_bar.dart';
import 'package:buy_zone/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:buy_zone/features/favourite/presentation/cubit/fav_cubit.dart';
import 'package:buy_zone/features/home/data/datasource/product_ds.dart';
import 'package:buy_zone/features/home/data/models/product.dart';
import 'package:buy_zone/features/home/data/repo%20imp/product_repo_imp.dart';
import 'package:buy_zone/features/home/domain/usecase/product_usecase.dart';
import 'package:buy_zone/features/home/presentation/cubit/product_cubit.dart';
import 'package:buy_zone/features/home/presentation/pages/products_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'features/home/presentation/cubit/cat_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  await Hive.openBox("fav_db");
  await Hive.openBox("cart_db");
  await DependencyInjection.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductCubit(sl<ProductUseCase>())),
        BlocProvider(create: (_) => FavCubit(sl<FavDatabase>())),
        BlocProvider(create: (_) => CartCubit(sl<CartDatabase>())),
        BlocProvider(create: (context) => CatCubit(sl<ProductUseCase>())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyBottomNavBar());
  }
}
