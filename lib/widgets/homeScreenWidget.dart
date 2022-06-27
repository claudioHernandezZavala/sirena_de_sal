import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sirena_de_sal/clases/categoria.dart';
import 'package:sirena_de_sal/clases/descuentos.dart';
import 'package:sirena_de_sal/funciones/funciones_firebase.dart';
import 'package:sirena_de_sal/screens/allProducts.dart';
import 'package:sirena_de_sal/widgets/card_descuento.dart';
import 'package:sirena_de_sal/widgets/productosNuevosWidget.dart';

import '../clases/producto.dart';
import '../constants.dart';
import 'categoryWidget.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  List<Categoria> categories = [];
  List<Producto> productos = [];
  List<Descuento> descuentos = [];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                title: Text(
                  "$nombreEmpresa",
                  style: styleLetrasAppBar,
                ),
                centerTitle: true,
                foregroundColor: color3,
                backgroundColor: color2,
              )
            ],
        body: ListView(
          padding: const EdgeInsets.only(left: 5, top: 15, bottom: 15),
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        const AllProducts(categoria: 'none')));
              },
              child: Container(
                margin: const EdgeInsets.only(right: 20, bottom: 15, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Todos los productos",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: color4,
                        fontSize: 18,
                      ),
                    ),
                    Icon(
                      Icons.arrow_right_alt,
                      color: color3,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("categorias/")
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(
                        color: color2,
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasError) {
                      return const Center(
                        child: Icon(
                          Icons.error,
                          size: 45,
                        ),
                      );
                    }
                    if (!snapshot.hasData) {
                      return Center(
                        child: Image.asset(
                          "assets/empty.png",
                          width: 25,
                          height: 25,
                        ),
                      );
                    }
                    if (snapshot.data!.size == 0) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Image.asset(
                              "assets/empty.png",
                              width: 50,
                              height: 50,
                            ),
                          ),
                          Text(
                            "No hay categorias por ahora",
                            style: estiloLetras18,
                          )
                        ],
                      );
                    }
                    if (snapshot.hasError) {
                      return const Center(
                        child: Icon(
                          Icons.error,
                          size: 45,
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      categories = obtenerCategorias(snapshot);
                    }
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return CategoryWidget(category: categories[index]);
                      },
                    );
                  }),
            ),
            //==================================DESCUENTOS======================
            const SizedBox(
              height: 15,
            ),
            descuentos.isNotEmpty
                ? Text("Descuentos disponibles",
                    textAlign: TextAlign.center, style: styleLetrasAppBar)
                : const SizedBox(),
            const SizedBox(
              height: 10,
            ),

            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Descuentos/")
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  double s = 180;
                  if (snapshot.hasError) {
                    return const Icon(Icons.error);
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: color3,
                      ),
                    );
                  }
                  if (snapshot.data!.size == 0) {
                    s = 10;
                  }
                  if (snapshot.hasData) {
                    descuentos = obtenerDescuentos(snapshot);
                    return SizedBox(
                      height: s,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: descuentos.length,
                        itemBuilder: (context, index) {
                          return CardDescuento(
                              descripcion: descuentos[index].descripcion,
                              porcentaje: descuentos[index].porcentaje,
                              color1: descuentos[index].color1,
                              color2: descuentos[index].color2,
                              color3: descuentos[index].color3);
                        },
                      ),
                    );
                  }
                  return SizedBox(
                    height: s,
                  );
                }),

            const SizedBox(
              height: 5,
            ),
            Text("Nuevos productos",
                textAlign: TextAlign.center, style: styleLetrasAppBar),

            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("productos/")
                    .orderBy("nombre")
                    .limitToLast(10)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Icon(Icons.error);
                  }
                  if (!snapshot.hasData) {
                    return Image.asset(
                      "assets/empty.png",
                      width: 25,
                      height: 25,
                    );
                  }
                  if (snapshot.data!.size == 0) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/empty.png",
                            width: 50,
                            height: 50,
                          ),
                        ),
                        Text(
                          "No hay productos por ahora",
                          style: estiloLetras22,
                        )
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
                  if (snapshot.hasData) {
                    productos = obtainProducts(snapshot);
                  }
                  return SizedBox(
                    height: 450,
                    child: ListView.builder(
                        itemCount: productos.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return ProdNuevosWidget(producto: productos[index]);
                        }),
                  );
                })
          ],
        ));
  }
}
