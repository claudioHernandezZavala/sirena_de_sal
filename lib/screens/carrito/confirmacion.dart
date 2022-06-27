import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sirena_de_sal/screens/carrito/receipt.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:uuid/uuid.dart';

import '../../bounciPageRoute.dart';
import '../../clases/ItemCarrito.dart';
import '../../constants.dart';
import '../../funciones/funciones_firebase.dart';
import '../perfil.dart';

class Confirmacion extends StatefulWidget {
  final List<ItemsCarrito> itemsDelCarrito;
  final double total;
  final String cupon;

  final double descuento;
  const Confirmacion(
      {Key? key,
      required this.itemsDelCarrito,
      required this.total,
      required this.cupon,
      required this.descuento})
      : super(key: key);

  @override
  State<Confirmacion> createState() => _ConfirmacionState();
}

class _ConfirmacionState extends State<Confirmacion> {
  TextEditingController descripcion = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorwaux,
      appBar: AppBar(
        backgroundColor: color2,
        foregroundColor: color3,
        titleTextStyle: styleLetrasAppBar,
        title: const Text("Detalles de entrega"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 35,
              ),
              Text(
                "Antes de confirmar tu compra\nDanos más detalles...",
                style: styleLetrasAppBar,
              ),
              const SizedBox(height: 15),
              Text(
                "Agrega una descripción extra para tu pedido",
                style: style,
              ),
              Padding(
                padding: const EdgeInsets.all(35),
                child: TextFormField(
                  maxLines: null,
                  minLines: 6,
                  controller: descripcion,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'Descripción (opcional)',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2),
                    ),
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 20),
                    floatingLabelStyle: const TextStyle(
                        color: Colors.black,
                        backgroundColor: Colors.transparent,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                    fillColor: color3.withOpacity(0.8),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                    "La información en tu perfil se usará para el pedido",
                    textAlign: TextAlign.justify,
                    style: style),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        BouncyPageRoute(const Perfil()), (route) => false);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    width: 300,
                    child: Center(
                      child: Column(
                        children: [
                          const Icon(
                            Icons.person_add,
                            size: 45,
                            color: Colors.deepPurple,
                          ),
                          Text(
                            "Puedes agregar informacion a tu perfil!",
                            textAlign: TextAlign.center,
                            style: estiloLetras18,
                          )
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: color3, borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(),
                child: SlideAction(
                  onSubmit: () async {
                    var ref = FirebaseFirestore.instance;
                    var uuid = const Uuid();
                    List<ItemsCarrito> v = widget.itemsDelCarrito;

                    String idPedido = uuid.v4();
                    await getInfoForPedido().then((value) {
                      ref.collection("pedidos/").add({
                        'articulos': v.map((i) => i.toJson()).toList(),
                        'Fecha': DateTime.now(),
                        'id-de-pedido': idPedido,
                        'Detalles de pedido': descripcion.text,
                        'Informacion Cliente': value.toJson(),
                        'Total': widget.total,
                        'Cupon utilizado': widget.cupon,
                        'uid': FirebaseAuth.instance.currentUser?.uid,
                        'recibido': true,
                        'enProgreso': false,
                        'entregado': false,
                      }).whenComplete(() {
                        Navigator.of(context)
                            .push(BouncyPageRoute(Recibo(
                                info: value,
                                idPedido: idPedido,
                                items: v,
                                descuento: widget.descuento,
                                total: widget.total,
                                cupon: widget.cupon,
                                extra: descripcion.text)))
                            .whenComplete(() {});
                      });
                    });
                  },
                  outerColor: color3,
                  elevation: 25,
                  child: Shimmer.fromColors(
                    child: const Text(
                      "Desliza y confirma",
                    ),
                    baseColor: Colors.black,
                    highlightColor: Colors.white,
                    enabled: true,
                    period: const Duration(milliseconds: 1000),
                  ),
                  submittedIcon: const Icon(
                    Icons.done_all,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

var style = GoogleFonts.yuseiMagic(
    color: color4, fontSize: 18, fontWeight: FontWeight.bold);
