import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sirena_de_sal/funciones/funciones_firebase.dart';
import 'package:sirena_de_sal/widgets/noUser.dart';

import '../../constants.dart';
import '../usuario/infoUsuario.dart';

class Perfil extends StatefulWidget {
  const Perfil({Key? key}) : super(key: key);

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  String nombre = "";
  String direccion = "", ubicacion = "";
  String rtn = "";
  bool suscrito = false;
  int numero = 0;
  late infoUser info;
  final formkey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (mounted) {
        if (user == null) {
          setState(() {});
        } else {}
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
            appBar: AppBar(
              backgroundColor: color2,
              title: const Text("Mi perfil"),
              titleTextStyle: styleLetrasAppBar,
              centerTitle: true,
            ),
            body: FutureBuilder(
                future: getInfo(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: color3,
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    info = snapshot.data as infoUser;
                  }
                  return SingleChildScrollView(
                    child: Form(
                      key: formkey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15, left: 10, right: 10),
                            child: Text(
                                "Esta informacion solo se utilizara para hacer tus pedidos",
                                style: estiloLetras18),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: TextFormField(
                              initialValue:
                                  info.nombre.isNotEmpty ? info.nombre : null,
                              validator: (value) {
                                return value!.isEmpty
                                    ? "Nombre es requerido"
                                    : null;
                              },
                              onSaved: (value) {
                                nombre = value!;
                              },
                              decoration: InputDecoration(
                                  hintText: 'Nombre',
                                  labelText: 'Nombre',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  prefixIcon: const Icon(Icons.text_fields),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 2),
                                  ),
                                  labelStyle: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                  floatingLabelStyle: const TextStyle(
                                      color: Colors.black,
                                      backgroundColor: Colors.transparent,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                  fillColor: color3.withOpacity(0.8),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: TextFormField(
                              minLines: 6,
                              maxLines: null,
                              initialValue: info.direccion.isNotEmpty
                                  ? info.direccion[0]
                                  : null,
                              onSaved: (value) {
                                direccion = value!;
                              },
                              decoration: InputDecoration(
                                  hintText: 'Direccion',
                                  labelText: 'Direccion',
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 2),
                                  ),
                                  labelStyle: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                  floatingLabelStyle: const TextStyle(
                                      color: Colors.black,
                                      backgroundColor: Colors.transparent,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                  fillColor: color3.withOpacity(0.8),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: TextFormField(
                              initialValue: info.numero.toString().isNotEmpty
                                  ? info.numero.toString()
                                  : null,
                              validator: (value) {
                                return value!.isEmpty
                                    ? "Numero es requerido"
                                    : null;
                              },
                              onSaved: (value) {
                                if (value != null) {
                                  if (value.isEmpty) {
                                    numero = 0;
                                  } else {
                                    numero = int.parse(value);
                                  }
                                }
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: 'Numero',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: 'Numero',
                                  prefixIcon: const Icon(Icons.numbers),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 2),
                                  ),
                                  labelStyle: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                  floatingLabelStyle: const TextStyle(
                                      color: Colors.black,
                                      backgroundColor: Colors.transparent,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                  fillColor: color3.withOpacity(0.8),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: TextFormField(
                              initialValue:
                                  info.rtn.isNotEmpty ? info.rtn : null,
                              onSaved: (value) {
                                if (value != null) {
                                  if (value.isEmpty) {
                                    rtn = "";
                                  } else {
                                    rtn = value;
                                  }
                                }
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputStyle('RTN'),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Recibir actualizaciones",
                                style: estiloLetras18,
                              ),
                              Switch(
                                  value: info.suscrito,
                                  activeColor: Colors.green,
                                  onChanged: (bool value) {
                                    if (value == false) {
                                      FirebaseMessaging.instance
                                          .unsubscribeFromTopic("NewDrop");
                                      info.referencia
                                          .update({"suscrito": value});
                                      setState(() {
                                        info.suscrito = value;
                                      });
                                    } else {
                                      FirebaseMessaging.instance
                                          .subscribeToTopic("NewDrop");

                                      info.referencia
                                          .update({"suscrito": value});
                                      setState(() {
                                        info.suscrito = value;
                                      });
                                    }

                                    setState(() {
                                      // v = value;
                                    });
                                  }),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          TextButton(
                            onPressed: () {
                              if (validateForm()) {
                                info.referencia.set({
                                  'Nombre': nombre,
                                  'Direccion': direccion,
                                  'Numero': numero,
                                  'RTN': rtn,
                                }, SetOptions(merge: true)).whenComplete(() =>
                                    Fluttertoast.showToast(
                                        msg: "Cambios guardados",
                                        backgroundColor: Colors.green));
                                FirebaseAuth.instance.currentUser
                                    ?.updateDisplayName(nombre);
                              }
                            },
                            style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all<Size>(
                                    const Size(325, 45)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(color3),
                                shadowColor: MaterialStateProperty.all<Color>(
                                    Colors.deepPurple.withOpacity(0.6)),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)))),
                            child: const Text("Guardar cambios"),
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          ListTile(
                            onTap: () {
                              FirebaseAuth.instance.signOut();
                            },
                            title: Center(
                                child: Text(
                              "Sign out",
                              style: estiloLetras22,
                            )),
                            tileColor: color3,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          );
  }

  bool validateForm() {
    final form = formkey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
