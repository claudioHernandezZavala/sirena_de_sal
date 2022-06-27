import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:searchfield/searchfield.dart';
import 'package:sirena_de_sal/constants.dart';
import 'package:sirena_de_sal/screens/admin/panel_general.dart';

class Agregar_producto extends StatefulWidget {
  final List<SearchFieldListItem> list;
  const Agregar_producto({Key? key, required this.list}) : super(key: key);

  @override
  State<Agregar_producto> createState() => _Agregar_productoState();
}

class _Agregar_productoState extends State<Agregar_producto> {
  List<XFile> sampleImage = [];
  int currentStep = 0;
  Map<String, String> imagenes = {};
  bool selecciono = false;
  int tamanioArreglo = 0;
  final key = GlobalKey<FormState>();
  String descripcion = "";
  double precio = 0;
  String nombre = "";
  String material = "";
  TextEditingController categoria = TextEditingController();
  List<String> urls = [];
  List<String> categoriasElegir = [];
  bool isUploading = false;
  int sehanSubido = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agregar producto"),
        foregroundColor: color3,
        backgroundColor: color2,
        titleTextStyle: styleLetrasAppBar,
      ),
      body: isUploading
          ? cargando()
          : ListView(
              scrollDirection: Axis.vertical,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15, left: 15),
                      child: GestureDetector(
                        onTap: () {
                          getImage();
                        },
                        child: Container(
                          width: 120,
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: color3),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.add_a_photo),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text("Agregar nueva imagen"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 15),
                  child: SizedBox(
                      height: 170,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: sampleImage.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 5),
                              child: Stack(
                                children: [
                                  Image.file(
                                    File(sampleImage[index].path),
                                    height: 200,
                                    width: 150,
                                  ),
                                  Positioned(
                                    child: Container(
                                      height: 45,
                                      width: 45,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: Colors.black),
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            sampleImage.removeAt(index);

                                            tamanioArreglo = sampleImage.length;
                                            if (tamanioArreglo == 0) {}
                                          });
                                        },
                                        iconSize: 25,
                                        icon: const Icon(Icons.close),
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          })),
                ),
                Form(
                  key: key,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          minLines: 6,
                          maxLines: null,
                          decoration: InputDecoration(
                              labelText: "Descripcion",
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
                          validator: (value) {
                            return value!.isEmpty
                                ? "Una descripcion es requerida"
                                : null;
                          },
                          onSaved: (value) {
                            descripcion = value!;
                          },
                          keyboardType: TextInputType.multiline,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SearchField(
                              searchInputDecoration:
                                  InputStyle("Presionar para elegir categoria"),
                              validator: (value) {
                                return value!.isEmpty
                                    ? "Una categoria es requerida"
                                    : null;
                              },
                              controller: categoria,
                              suggestions: widget.list)),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          decoration: InputStyle("Precio"),
                          validator: (value) {
                            return value!.isEmpty
                                ? "Un precio es requerido"
                                : null;
                          },
                          onSaved: (value) {
                            precio = double.parse(value!);
                          },
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          decoration: InputStyle("Nombre"),
                          validator: (value) {
                            return value!.isEmpty
                                ? "Un nombre es requerido"
                                : null;
                          },
                          onSaved: (value) {
                            nombre = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          decoration: InputStyle("Material"),
                          validator: (value) {
                            return value!.isEmpty
                                ? "Un material es requerido"
                                : null;
                          },
                          onSaved: (value) {
                            material = value!;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: color3),
                          child: FlatButton(
                              onPressed: () async {
                                uploadFunction();
                              },
                              child: const Text("Subir nuevo producto")),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  List<Step> getSetps() => [
        Step(
            isActive: currentStep >= 0,
            title: const Text("Subiendo imagenes..."),
            content: Text(
                "Espera un momento...Se han subido ${sehanSubido} de las ${sampleImage.length} imagenes seleccionadas ")),
        Step(
            isActive: currentStep >= 1,
            title: const Text("Tus imagenes se han subido"),
            content: const Text("Presiona continuar para subir el producto")),
        Step(
            isActive: currentStep >= 2,
            title: const Text("Producto subido con exito!"),
            content: const Text("Presiona continuar para volver al panel")),
      ];

  Widget cargando() {
    return Center(
        child: Stepper(
            currentStep: currentStep,
            onStepTapped: (index) {
              setState(() {
                currentStep = index;
              });
            },
            onStepContinue: () {
              final isBeforeLast = currentStep == getSetps().length - 2;
              final isLast = currentStep == getSetps().length - 1;
              if (isBeforeLast) {
                subiraDatabase();
              } else if (isLast) {
                Navigator.of(this.context).pop(MaterialPageRoute(
                    builder: (context) => const PanelGeneral()));
              } else {
                setState(() {
                  currentStep++;
                });
              }
            },
            steps: getSetps()));
  }

  Future getImage() async {
    final List<XFile>? sampleImage2 = await ImagePicker().pickMultiImage();

    if (sampleImage2!.isNotEmpty) {
      selecciono = true;
    }
    setState(() {
      this.sampleImage.addAll(sampleImage2);
      tamanioArreglo = this.sampleImage.length;
    });
  }

  void subiraDatabase() async {
    CollectionReference referenciaBase =
        FirebaseFirestore.instance.collection("productos/");

    String categoriaSubir = categoria.text;
    var data = {
      "imagenes": urls,
      "descripcion": descripcion,
      "precio": precio,
      "nombre": nombre,
      "material": material,
      "categoria": categoriaSubir
    };
    await referenciaBase.add(data).whenComplete(() {
      setState(() {
        currentStep++;
      });
    });
  }

  void uploadFunction() async {
    if (validateForm()) {
      setState(() {
        isUploading = true;
      });
      for (int i = 0; i < sampleImage.length; i++) {
        String urlImagen = await upload(sampleImage[i]);
        urls.add(urlImagen);
      }
    }
  }

  Future<String> upload(XFile imagen) async {
    final String nombre = basename(imagen.path);
    final destination = "Productos/${nombre}";
    Reference referencia = await FirebaseStorage.instance.ref(destination);
    UploadTask task = referencia.putFile(File(imagen.path));
    await task.whenComplete(() {
      setState(() {
        sehanSubido++;
        if (sehanSubido == sampleImage.length) {
          currentStep++;
        }
      });
    });

    return await referencia.getDownloadURL();
  }

  bool validateForm() {
    final form = key.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
