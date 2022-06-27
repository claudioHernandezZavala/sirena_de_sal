// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemsCarrito {
  DocumentReference referenciaAProducto;
  String imagen, nombre;
  double precio;
  int cantidadProducto;
  DocumentReference referenciaItemCarrito;

  ItemsCarrito(this.referenciaAProducto, this.cantidadProducto,
      this.referenciaItemCarrito, this.nombre, this.precio, this.imagen);
  Map toJson() {
    return {'Nombre': nombre, 'Cantidad': cantidadProducto};
  }

  /*
  late Producto producto;
  Widget construirProducto() {
    return FutureBuilder<DocumentSnapshot>(
      future: referenciaAProducto.get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          Producto productoNuevo = Producto(
              data["imagenes"].cast<String>(),
              data['nombre'],
              data['descripcion'],
              data['precio'],
              data['material'],
              data['categoria'],
              referenciaAProducto);
          producto = productoNuevo;
          return WidgetItem(itemCarrito: this);
        }

        return SizedBox(
          width: 200.0,
          height: 120.0,
          child: Shimmer.fromColors(
              baseColor: Colors.red,
              highlightColor: Colors.yellow,
              child: ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  color: Colors.blue,
                ),
                title: Container(
                  width: double.infinity,
                  height: 15,
                  color: Colors.orange,
                ),
                subtitle: Container(
                  height: 5,
                  width: 1,
                  color: Colors.red,
                ),
              )),
        );
      },
    );
  }

   */
}
