import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../usuario/infoUsuario.dart';

class pedido {
  String fechaPedido;
  String detallesExtras, cuponUtilizado;
  double total;
  justGeneralInfo infoUsuario;
  List<itemsPedidos> itemsDelPedido;
  String uid;
  String idPedido;
  DocumentReference referencia;
  bool recibido;
  bool enProgreso;
  bool entregado;

  pedido(
      this.fechaPedido,
      this.detallesExtras,
      this.cuponUtilizado,
      this.total,
      this.infoUsuario,
      this.itemsDelPedido,
      this.uid,
      this.referencia,
      this.idPedido,
      this.recibido,
      this.enProgreso,
      this.entregado);

  factory pedido.fromJson(dynamic json, DocumentReference reference) {
    return pedido(
        DateFormat('dd-MM-yyyy').format(json['Fecha'].toDate()),
        json['Detalles de pedido'] as String,
        json["Cupon utilizado"],
        json["Total"],
        justGeneralInfo.fromJson(json["Informacion Cliente"]),
        List<itemsPedidos>.from(varConLista(json['articulos'])
            .map((e) => itemsPedidos.fromJson(e))),
        json['uid'] as String,
        reference,
        json['id-de-pedido'] as String,
        json["recibido"] as bool,
        json["enProgreso"] as bool,
        json["entregado"] as bool);
  }
/*
  Widget construirPedidoUsuario() {
    return FutureBuilder<DocumentSnapshot>(
      future: referencia.get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }
        if (!snapshot.hasData) {
          return Column(
            children: [
              Image.asset(
                "assets/empty.png",
                width: 100,
                height: 100,
              ),
              Text("No tienes pedidos aun")
            ],
          );
        }
        if (!snapshot.hasData) {
          return Column(
            children: [
              Image.asset(
                "assets/emptyProducts.png",
                width: 100,
                height: 100,
              ),
              Text("No tienes pedidos aun")
            ],
          );
        }
        if (snapshot.data == null) {
          return Column(
            children: [
              Image.asset(
                "assets/emptyProducts.png",
                width: 100,
                height: 100,
              ),
              Text("No tienes pedidos aun")
            ],
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          //aqui va el pedidoWidget
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
  List<Widget> itemsGenerator1() {
    List<ListTile> lista = [];
    itemsDelPedido.forEach((element) {
      lista.add(ListTile(
        title: Text(
          element.nombre,
          style: estiloLetras18,
        ),
        leading: const Icon(Icons.pages_rounded),
        iconColor: color3,
        subtitle: Text(
          "Cantidad:" + element.cantidad.toString(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ));
    });
    return lista;
  }
}

List varConLista(dynamic json) {
  return jsonDecode(jsonEncode(json));
}

List<Widget> itemsGenerator2(List<itemsPedidos> items) {
  List<ListTile> lista = [];
  items.forEach((element) {
    lista.add(ListTile(
      title: Text(element.nombre),
      leading: Icon(Icons.pages_rounded),
      iconColor: color2,
    ));
  });
  return lista;
}

class itemsPedidos {
  String nombre;
  int cantidad;
  itemsPedidos(this.nombre, this.cantidad);
  factory itemsPedidos.fromJson(dynamic json) {
    return itemsPedidos(json['Nombre'] as String, json['Cantidad'] as int);
  }
}
