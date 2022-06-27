import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirena_de_sal/clases/producto.dart';
import 'package:sirena_de_sal/funciones/funciones_firebase.dart';
import 'package:sirena_de_sal/screens/detailScreen.dart';

import '../animaciones/heartAnimation.dart';
import '../constants.dart';

class AllProductWidget extends StatefulWidget {
  final Producto producto;
  const AllProductWidget({Key? key, required this.producto}) : super(key: key);

  @override
  State<AllProductWidget> createState() => _AllProductWidgetState();
}

class _AllProductWidgetState extends State<AllProductWidget> {
  bool isLiked = false;
  bool isAnimating = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseFirestore.instance
          .collection("usuarios/")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .snapshots(includeMetadataChanges: true)
          .listen((event) {
        favorites = event.data()?["favorites"].cast<DocumentReference>();
      });
      if (favorites.contains(widget.producto.referencia)) {
        if (mounted) {
          setState(() {
            isLiked = true;
          });
        }
      }
      if (mounted) {
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
          if (user == null) {
            setState(() {});
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => DetailScreen(prod: widget.producto)));
          },
          onDoubleTap: () async {
            if (FirebaseAuth.instance.currentUser != null) {
              if (isLiked) {
                if (favorites.remove(widget.producto.referencia)) {
                  await FirebaseFirestore.instance
                      .collection("usuarios/")
                      .doc(FirebaseAuth.instance.currentUser?.uid)
                      .set({"favorites": favorites}, SetOptions(merge: true));
                }
                setState(() {
                  isAnimating = true;
                  isLiked = false;
                });
              } else {
                favorites.add(widget.producto.referencia);
                await FirebaseFirestore.instance
                    .collection("usuarios/")
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .set({"favorites": favorites}, SetOptions(merge: true));
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
          child: Container(
            margin: const EdgeInsets.all(25),
            height: 180,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.producto.imagenes[0],
                  height: 150,
                  width: 150,
                ),
                const SizedBox(
                  width: 25,
                ),
                Expanded(
                    child: Text(
                  widget.producto.nombre,
                  style: GoogleFonts.yuseiMagic(
                      color: color4, fontSize: 19, fontWeight: FontWeight.bold),
                )),
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      subirCarrito(widget.producto, 1);
                    },
                    child: Container(
                      color: color3,
                      width: 50,
                      height: 50,
                      child: const Icon(
                        Icons.shopping_bag_sharp,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Opacity(
          opacity: isAnimating ? 1 : 0,
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(50),
              child: HeartAnimation(
                isAnimating: isAnimating,
                onEnd: () {
                  setState(() {
                    isAnimating = false;
                  });
                },
                child: Icon(
                  Icons.favorite,
                  size: 100,
                  color: color3,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
