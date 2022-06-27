import "package:flutter/material.dart";
import 'package:sirena_de_sal/bounciPageRoute.dart';
import 'package:sirena_de_sal/clases/producto.dart';
import 'package:sirena_de_sal/screens/admin/productos/modificar_producto.dart';

import '../../funciones/funciones_firebase.dart';

class AdminProductWidget extends StatelessWidget {
  final List<Producto> producto;
  const AdminProductWidget({Key? key, required this.producto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: producto.length + 1,
          itemBuilder: (context, index) {
            double space = 25;
            if (index == producto.length) {
              return SizedBox(
                height: 60,
              );
            }
            return Container(
              margin: EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 25),
              height: 180,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(6, 6),
                        blurRadius: 16),
                    BoxShadow(
                        color: Colors.white.withOpacity(0.8),
                        offset: const Offset(6, 6),
                        blurRadius: 16),
                  ]),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Image.network(
                      producto[index].imagenes[0],
                      height: 150,
                      width: 150,
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Expanded(child: Text(producto[index].nombre)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        iconSize: 30,
                        onPressed: () async {
                          await crearLista().then((value) {
                            Navigator.of(context)
                                .push(BouncyPageRoute(ModificaProducto(
                              list: value,
                              productoModificar: producto[index],
                            )));
                          });
                        },
                        color: Colors.blue,
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        iconSize: 30,
                        onPressed: () {
                          producto[index].referencia.delete();
                        },
                        color: Colors.red,
                        icon: const Icon(Icons.delete),
                      )
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
