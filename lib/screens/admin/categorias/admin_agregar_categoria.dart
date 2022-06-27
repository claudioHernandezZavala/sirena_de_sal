import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:sirena_de_sal/constants.dart';
import 'package:sirena_de_sal/screens/homepage.dart';

import '../../../recordatorios/recordatorios.dart';

class AdminAgregarCategoria extends StatefulWidget {
  const AdminAgregarCategoria({Key? key}) : super(key: key);

  @override
  _AdminAgregarCategoriaState createState() => _AdminAgregarCategoriaState();
}

class _AdminAgregarCategoriaState extends State<AdminAgregarCategoria> {
  File? sampleImage;
  final key = GlobalKey<FormState>();
  String categoriaNueva = "";
  String url = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: sampleImage == null
          ? const Center(
              child: recordatorio(
              recordatorio_texto:
                  "Presione el boton y\nescoga una imagen\npara la nueva categoria",
            ))
          : enableUpload(),
      floatingActionButton: sampleImage != null
          ? null
          : FloatingActionButton(
              onPressed: () {
                getImage();
              },
              backgroundColor: color3,
              child: const Icon(Icons.add_a_photo),
            ),
    );
  }

  Future getImage() async {
    final sampleImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    final temp1 = sampleImage!.path;
    setState(() {
      this.sampleImage = File(temp1);
    });
  }

  Widget enableUpload() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: Form(
          key: key,
          child: Column(
            children: [
              Image.file(
                sampleImage!,
                height: 200,
                width: 400,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  decoration:
                      const InputDecoration(labelText: "Nombre de categoría"),
                  validator: (value) {
                    return value!.isEmpty
                        ? "El nombre de la categoria es requerida"
                        : null;
                  },
                  onSaved: (value) {
                    categoriaNueva = value!;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 1),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16), color: color3),
                  child: TextButton(
                      onPressed: () {
                        upload();
                      },
                      child: Text(
                        "Subir nueva categoria",
                        style: estiloLetras20,
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void subiraDatabase() async {
    var data = {"imagen": url, "categoria": categoriaNueva};
    FirebaseFirestore.instance.collection("categorias/").add(data);
    Fluttertoast.showToast(
        msg: "Categoria subida con exito",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.black,
        fontSize: 16.0);

    Navigator.of(this.context)
        .push(MaterialPageRoute(builder: (context) => const HomePage()));
  }

  void upload() async {
    if (validateForm()) {
      final String nombre = basename(sampleImage!.path);
      final destination = "imagenesCategorias/$nombre";
      final referencia = FirebaseStorage.instance.ref(destination);
      UploadTask task = referencia.putFile(sampleImage!);
      final snap = await task.whenComplete(() {});
      final urldownload = await snap.ref.getDownloadURL();
      url = urldownload;
      subiraDatabase();
    }
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
