import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../clases/descuentos.dart';
import '../../../constants.dart';
import '../../../funciones/funciones_firebase.dart';
import '../../../recordatorios/recordatorios.dart';
import '../../../widgets/card_descuento.dart';
import 'agregar_descuentos.dart';
import 'modificarDescuento.dart';

class PanelDescuentos extends StatefulWidget {
  const PanelDescuentos({Key? key}) : super(key: key);

  @override
  _PanelDescuentosState createState() => _PanelDescuentosState();
}

class _PanelDescuentosState extends State<PanelDescuentos> {
  List<Descuento> descuentos = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1,
      appBar: AppBar(
        title: const Text("Descuentos"),
        centerTitle: true,
        backgroundColor: color2,
        foregroundColor: color3,
        titleTextStyle: styleLetrasAppBar,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          const recordatorio(
              recordatorio_texto:
                  "Recuerda que puedes eliminar o modificar \nun descuento deslizandolo a la derecha"),
          const SizedBox(
            height: 35,
          ),
          const SizedBox(
            height: 15,
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Descuentos/")
                .snapshots(includeMetadataChanges: true),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Column(
                  children: const [
                    Text(
                      "Algo salio mal\n comprueba tu conexion a internet",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                );
              }

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
                        "No hay Descuentos,Agrega uno nuevo",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ],
                  ),
                );
              }
              if (snapshot.data!.size != 0) {
                descuentos = obtenerDescuentos(snapshot);
              }

              return Expanded(
                child: ListView.builder(
                    itemCount: descuentos.length,
                    itemBuilder: (context, index) {
                      return Slidable(
                        actionPane: const SlidableDrawerActionPane(),
                        actions: [
                          IconSlideAction(
                            caption: "Eliminar",
                            color: const Color(0xFF8C0000),
                            icon: Icons.delete,
                            onTap: () {
                              descuentos[index].reference.delete();
                            },
                          ),
                          IconSlideAction(
                            caption: "Modificar",
                            color: Colors.green,
                            icon: Icons.mode_edit,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ModificarDescuento(
                                      descuentoModificar: descuentos[index])));
                            },
                          )
                        ],
                        child: CardDescuento(
                            descripcion: descuentos[index].descripcion,
                            porcentaje: descuentos[index].porcentaje,
                            color1: descuentos[index].color1,
                            color2: descuentos[index].color2,
                            color3: descuentos[index].color3),
                      );
                    }),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: color3,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AgregarDescuento()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
