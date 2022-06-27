import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirena_de_sal/bounciPageRoute.dart';
import 'package:sirena_de_sal/funciones/funciones_firebase.dart';
import 'package:sirena_de_sal/screens/carrito/carrito.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../clases/producto.dart';
import '../constants.dart';
import '../widgets/details/DescriptionDetailWidget.dart';

class DetailScreen extends StatefulWidget {
  final Producto prod;
  const DetailScreen({Key? key, required this.prod}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int cant = 1;
  bool isCollapsed = true;
  bool isLiked = false;
  bool isAnimating = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      if (FirebaseAuth.instance.currentUser != null) {
        FirebaseFirestore.instance
            .collection("usuarios/")
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .snapshots(includeMetadataChanges: true)
            .listen((event) {
          favorites = event.data()?["favorites"].cast<DocumentReference>();
        });
        if (mounted) {
          if (favorites.contains(widget.prod.referencia)) {
            if (mounted) {
              setState(() {
                isLiked = true;
              });
            }
          }
        }
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: colorwaux,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(BouncyPageRoute(const Carrito()));
              },
              icon: Icon(
                Icons.shopping_bag_sharp,
                size: 35,
                color: color3,
              ))
        ],
        title: Text(
          "Detalles de producto",
          style: estiloLetras20,
        ),
        foregroundColor: color3,
        backgroundColor: color2,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 450),
              curve: Curves.bounceOut,
              height: isCollapsed ? h * 0.65 : h * 0.5,
              child: Swiper(
                  itemCount: widget.prod.imagenes.length,
                  itemWidth: isCollapsed ? 380 : 300,
                  autoplayDisableOnInteraction: true,
                  layout: SwiperLayout.STACK,
                  control: SwiperControl(
                    color: color3,
                    size: 35,
                  ),
                  allowImplicitScrolling: true,
                  viewportFraction: 2 / 6,
                  itemHeight: isCollapsed ? h * 0.65 : h * 0.5,
                  loop: true,
                  curve: Curves.ease,
                  pagination: const SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      builder:
                          SwiperPagination()), //this alignment is for positioning the dots
                  autoplay: true,
                  fade: 150,
                  itemBuilder: (BuildContext context, int itemIndex) {
                    return RotationTransition(
                      turns: const AlwaysStoppedAnimation(-5 / 360),
                      child: Container(
                        margin: const EdgeInsets.all(45),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey, //New
                                blurRadius: 25.0,
                                offset: Offset(5, 5))
                          ],
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(
                                    top: 5, bottom: 25, left: 15, right: 15),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: NetworkImage(
                                      widget.prod.imagenes[itemIndex]),
                                )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            Positioned(
              top: 5,
              left: 10,
              child: IconButton(
                onPressed: () async {
                  if (FirebaseAuth.instance.currentUser != null) {
                    if (isLiked) {
                      if (favorites.remove(widget.prod.referencia)) {
                        await FirebaseFirestore.instance
                            .collection("usuarios/")
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .set({"favorites": favorites},
                                SetOptions(merge: true));
                      }
                      setState(() {
                        isAnimating = true;
                        isLiked = false;
                      });
                    } else {
                      favorites.add(widget.prod.referencia);
                      await FirebaseFirestore.instance
                          .collection("usuarios/")
                          .doc(FirebaseAuth.instance.currentUser?.uid)
                          .set({"favorites": favorites},
                              SetOptions(merge: true));
                      setState(() {
                        isAnimating = true;
                        isLiked = true;
                      });
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Debes iniciar sesion"),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                iconSize: 45,
                icon: isLiked
                    ? Icon(
                        Icons.favorite,
                        color: color4,
                      )
                    : Icon(Icons.favorite_border, color: color3),
              ),
            ),
            SlidingUpPanel(
              color: color2,
              panelBuilder: (controller) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView(
                    controller: controller,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.prod.nombre,
                                  maxLines: 3,
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.badScript(
                                    textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "Lps. " + widget.prod.precio.toStringAsFixed(2),
                            style: estiloLetras22,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Hecho con :" + widget.prod.material,
                        style: estiloLetras22,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DescriptionWidget(description: widget.prod.descripcion),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      if (cant > 1) {
                                        setState(() {
                                          cant--;
                                        });
                                      }
                                    },
                                    icon: const Icon(Icons.remove),
                                    iconSize: 40,
                                    color: color3),
                                Text(cant.toString(),
                                    style: const TextStyle(
                                      fontSize: 25,
                                    )),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      cant++;
                                    });
                                  },
                                  icon: const Icon(Icons.add),
                                  color: color3,
                                  iconSize: 40,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              subirCarrito(widget.prod, cant);
                            },
                            icon: const Icon(Icons.add_shopping_cart),
                            color: color4,
                            iconSize: 40,
                            splashRadius: 15,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                );
              },
              onPanelClosed: () {
                setState(() {
                  isCollapsed = true;
                });
              },
              onPanelOpened: () {
                setState(() {
                  isCollapsed = false;
                });
              },
              maxHeight: h * 0.4,
              minHeight: h * 0.09,
              parallaxEnabled: true,
              parallaxOffset: .5,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            ),
          ],
        ),
      ),
    );
  }
}
