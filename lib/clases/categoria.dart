import 'package:cloud_firestore/cloud_firestore.dart';

class Categoria {
  String imagen;
  String categoriaTexto;
  DocumentReference referencia;
  Categoria(this.imagen, this.categoriaTexto, this.referencia);
}
