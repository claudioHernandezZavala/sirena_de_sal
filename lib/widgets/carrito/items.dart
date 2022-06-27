import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirena_de_sal/constants.dart';

import '../../clases/ItemCarrito.dart';

class WidgetItem extends StatefulWidget {
  final ItemsCarrito itemCarrito;
  const WidgetItem({Key? key, required this.itemCarrito}) : super(key: key);

  @override
  State<WidgetItem> createState() => _WidgetItemState();
}

class _WidgetItemState extends State<WidgetItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 5),
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.8),
              offset: const Offset(-6.0, -6.0),
              blurRadius: 16.0,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(6.0, 6.0),
              blurRadius: 16.0,
            ),
          ],
          color: colorwaux,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Image.network(
                widget.itemCarrito.imagen,
                width: 100,
                height: 100,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
                child: Column(
              children: [
                Text(
                  widget.itemCarrito.nombre,
                  style: style,
                ),
                Text(
                  "Lps." + widget.itemCarrito.precio.toStringAsFixed(2),
                  style: style,
                )
              ],
            )),
            Align(
              alignment: Alignment.centerRight,
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      widget.itemCarrito.cantidadProducto++;
                      widget.itemCarrito.referenciaItemCarrito.set(
                          {'cantidad': widget.itemCarrito.cantidadProducto},
                          SetOptions(merge: true));
                    },
                    icon: Icon(Icons.add, size: 35, color: color3),
                  ),
                  Text(
                    widget.itemCarrito.cantidadProducto.toString(),
                    style: style,
                  ),
                  IconButton(
                      onPressed: () {
                        if (widget.itemCarrito.cantidadProducto > 1) {
                          widget.itemCarrito.cantidadProducto--;
                          widget.itemCarrito.referenciaItemCarrito.set(
                              {'cantidad': widget.itemCarrito.cantidadProducto},
                              SetOptions(merge: true));
                        }
                      },
                      icon: Icon(
                        Icons.remove,
                        size: 35,
                        color: color3,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

var style = GoogleFonts.yuseiMagic(
    color: color4, fontSize: 18, fontWeight: FontWeight.bold);
