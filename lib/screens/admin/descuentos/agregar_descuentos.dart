import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sirena_de_sal/screens/admin/descuentos/panel_descuentos.dart';

import '../../../constants.dart';
import '../../../widgets/card_descuento.dart';

class AgregarDescuento extends StatefulWidget {
  const AgregarDescuento({Key? key}) : super(key: key);

  @override
  _AgregarDescuentoState createState() => _AgregarDescuentoState();
}

class _AgregarDescuentoState extends State<AgregarDescuento> {
  final key = GlobalKey<FormState>();
  Color cardColor = Colors.white;
  Color numberColor = Colors.black;
  Color letterColor = Colors.black;
  String descripcion = "";
  int porcentaje = 0;
  String codigoDescuento = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1,
      appBar: AppBar(
        title: const Text("Agregar descuentos"),
        centerTitle: true,
        backgroundColor: color2,
        foregroundColor: color3,
        titleTextStyle: styleLetrasAppBar,
      ),
      body: ListView(
        children: [
          Form(
            key: key,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Descripcion del descuento",
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2),
                      ),
                      labelStyle:
                          const TextStyle(color: Colors.white, fontSize: 20),
                      floatingLabelStyle: const TextStyle(
                          color: Colors.black,
                          backgroundColor: Colors.transparent,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                      fillColor: color3.withOpacity(0.8),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    validator: (value) {
                      return value!.isEmpty
                          ? "Una descripcion es requerida"
                          : null;
                    },
                    onChanged: (value) {
                      setState(() {
                        descripcion = value;
                      });
                    },
                    onSaved: (value) {
                      descripcion = value!;
                    },
                    minLines: 6,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Porcentaje del descuento(solo el numero)",
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2),
                      ),
                      labelStyle:
                          const TextStyle(color: Colors.white, fontSize: 18),
                      floatingLabelStyle: TextStyle(
                          color: Colors.black,
                          backgroundColor: color2,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      fillColor: color3,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    validator: (value) {
                      return value!.isEmpty
                          ? "Un porcentaje es requerido"
                          : null;
                    },
                    onChanged: (value) {
                      print(value);

                      setState(() {
                        if (value.isNotEmpty) {
                          porcentaje = int.parse(value);
                        }
                      });
                    },
                    onSaved: (value) {
                      porcentaje = int.parse(value!);
                    },
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Codigo para activar el descuento",
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2),
                      ),
                      labelStyle:
                          const TextStyle(color: Colors.white, fontSize: 18),
                      floatingLabelStyle: TextStyle(
                          color: Colors.black,
                          backgroundColor: color2,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      fillColor: color3,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    validator: (value) {
                      return value!.isEmpty ? "Un codigo es requerido" : null;
                    },
                    onChanged: (value) {
                      setState(() {
                        codigoDescuento = value;
                      });
                    },
                    onSaved: (value) {
                      codigoDescuento = value!;
                    },
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Text(
                    "Elige el color de la tarjeta",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Card(
                  color: color3,
                  margin: const EdgeInsets.all(45),
                  elevation: 25,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  shadowColor: cardColor,
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: ColorPicker(
                      pickerColor: cardColor,
                      onColorChanged: (color) => setState(() {
                        cardColor = color;
                      }),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Text(
                    "Elige el color del numero",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Card(
                  color: color3,
                  margin: const EdgeInsets.all(45),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 25,
                  shadowColor: numberColor,
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: ColorPicker(
                      pickerColor: numberColor,
                      onColorChanged: (color) => setState(() {
                        numberColor = color;
                      }),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Text(
                    "Elige el color del texto",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Card(
                  color: color3,
                  margin: const EdgeInsets.all(45),
                  elevation: 25,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  shadowColor: letterColor,
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: ColorPicker(
                      pickerColor: letterColor,
                      onColorChanged: (color) => setState(() {
                        letterColor = color;
                      }),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "Previsualizacion de descuento",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: CardDescuento(
              descripcion: descripcion,
              color1: cardColor,
              color2: numberColor,
              porcentaje: porcentaje,
              color3: letterColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: TextButton.icon(
                onPressed: () {
                  CollectionReference referenciaBase =
                      FirebaseFirestore.instance.collection("Descuentos/");
                  if (key.currentState!.validate()) {
                    referenciaBase.add({
                      "Descripcion": descripcion,
                      "Porcentaje": porcentaje,
                      "Clave": codigoDescuento,
                      "Color1": cardColor.value,
                      "Color2": numberColor.value,
                      "Color3": letterColor.value
                    }).whenComplete(() {
                      Fluttertoast.showToast(
                          msg: "Descuento subido con exito",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.black,
                          fontSize: 16.0);

                      Navigator.of(this.context).pop(MaterialPageRoute(
                          builder: (context) => const PanelDescuentos()));
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Campos sin llenar"),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(color3),
                  overlayColor:
                      MaterialStateProperty.all(Colors.red.withOpacity(0.2)),
                  elevation: MaterialStateProperty.all<double>(10),
                  shadowColor: MaterialStateProperty.all<Color>(
                      Colors.deepPurple.withOpacity(0.6)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                icon: const Icon(
                  Icons.cloud_upload,
                  color: Colors.black,
                ),
                label: const Text(
                  "Subir Nuevo descuento",
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
