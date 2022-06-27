import 'package:cloud_firestore/cloud_firestore.dart';

class Producto {
  List<String> imagenes;
  String nombre, descripcion;
  String material;
  double precio;
  DocumentReference referencia;

  String categoria;
  Producto(this.imagenes, this.nombre, this.descripcion, this.precio,
      this.material, this.categoria, this.referencia);
}
