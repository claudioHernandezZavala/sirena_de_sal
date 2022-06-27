import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:searchfield/searchfield.dart';
import 'package:sirena_de_sal/bounciPageRoute.dart';
import 'package:sirena_de_sal/clases/producto.dart';

import '../clases/ItemCarrito.dart';
import '../clases/categoria.dart';
import '../clases/descuentos.dart';
import '../clases/pedido.dart';
import '../screens/intros/intro.dart';
import '../usuario/infoUsuario.dart';

obtainProducts(AsyncSnapshot<QuerySnapshot> snapshot) {
  return snapshot.data!.docs.map((DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    return Producto(
        data["imagenes"].cast<String>(),
        data['nombre'],
        data['descripcion'],
        data['precio'],
        data['material'],
        data['categoria'],
        documentSnapshot.reference);
  }).toList();
}

obtenerCategorias(AsyncSnapshot<QuerySnapshot> snapshot) {
  return snapshot.data!.docs.map((DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    return Categoria(data['imagen'], data['categoria'], document.reference);
  }).toList();
}

obtenerDescuentos(AsyncSnapshot<QuerySnapshot> snapshot) {
  return snapshot.data!.docs.map((DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    return Descuento(
        data["Descripcion"],
        data["Clave"],
        data["Porcentaje"],
        Color(data["Color1"]),
        Color(data["Color2"]),
        Color(data["Color3"]),
        document.reference);
  }).toList();
}

obtenerItemCarrito(AsyncSnapshot<QuerySnapshot> snapshot) {
  return snapshot.data!.docs.map((DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    return ItemsCarrito(data['ProductRef'], data["cantidad"],
        document.reference, data['nombre'], data['precio'], data['imagen']);
  }).toList();
}

Future<justGeneralInfo> getInfoForPedido() async {
  User? user = FirebaseAuth.instance.currentUser;
  DocumentReference reference =
      FirebaseFirestore.instance.collection("usuarios/").doc(user!.uid);
  justGeneralInfo info = justGeneralInfo(
    'aaaaaa',
    '',
    0,
    '',
    '',
  );
  await reference.get().then((DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;

      info = justGeneralInfo(data['Nombre'], snapshot.get('Direccion'),
          snapshot.get('Numero'), snapshot.get('RTN'), snapshot.get('token'));
    }
  });
  return info;
}

obtenerPedidos(AsyncSnapshot<QuerySnapshot> snapshot) {
  return snapshot.data!.docs.map((DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    return pedido.fromJson(data, document.reference);
  }).toList();
}

void subirCarrito(Producto producto, int cantidad) {
  User? usuario = FirebaseAuth.instance.currentUser;
  if (usuario != null) {
    var referencia1 = FirebaseFirestore.instance.collection(
        "carritos/${usuario.uid}/carrito/"); //esta referencia la uso para agregar el producto
    var referencia2 = FirebaseFirestore
        .instance //esta referencia la uso para verificar si existe o no
        .collection("carritos/${usuario.uid}/carrito")
        .where('ProductRef', isEqualTo: producto.referencia);
    var dataAgregar = {
      //data para agregar
      'ProductRef': producto.referencia,
      'cantidad': cantidad,
      'nombre': producto.nombre,
      'precio': producto.precio,
      'imagen': producto.imagenes[0]
    };
    referencia2.get().then((QuerySnapshot querySnapshot) async {
      if (querySnapshot.size == 0) {
        // si no existe lo agrego al carrito
        await referencia1.add(dataAgregar).whenComplete(() {
          Fluttertoast.showToast(
              msg: "Se ha agregado al carrito",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.black,
              fontSize: 16.0);
        });
      } else {
        //si existe llamo la funcion add para agregar al carrito
        Fluttertoast.showToast(
            msg: "Este producto ya esta en tu carrito",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.yellow,
            textColor: Colors.black,
            fontSize: 16.0);
      }
    });
  } else {
    Fluttertoast.showToast(
        msg: "Se debe iniciar sesion",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.black,
        fontSize: 16.0);
  }
}

