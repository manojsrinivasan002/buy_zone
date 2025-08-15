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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 10),
        title: Text("Buy Zone"),
        backgroundColor: Colors.white,
        actions: [
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FavouritesPage()),
            ),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.favorite, color: Colors.red.shade900, size: 20),
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartPage()),
            ),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.shopping_bag, size: 20, color: Colors.black),
            ),
          ),
        ],
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadingState) {
            return Center(
              child: SizedBox(
                height: 23,
                width: 23,
                child: CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 2,
                ),
              ),
            );
          } else if (state is ProductLoadedState) {
            if (state.products.isEmpty) {
              return Center(child: Text("Its empty"));
            }
            return GridView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.03,
              ),
              itemCount: state.products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.60,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final product = state.products[index];
                return ProductTile(product: product);
              },
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
