import 'package:buy_zone/features/cart/presentation/pages/cart_page.dart';
import 'package:buy_zone/features/favourite/presentation/pages/favourites_page.dart';
import 'package:buy_zone/features/home/presentation/cubit/product_cubit.dart';
import 'package:buy_zone/features/home/presentation/cubit/product_state.dart';
import 'package:buy_zone/features/home/presentation/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().fetchProducts();
    context.read<CatCubit>().fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.03,
                vertical: MediaQuery.of(context).size.width * 0.02,
              ),
              child: TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Search products",
                  prefixIcon: Icon(Icons.search),
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<CatCubit, CatState>(
                builder: (context, state) {
                  if (state is CatLoadingState) {
                    return const Center(
                      child: SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  } else if (state is CatLoadedState) {
                    final categories = state.categories;
                    return DefaultTabController(
                      length: categories.length,
                      child: Column(
                        children: [
                          TabBar(
                            unselectedLabelColor: Colors.grey,
                            tabAlignment: TabAlignment.start,
                            isScrollable: true,
                            labelColor: Colors.black,
                            indicatorColor: Colors.black,
                            tabs: categories
                                .map((cat) => Tab(text: cat.name))
                                .toList(),
                          ),
                          Expanded(
                            child: TabBarView(
                              children: categories.map((cat) {
                                return BlocBuilder<ProductCubit, ProductState>(
                                  builder: (context, productState) {
                                    if (productState is ProductLoadingState) {
                                      return const Center(
                                        child: SizedBox(
                                          height: 22,
                                          width: 22,
                                          child: CircularProgressIndicator(
                                            color: Colors.black,
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      );
                                    } else if (productState
                                        is ProductLoadedState) {
                                      final filtered = productState.products
                                          .where((p) => p.category == cat.slug)
                                          .toList();
                                      if (filtered.isEmpty) {
                                        return const Center(
                                          child: Text("No products found"),
                                        );
                                      }
                                      return GridView.builder(
                                        padding: EdgeInsets.symmetric(
                                          horizontal:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.03,
                                          vertical: 10,
                                        ),
                                        itemCount: filtered.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 0.60,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                            ),
                                        itemBuilder: (context, index) {
                                          return ProductTile(
                                            product: filtered[index],
                                          );
                                        },
                                      );
                                    }
                                    return const SizedBox();
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is CatErrorState) {
                    return Center(child: Text("Error: ${state.errorMsg}"));
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
