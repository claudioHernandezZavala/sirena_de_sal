import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sirena_de_sal/clases/categoria.dart';
import 'package:sirena_de_sal/funciones/funciones_firebase.dart';

import '../../../constants.dart';
import '../../../recordatorios/recordatorios.dart';
import '../../../widgets/admin/categoriasAdmin.dart';
import 'admin_agregar_categoria.dart';

class PanelCategorias extends StatefulWidget {
  const PanelCategorias({Key? key}) : super(key: key);

  @override
  _PanelCategoriasState createState() => _PanelCategoriasState();
}

class _PanelCategoriasState extends State<PanelCategorias> {
  DatabaseReference postref = FirebaseDatabase.instance.ref();
  List<Categoria> categorias = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categorias"),
        backgroundColor: color2,
        centerTitle: true,
        titleTextStyle: styleLetrasAppBar,
        foregroundColor: color3,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 30,
          ),
          const recordatorio(
              recordatorio_texto:
                  "Recuerda que puedes eliminar o modificar \nuna categoria deslizandola\n a la derecha"),
          const SizedBox(
            height: 50,
          ),
          StreamBuilder(
              stream: FirebaseFirestore
                  .instance //stream de la pantalla principal para las categorias
                  .collection("categorias/")
                  .snapshots(includeMetadataChanges: true),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: color3,
                    ),
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
                  categorias = obtenerCategorias(snapshot);
                }
                return AdminCategComp(
                  categorias: categorias,
                );
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AdminAgregarCategoria()));
        },
        backgroundColor: color3,
        tooltip: "Agregar categoria nueva",
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        elevation: 20,
        splashColor: color3,
      ),
    );
  }
}
