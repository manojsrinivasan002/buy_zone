import 'package:buy_zone/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:buy_zone/features/favourite/presentation/cubit/fav_cubit.dart';
import 'package:buy_zone/features/home/data/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductTile extends StatefulWidget {
  final Product product;
  const ProductTile({super.key, required this.product});

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey.shade300,
          style: BorderStyle.solid,
          width: 0.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  final cubit = context.read<FavCubit>();
                  cubit.toggleFav(widget.product);
                },
                icon:
                    context.watch<FavCubit>().isProductInFav(widget.product.id)
                    ? Icon(Icons.favorite, size: 20, color: Colors.red.shade900)
                    : Icon(Icons.favorite_outline, size: 20),
              ),
              IconButton(
                onPressed: () {
                  context.read<CartCubit>().toggleCart(widget.product);
                },
                icon:
                    context.watch<CartCubit>().isProductInCart(
                      widget.product.id,
                    )
                    ? Icon(Icons.shopping_bag, size: 20)
                    : Icon(Icons.shopping_bag_outlined, size: 20),
              ),
            ],
          ),
          Image.network(
            widget.product.thumbnail,
            height: height * 0.16,
            fit: BoxFit.contain,
          ),
          Text(
            widget.product.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.star_rate_rounded, color: Colors.black, size: 20),
                  SizedBox(width: 5),
                  Text(widget.product.rating.toString()),
                ],
              ),
              Text("\$${widget.product.price.toString()}"),
            ],
          ),
        ],
      ),
    );
  }
}
