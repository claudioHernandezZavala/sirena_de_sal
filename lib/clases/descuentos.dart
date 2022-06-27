import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Descuento {
  String descripcion, codigo;
  int porcentaje;
  Color color1;
  Color color2;
  Color color3;
  DocumentReference reference;
  Descuento(this.descripcion, this.codigo, this.porcentaje, this.color1,
      this.color2, this.color3, this.reference);
}
