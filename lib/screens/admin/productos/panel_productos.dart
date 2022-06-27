import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sirena_de_sal/bounciPageRoute.dart';
import 'package:sirena_de_sal/clases/producto.dart';
import 'package:sirena_de_sal/constants.dart';
import 'package:sirena_de_sal/funciones/funciones_firebase.dart';
import 'package:sirena_de_sal/widgets/admin/productos_widget_admin.dart';

import 'agregar_producto.dart';

class PanelProductos extends StatefulWidget {
  const PanelProductos({Key? key}) : super(key: key);

  @override
  _PanelProductosState createState() => _PanelProductosState();
}

class _PanelProductosState extends State<PanelProductos> {
  List<Producto> productos = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: Text("Tus productos", style: styleLetrasAppBar),
        centerTitle: true,
        backgroundColor: color2,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 35,
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("productos/")
                .snapshots(includeMetadataChanges: true),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.connectionState == ConnectionState.none ||
                  snapshot.hasError) {
                return Center(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/emptyProducts.png",
                        width: 250,
                        height: 250,
                      ),
                      const Text("Hubo un error, intenta de nuevo")
                    ],
                  ),
                );
              }
              if (snapshot.data!.size == 0) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/empty.png",
                        height: 300,
                        width: 300,
                      ),
                      const Text(
                        'No hay productos,agrega uno nuevo',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ],
                  ),
                );
              }
              if (snapshot.hasData) {
                productos = obtainProducts(snapshot);
              }

              return AdminProductWidget(producto: productos);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await crearLista().then((value) => Navigator.of(context)
              .push(BouncyPageRoute(Agregar_producto(list: value))));
        },
        backgroundColor: color3,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
