import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:sirena_de_sal/constants.dart';
import 'package:sirena_de_sal/screens/favorites/favoritesScreen.dart';
import 'package:sirena_de_sal/screens/perfil.dart';
import 'package:sirena_de_sal/widgets/homeScreenWidget.dart';
import 'package:sirena_de_sal/widgets/navBar.dart';

import 'carrito/carrito.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final screens = [
    const HomeWidget(),
    const FavoriteScreen(),
    const Carrito(),
    Perfil(),
  ];

  int _currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorwaux,
        drawer: drawer(context),
        body: IndexedStack(
          children: screens,
          index: _currentindex,
        ),
        bottomNavigationBar: SalomonBottomBar(
          unselectedItemColor: color3,
          currentIndex: _currentindex,
          onTap: (i) {
            setState(() {
              _currentindex = i;
            });
          },
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text("Home"),
              selectedColor: Colors.purple,
            ),

            /// favoritos
            SalomonBottomBarItem(
              icon: const Icon(Icons.favorite_border),
              title: const Text("Favoritos"),
              selectedColor: Colors.pink,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.shopping_bag_sharp),
              title: const Text("Carrito"),
              selectedColor: Colors.pink,
            ),

            /// buscar

            /// perfil
            SalomonBottomBarItem(
              icon: const Icon(Icons.person),
              title: const Text("Perfil"),
              selectedColor: Colors.teal,
            ),
          ],
        ));
  }
}
