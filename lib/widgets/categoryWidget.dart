import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sirena_de_sal/clases/categoria.dart';

import '../bounciPageRoute.dart';
import '../constants.dart';
import '../screens/allProducts.dart';

class CategoryWidget extends StatelessWidget {
  final Categoria category;
  const CategoryWidget({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(BouncyPageRoute(AllProducts(
          categoria: category.categoriaTexto,
        )));
      },
      child: Column(
        children: [
          Container(
              width: 130,
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: color3, borderRadius: BorderRadius.circular(70)),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: color3,
                backgroundImage: CachedNetworkImageProvider(
                  category.imagen,
                ),
              )),
          Text(category.categoriaTexto)
        ],
      ),
    );
  }
}
