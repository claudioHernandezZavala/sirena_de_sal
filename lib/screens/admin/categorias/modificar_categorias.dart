import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:sirena_de_sal/constants.dart';

import '../../../clases/categoria.dart';
import '../../../recordatorios/recordatorios.dart';

class ModificarCategoria extends StatefulWidget {
  final Categoria categoriaModificar;
  const ModificarCategoria({Key? key, required this.categoriaModificar})
      : super(key: key);

  @override
  _ModificarCategoriaState createState() => _ModificarCategoriaState();
}

class _ModificarCategoriaState extends State<ModificarCategoria> {
  File? sampleImage;
  final key = GlobalKey<FormState>();
  String categoria = "";
  String url = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Modificar Categoria"),
        titleTextStyle: styleLetrasAppBar,
        foregroundColor: color3,
        backgroundColor: color2,
      ),
      body: ListView(
        children: [
          const recordatorio(
              recordatorio_texto: "Recuerda que debe haber una imagen"),
          Form(
            key: key,
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Stack(
                  children: [
                    Image.network(
                      widget.categoriaModificar.imagen,
                      width: 150,
                      height: 150,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.black),
                      child: IconButton(
                          onPressed: () {
                            FirebaseStorage.instance
                                .refFromURL(widget.categoriaModificar.imagen)
                                .delete();
                            getImage();
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.red,
                          )),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    initialValue: widget.categoriaModificar.categoriaTexto,
                    decoration:
                        const InputDecoration(labelText: "Nombre de categoría"),
                    validator: (value) {
                      return value!.isEmpty
                          ? "El nombre de la categoria es requerida"
                          : null;
                    },
                    onSaved: (value) {
                      categoria = value!;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextButton(
                      onPressed: () async {
                        if (validateForm()) {
                          widget.categoriaModificar.referencia
                              .set({
                                'imagen': widget.categoriaModificar.imagen,
                                'categoria': categoria,
                              }, SetOptions(merge: true))
                              .whenComplete(() =>
                                  ScaffoldMessenger.of(this.context)
                                      .showSnackBar(snack("Editado con exito")))
                              .whenComplete(() => Navigator.pop(this.context));
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blueAccent),
                        overlayColor: MaterialStateProperty.all(
                            Colors.red.withOpacity(0.2)),
                        shadowColor: MaterialStateProperty.all<Color>(
                            Colors.deepPurple.withOpacity(0.6)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                      child: const Text(
                        "Actualizar categoria",
                        style: TextStyle(color: Colors.black),
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future getImage() async {
    final sampleImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    final temp1 = sampleImage!.path;
    setState(() {
      this.sampleImage = File(temp1);
      upload();
    });
  }

  void upload() async {
    final String nombre = basename(sampleImage!.path);
    final destination = "imagenesCategorias/$nombre";
    final referencia = FirebaseStorage.instance.ref(destination);
    UploadTask task = referencia.putFile(sampleImage!);
    final snap = await task.whenComplete(() {});
    final urldownload = await snap.ref.getDownloadURL();
    url = urldownload;
    widget.categoriaModificar.imagen = url;
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