void registro(BuildContext context) async {
  User? usuarioNuevo = FirebaseAuth.instance.currentUser;

  if (usuarioNuevo != null) {
    await FirebaseMessaging.instance.getToken().then((value) {
      CollectionReference referenciaUsuarios =
          FirebaseFirestore.instance.collection("usuarios/");
      referenciaUsuarios.doc(usuarioNuevo.uid).set({
        'Nombre': '',
        'Direccion': '',
        'Numero': 0,
        'RTN': "",
        'Ubicacion': "null",
        'uid': usuarioNuevo.uid,
        'token': value,
        "favorites": [],
        "suscrito": false
      }).whenComplete(() {
        //  usuarioActual = usuarioNuevo;
        Navigator.of(context)
            .pushAndRemoveUntil(BouncyPageRoute(Onboard()), (route) => false);
      });
    });
  }
}

Future<infoUser> getInfo() async {
  User? user = FirebaseAuth.instance.currentUser;
  DocumentReference reference =
      FirebaseFirestore.instance.collection("usuarios/").doc(user!.uid);
  infoUser info =
      infoUser('aaaaaa', " ", 0, '', '', reference, [reference], false);
  await reference.get().then((DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;

      info = infoUser(
          data['Nombre'],
          snapshot.get('Direccion') as String,
          snapshot.get('Numero'),
          snapshot.get('RTN'),
          snapshot.get('Ubicacion'),
          reference,
          snapshot.get('favorites').cast<DocumentReference>(),
          snapshot.get("suscrito") as bool);
    }
  });
  return info;
}

Future<List<SearchFieldListItem>> crearLista() async {
  List<SearchFieldListItem> lista = [];

  List<String> categoriasTexto = [];
  await FirebaseFirestore.instance
      .collection('categorias/')
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      categoriasTexto.add(doc["categoria"]);
    });
  }).whenComplete(() {
    for (var element in categoriasTexto) {
      lista.add(SearchFieldListItem(element, item: element));
    }
  });
  return lista;
}

void sendPushMessage(String nombre, String token) async {
  try {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAARjWKubk:APA91bHDVmPH_t2YD9N7Dow5IjbKPNRtYp0x3U-jbmcH-1w1tvjLDi1BD9rmwXJ0SHltzYAqpYsD6XOhbOsq8foQVc3oCy73FLZIQnZvDAPknUDQlY_QfMoW_2LIa2lL26V-niRCBfTA',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'Tu pedido esta listo!',
            'title': 'Hola, ${nombre}'
          },
          'priority': 'normal',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          "to": token,
        },
      ),
    );
  } catch (e) {
    print(e);
  }
}

void sendNotification(String texto, titulo) async {
  try {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAARjWKubk:APA91bHDVmPH_t2YD9N7Dow5IjbKPNRtYp0x3U-jbmcH-1w1tvjLDi1BD9rmwXJ0SHltzYAqpYsD6XOhbOsq8foQVc3oCy73FLZIQnZvDAPknUDQlY_QfMoW_2LIa2lL26V-niRCBfTA',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': texto,
            'title': '${titulo}'
          },
          'priority': 'normal',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          "to": "/topics/NewDrop",
        },
      ),
    );
  } catch (e) {
    print(e);
  }
}

getFavorites() async {
  List<Producto> favsMostrar = [];
  var ref = FirebaseFirestore.instance
      .collection("usuarios/")
      .doc(FirebaseAuth.instance.currentUser?.uid);
  List<DocumentReference> refs = [];
  var ds = await ref.get();
  Map<String, dynamic> data = ds.data() as Map<String, dynamic>;

  refs = data["favorites"].cast<DocumentReference>();
  for (var element in refs) {
    await element.get().then((prod) {
      favsMostrar.add(Producto(
          prod["imagenes"].cast<String>(),
          prod["nombre"],
          prod["descripcion"],
          prod["precio"],
          prod["material"],
          prod["categoria"],
          prod.reference));
    });
  }

  return favsMostrar;
}

getFavorites2(AsyncSnapshot<DocumentSnapshot> snap) async {
  List<Producto> favsMostrar = [];
  var ref = FirebaseFirestore.instance
      .collection("usuarios/")
      .doc(FirebaseAuth.instance.currentUser?.uid);
  List<DocumentReference> refs = [];
  Map<String, dynamic> data = snap.data?.data() as Map<String, dynamic>;

  refs = data["favorites"].cast<DocumentReference>();

  await refs[0].get().then((prod) {
    favsMostrar.add(Producto(
        prod["imagenes"].cast<String>(),
        prod["nombre"],
        prod["descripcion"],
        prod["precio"],
        prod["material"],
        prod["categoria"],
        prod.reference));
  });
  return favsMostrar;
}
