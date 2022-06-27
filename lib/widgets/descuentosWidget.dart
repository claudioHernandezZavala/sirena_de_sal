import 'package:flutter/material.dart';

class DescuentosWidget extends StatelessWidget {
  const DescuentosWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(15),
        width: 250,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.colorBurn),
                image: const AssetImage("assets/s1.jpeg"))),
        child: const Center(
          child: Text(
            "20% de descuento, al usar el codigo CLAUDIO",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ));
  }
}
