import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sirena_de_sal/bounciPageRoute.dart';
import 'package:sirena_de_sal/clases/producto.dart';
import 'package:sirena_de_sal/funciones/funciones_firebase.dart';
import 'package:sirena_de_sal/screens/detailScreen.dart';
import 'package:sirena_de_sal/widgets/noUser.dart';

import '../../constants.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Producto> favoritosP = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseFirestore.instance
        .collection("usuarios/")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .snapshots(includeMetadataChanges: true)
        .listen((event) {
      if (mounted) {
        setState(() {});
      }
    });
    //getFavorites(favorites);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Favoritos"),
          centerTitle: true,
          backgroundColor: color3,
        ),
        body: FirebaseAuth.instance.currentUser == null
            ? NoUserWidget(width: width, heigth: h)
            : FutureBuilder(
                future: getFavorites(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      heightFactor: 450,
                      child: CircularProgressIndicator(
                        color: color3,
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    favoritosP = snapshot.data as List<Producto>;
                  }
                  if (!snapshot.hasData) {
                    return Column(
                      children: [
                        Image.asset("assets/logoSirena.jpg"),
                        const Text("No tienes favoritos aun!")
                      ],
                    );
                  }
                  return favoritosP.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/logoSirena.jpg",
                                width: 90,
                                height: 90,
                              ),
                              Text(
                                "No tienes favoritos aun!",
                                style: estiloLetras20,
                              )
                            ],
                          ),
                        )
                      : GridView.builder(
                          itemCount: favoritosP.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: width * 0.9 / h * 1.5),
                          itemBuilder: (xtx, index) {
                            return FavoriteWidget(producto: favoritosP[index]);
                          },
                        );
                }));
  }
}

class FavoriteWidget extends StatelessWidget {
  final Producto producto;
  const FavoriteWidget({Key? key, required this.producto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(BouncyPageRoute(DetailScreen(
          prod: producto,
        )));
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        width: 320,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () async {
                      if (favorites.remove(producto.referencia)) {
                        await FirebaseFirestore.instance
                            .collection("usuarios/")
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .set({"favorites": favorites},
                                SetOptions(merge: true));
                      }
                    },
                    icon: const Icon(Icons.delete))
              ],
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                    top: 10, bottom: 5, left: 5, right: 5),
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(producto.imagenes[0]),
                )),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(bottom: 25),
                child: Center(
                    child: Text(
                  producto.nombre,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                )))
          ],
        ),
      ),
    );
  }
}
