import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../clases/pedido.dart';
import '../../../constants.dart';
import '../../../funciones/funciones_firebase.dart';
import 'screenPedido.dart';

class AdminPedidos extends StatefulWidget {
  const AdminPedidos({Key? key}) : super(key: key);

  @override
  State<AdminPedidos> createState() => _AdminPedidosState();
}

class _AdminPedidosState extends State<AdminPedidos> {
  List<pedido> pedidos = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1,
      appBar: AppBar(
        title: const Text("Pedidos"),
        centerTitle: true,
        titleTextStyle: styleLetrasAppBar,
        foregroundColor: color3,
        backgroundColor: color2,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("pedidos/").snapshots(),
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
                    "Aun no tienes pedidos pendientes",
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
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ScreenPedidoInfo(pedidoVer: pedidos[index])));
                  },
                  child: Container(
                      margin: const EdgeInsets.all(15),
                      padding: const EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                          color: color3,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              pedidos[index].idPedido,
                              style: style1,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Center(
                            child: Text(
                              "Pedido hecho por:" +
                                  pedidos[index].infoUsuario.nombre,
                              style: style1,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: Text(
                              "Fecha de pedido:" + pedidos[index].fechaPedido,
                              style: style1,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          )
                        ],
                      )),
                );
              });
        },
      ),
    );
  }
}

var style1 = GoogleFonts.yuseiMagic(
    fontSize: 15, fontWeight: FontWeight.bold, color: color4);
var style2 =
    TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color4);
