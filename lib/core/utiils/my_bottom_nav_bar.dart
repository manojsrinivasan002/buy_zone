import 'dart:ui';

import 'package:buy_zone/features/cart/presentation/pages/cart_page.dart';
import 'package:buy_zone/features/favourite/presentation/pages/favourites_page.dart';
import 'package:buy_zone/features/home/presentation/pages/products_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({super.key});

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const ProductsPage(),
    const FavouritesPage(),
    const CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100.withOpacity(0.6),
              border: BorderDirectional(top: BorderSide(color: Colors.black26)),
            ),
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.black,
              onTap: (value) {
                setState(() {
                  _selectedIndex = value;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.storefront_outlined),
                  label: "Store",
                  activeIcon: Icon(Icons.storefront_rounded),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_outline),
                  label: "Favourites",
                  activeIcon: Icon(Icons.favorite_outlined),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag_outlined),
                  label: "Cart",
                  activeIcon: Icon(Icons.shopping_bag),
                ),
              ],
            ),
          ),
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
