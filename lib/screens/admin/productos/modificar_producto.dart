import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:searchfield/searchfield.dart';
import 'package:sirena_de_sal/constants.dart';

import '../../../clases/producto.dart';
import '../../../recordatorios/recordatorios.dart';

class ModificaProducto extends StatefulWidget {
  final Producto productoModificar;
  final List<SearchFieldListItem> list;

  const ModificaProducto(
      {Key? key, required this.productoModificar, required this.list})
      : super(key: key);

  @override
  _ModificaProductoState createState() => _ModificaProductoState();
}

class _ModificaProductoState extends State<ModificaProducto> {
  final key = GlobalKey<FormState>();
  Suggestion suggestionState = Suggestion.expand;
  final searchKey = UniqueKey();
  String descripcion = "";
  double precio = 0;
  String nombre = "";
  String material = "";
  TextEditingController categoria = TextEditingController();
  String categoriaFinal = "categ";
  int tamanioArreglo = 0;
  int currentStep = 0;
  bool subiendo = false;
  int seHanSubido = 0;
  List<String> urls = [];
  List<XFile> sampleImage = [];
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Modificar producto"),
        foregroundColor: color3,
        titleTextStyle: styleLetrasAppBar,
        backgroundColor: color2,
      ),
      body: subiendo
          ? cargando()
          : ListView(
              children: [
                const recordatorio(
                    recordatorio_texto:
                        "Para modificar, modifica los campos del producto o elimina un imagen y pulsa guardar cambios.Si eliminas una foto no podras recuperarla"),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 15),
                  child: GestureDetector(
                    onTap: () {
                      //getImage();
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
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 15),
                  child: SizedBox(
                      height: 170,
                      child: widget.productoModificar.imagenes.isEmpty
                          ? sampleImage.isEmpty
                              ? Container()
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: sampleImage.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 5),
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
                                                  if (sampleImage.length == 1) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(snack(
                                                            "Necesitas dejar una imagen"));
                                                    setState(() {
                                                      sampleImage
                                                          .removeAt(index);
                                                    });
                                                    getImage();
                                                  } else {
                                                    setState(() {
                                                      widget.productoModificar
                                                          .imagenes
                                                          .removeAt(index);
                                                    });
                                                  }
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
                                  })
                          : ListView.builder(
                              itemCount:
                                  widget.productoModificar.imagenes.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, right: 5),
                                  child: Stack(
                                    children: [
                                      Image.network(widget
                                          .productoModificar.imagenes[index]),
                                      Positioned(
                                        child: Container(
                                          height: 45,
                                          width: 45,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: Colors.black),
                                          child: IconButton(
                                            onPressed: () async {
                                              if (widget.productoModificar
                                                      .imagenes.length ==
                                                  1) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snack(
                                                        "Necesitas dejar una imagen"));
                                                getImage();
                                                await FirebaseStorage.instance
                                                    .refFromURL(widget
                                                        .productoModificar
                                                        .imagenes[index])
                                                    .delete();
                                                setState(() {
                                                  widget.productoModificar
                                                      .imagenes
                                                      .removeAt(index);
                                                });
                                              } else {
                                                await FirebaseStorage.instance
                                                    .refFromURL(widget
                                                        .productoModificar
                                                        .imagenes[index])
                                                    .delete();
                                                setState(() {
                                                  widget.productoModificar
                                                      .imagenes
                                                      .removeAt(index);
                                                });
                                              }
                                            },
                                            iconSize: 25,
                                            icon: const Icon(Icons.close),
                                            color: color3,
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
                          initialValue: widget.productoModificar.descripcion,
                          decoration:
                              const InputDecoration(labelText: "Descripcion"),
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
                              key: searchKey,
                              hasOverlay: false,
                              suggestionState: suggestionState,
                              initialValue: widget.list.any((element) {
                                return element.item ==
                                    widget.productoModificar.categoria;
                              })
                                  ? SearchFieldListItem(
                                      widget.productoModificar.categoria)
                                  : null,
                              searchInputDecoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.8),
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                              hint: 'Elegir categoria',
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
                          initialValue:
                              widget.productoModificar.precio.toString(),
                          decoration:
                              const InputDecoration(labelText: "Precio"),
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
                          initialValue: widget.productoModificar.nombre,
                          decoration:
                              const InputDecoration(labelText: "Nombre"),
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
                          initialValue: widget.productoModificar.material,
                          decoration:
                              const InputDecoration(labelText: "Material"),
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
                              child: const Text("Guardar cambios")),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  List<Step> getSteps() => [
        Step(
            isActive: currentStep >= 0,
            title: const Text("Subiendo imagenes..."),
            content: Text(
                "Espera un momento...Se han subido $seHanSubido de las ${sampleImage.length} imagenes seleccionadas ")),
        Step(
            isActive: currentStep >= 1,
            title: const Text("Tus imagenes se han subido"),
            content:
                const Text("Presiona continuar para actualizar el producto")),
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
            onStepContinue: () async {
              final isBeforeLast = currentStep == getSteps().length - 2;
              final isLast = currentStep == getSteps().length - 1;
              if (isBeforeLast) {
                urls.addAll(widget.productoModificar.imagenes);
                try {
                  await widget.productoModificar.referencia
                      .set({
                        'categoria': categoriaFinal,
                        'descripcion': descripcion,
                        'imagenes': urls,
                        'material': material,
                        'nombre': nombre,
                        'precio': precio
                      }, SetOptions(merge: true))
                      .whenComplete(() => ScaffoldMessenger.of(this.context)
                          .showSnackBar(snack("Editado con exito")))
                      .whenComplete(() => Navigator.of(this.context).pop());
                } catch (e, s) {}
              } else if (isLast) {
              } else {
                setState(() {
                  currentStep++;
                });
              }
            },
            steps: getSteps()));
  }

  void uploadFunction() async {
    if (validateForm()) {
      if (mounted) {
        setState(() {
          categoriaFinal = categoria.text;
          subiendo = true;
        });
      }
      if (sampleImage.length == 0) {
        setState(() {
          currentStep++;
        });
      }

      for (int i = 0; i < sampleImage.length; i++) {
        String urlImagen = await upload(sampleImage[i]);
        urls.add(urlImagen);
      }
    }
  }

  Future<String> upload(XFile imagen) async {
    final String nombre = basename(imagen.path);
    final destination = "Productos/${nombre}";
    Reference referencia = FirebaseStorage.instance.ref(destination);
    UploadTask task = referencia.putFile(File(imagen.path));
    await task.whenComplete(() {
      setState(() {
        seHanSubido++;
        if (seHanSubido == sampleImage.length) {
          currentStep++;
        }
      });
    });

    return await referencia.getDownloadURL();
  }

  Future getImage() async {
    final List<XFile>? sampleImage2 = await ImagePicker().pickMultiImage();

    setState(() {
      sampleImage.addAll(sampleImage2!);
      tamanioArreglo = sampleImage.length;
    });
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

  SnackBar snack(String texto) {
    return SnackBar(
        backgroundColor: Colors.green,
        content: Row(
          children: [
            const Icon(
              Icons.thumb_up,
              color: Colors.white,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(texto),
          ],
        ));
  }
}
