import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class CardDescuento extends StatefulWidget {
  final String descripcion;
  final int porcentaje;
  final Color color1;
  final Color color2;
  final Color color3;
  const CardDescuento(
      {Key? key,
      required this.descripcion,
      required this.porcentaje,
      required this.color1,
      required this.color2,
      required this.color3})
      : super(key: key);

  @override
  _CardDescuentoState createState() => _CardDescuentoState();
}

class _CardDescuentoState extends State<CardDescuento> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 10, top: 25, bottom: 25),
      child: Card(
        shadowColor: color3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 15,
        child: Container(
          width: 350,
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: widget.color1
              //gradient: LinearGradient(colors: [widget.color1, widget.color2]),
              ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(widget.porcentaje.toString(),
                    style: GoogleFonts.lobster(
                        textStyle:
                            TextStyle(fontSize: 65, color: widget.color2))),
              ),
              Text("%",
                  style: GoogleFonts.lobster(
                      textStyle:
                          TextStyle(fontSize: 35, color: widget.color2))),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, left: 10),
                  child: Text(
                    widget.descripcion,
                    style: GoogleFonts.yuseiMagic(
                        textStyle:
                            TextStyle(fontSize: 18, color: widget.color3)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
