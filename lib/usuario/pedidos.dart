import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sirena_de_sal/funciones/funciones_firebase.dart';
import 'package:sirena_de_sal/widgets/pedidoWidget.dart';

import '../../constants.dart';
import '../clases/pedido.dart';

class Pedidos extends StatefulWidget {
  const Pedidos({Key? key}) : super(key: key);

  @override
  State<Pedidos> createState() => _PedidosState();
}

class _PedidosState extends State<Pedidos> {
  List<pedido> pedidos = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Mis pedidos"),
          backgroundColor: color2,
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("pedidos/")
                .where("uid",
                    isEqualTo:
                        FirebaseAuth.instance.currentUser!.uid.toString())
                .snapshots(includeMetadataChanges: true),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                        "assets/empty.png",
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
                        "Aun no tienes pedidos!",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ],
                  ),
                );
              }
              if (snapshot.hasData) {
                pedidos = obtenerPedidos(snapshot);
              }
              return ListView.builder(
                  itemCount: pedidos.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                        actionPane: const SlidableDrawerActionPane(),
                        actions: [
                          IconSlideAction(
                            caption: "Eliminar",
                            color: const Color(0xFF8C0000),
                            icon: Icons.delete,
                            onTap: () {
                              pedidos[index].referencia.delete();
                            },
                          ),
                        ],
                        child: PedidoWidget(
                          pedidoVer: pedidos[index],
                        ));
                  });
            }));
  }
}
