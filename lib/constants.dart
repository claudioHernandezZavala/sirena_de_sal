import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var color1 = const Color(0xFFF4F6F5);
var color2 = const Color(0xFFF6E0C1);
var color3 = const Color(0xFFD09D69);
var colorwaux = const Color(0xFFF1EDEA);
var color4 = const Color(0xFF6A5D51);
var styleLetrasAppBar = GoogleFonts.yuseiMagic(color: color4, fontSize: 25);
var estiloLetras18 = GoogleFonts.yuseiMagic(
    fontSize: 18, fontWeight: FontWeight.bold, color: color4);
var estiloLetras20 = GoogleFonts.yuseiMagic(
    fontSize: 20, fontWeight: FontWeight.bold, color: color4);
var estiloLetras22 = GoogleFonts.yuseiMagic(
    fontSize: 20, fontWeight: FontWeight.bold, color: color4);
var estiloLetras25 = GoogleFonts.yuseiMagic(
    fontSize: 20, fontWeight: FontWeight.bold, color: color4);
var estiloLetras18Dinero = GoogleFonts.yuseiMagic(
    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green);
InputDecoration InputStyle(String labelText) {
  return InputDecoration(
    labelText: labelText,
    filled: true,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: Colors.black, width: 2),
    ),
    labelStyle: const TextStyle(color: Colors.white, fontSize: 20),
    floatingLabelStyle: const TextStyle(
        color: Colors.black,
        backgroundColor: Colors.transparent,
        fontSize: 25,
        fontWeight: FontWeight.bold),
    fillColor: color3.withOpacity(0.8),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
  );
}

String nombreEmpresa = "Nombre empresa";
List<DocumentReference> favorites = [];
