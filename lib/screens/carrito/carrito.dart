import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirena_de_sal/widgets/noUser.dart';

import '../../clases/ItemCarrito.dart';
import '../../constants.dart';
import '../../funciones/funciones_firebase.dart';
import '../../widgets/carrito/items.dart';
import 'confirmacion.dart';

class Carrito extends StatefulWidget {
  const Carrito({Key? key}) : super(key: key);

  @override
  _CarritoState createState() => _CarritoState();
}

class _CarritoState extends State<Carrito> {
  List<ItemsCarrito> itemsDelCarrito = [];

  double total = 0;
  TextEditingController cupon = TextEditingController();
  double descuento = 0;
  bool confirmar = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return FirebaseAuth.instance.currentUser == null
        ? NoUserWidget(
            width: width,
            heigth: h,
          )
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text("Tu carrito"),
              backgroundColor: color2,
              titleTextStyle: styleLetrasAppBar,
              foregroundColor: color3,
              actions: [
                FirebaseAuth.instance.currentUser == null
                    ? Container()
                    : TextButton.icon(
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color?>(color4)),
                        icon: const Icon(Icons.check_box),
                        onPressed: () {
                          if (itemsDelCarrito.isNotEmpty) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Confirmacion(
                                      itemsDelCarrito: itemsDelCarrito,
                                      total: total - descuento,
                                      descuento: descuento,
                                      cupon: cupon.text,
                                    )));
                          } else {
                            Fluttertoast.showToast(
                                msg: "Tu carrito esta vacio",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 3,
                                backgroundColor: Colors.red,
                                textColor: Colors.black,
                                fontSize: 16.0);
                          }
                        },
                        label: const Text("Confirmar compra"),
                      )
              ],
            ),
            body: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(
                        "carritos/${FirebaseAuth.instance.currentUser!.uid}/carrito/")
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
                    itemsDelCarrito.clear();
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/emptcart.png",
                            height: 300,
                            width: 300,
                          ),
                          const Text(
                            "Tu carrito esta vacio,agrega productos",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ],
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    total = 0;

                    itemsDelCarrito = obtenerItemCarrito(snapshot);
                    if (itemsDelCarrito.isNotEmpty) {
                      for (var element in itemsDelCarrito) {
                        total += (element.precio * element.cantidadProducto);
                      }
                    }
                  }
                  return itemsDelCarrito.isNotEmpty
                      ? Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: itemsDelCarrito.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == itemsDelCarrito.length) {
                                      return todo();
                                    }
                                    return Slidable(
                                        actionPane:
                                            const SlidableDrawerActionPane(),
                                        actions: [
                                          IconSlideAction(
                                            caption: "Eliminar",
                                            color: const Color(0xFF8C0000),
                                            icon: Icons.delete,
                                            onTap: () {
                                              itemsDelCarrito[index]
                                                  .referenciaItemCarrito
                                                  .delete();
                                            },
                                          ),
                                        ],
                                        child: WidgetItem(
                                            itemCarrito:
                                                itemsDelCarrito[index]));
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox();
                }),
          );
  }

  Widget todo() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 25),
          child: SizedBox(
            width: 270,
            height: 35,
            child: Row(
              children: [
                Text(
                  "Aplicar cupon:",
                  style: GoogleFonts.yuseiMagic(color: color4, fontSize: 18),
                ),
                const SizedBox(
                  width: 15,
                ),
                SizedBox(
                  width: 130,
                  height: 100,
                  child: TextFormField(
                    controller: cupon,
                    decoration: InputDecoration(
                        focusColor: color3,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: color4, width: 5)),
                        filled: true,
                        fillColor: colorwaux,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: color3))),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color?>(color3)),
            onPressed: () {
              coupon();
            },
            child: const Text(
              "Aplicar cupon",
              style: TextStyle(color: Colors.white, fontSize: 19),
            )),
        const SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: Container(
            width: 250,
            height: 150,
            decoration: BoxDecoration(
                border: Border.all(color: color3, width: 3),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                Text(
                  "Subtotal:    ${total.toStringAsFixed(2)} Lps",
                  style: style,
                ),
                Text(
                  "Descuento:   - ${descuento.toStringAsFixed(2)} Lps",
                  style: style,
                ),
                Text(
                  "Total:       ${(total - descuento).toStringAsFixed(2)} Lps",
                  style: style,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  void coupon() {
    if (cupon.text.isNotEmpty) {
      var referencia2 = FirebaseFirestore
          .instance //esta referencia la uso para verificar si existe o no
          .collection("Descuentos/")
          .where('Clave', isEqualTo: cupon.text);
      referencia2.get().then((QuerySnapshot querySnapshot) async {
        if (querySnapshot.size == 0) {
          //si no existe el cupon

          Fluttertoast.showToast(
              msg: "Cupon no valido",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.black,
              fontSize: 16.0);
          cupon.clear();
        } else {
          //el cupon es valido
          int porcentajeDesucento = querySnapshot.docs.first.get('Porcentaje');

          double decimal = porcentajeDesucento / 100;

          double rebajaFinal = (total * decimal);
          descuento = rebajaFinal;
          setState(() {
            total = total - descuento;
          });
          Fluttertoast.showToast(
              msg: "Cupon valido",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.yellow,
              textColor: Colors.black,
              fontSize: 16.0);
        }
      });
    }
  }
}

var style = GoogleFonts.yuseiMagic(color: color4, fontSize: 17);
