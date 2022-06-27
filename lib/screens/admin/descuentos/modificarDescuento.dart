import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../../clases/descuentos.dart';
import '../../../constants.dart';
import '../../../widgets/card_descuento.dart';

class ModificarDescuento extends StatefulWidget {
  final Descuento descuentoModificar;
  const ModificarDescuento({Key? key, required this.descuentoModificar})
      : super(key: key);

  @override
  _ModificarDescuentoState createState() => _ModificarDescuentoState();
}

class _ModificarDescuentoState extends State<ModificarDescuento> {
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
        title: const Text("Modificar Descuento"),
        centerTitle: true,
        backgroundColor: color2,
        titleTextStyle: styleLetrasAppBar,
        foregroundColor: color3,
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
                    initialValue: widget.descuentoModificar.descripcion,
                    minLines: 6,
                    maxLines: null,
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
                        widget.descuentoModificar.descripcion = value;

                        //descripcion = value;
                      });
                    },
                    onSaved: (value) {
                      widget.descuentoModificar.descripcion = value!;

                      descripcion = value;
                    },
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
                  child: TextFormField(
                    initialValue:
                        widget.descuentoModificar.porcentaje.toString(),
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
                    onSaved: (value) {
                      widget.descuentoModificar.porcentaje = int.parse(value!);

                      porcentaje = int.parse(value);
                    },
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
                  child: TextFormField(
                    initialValue: widget.descuentoModificar.codigo,
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
                        widget.descuentoModificar.codigo = value;
                        //  codigoDescuento = value;
                      });
                    },
                    onSaved: (value) {
                      widget.descuentoModificar.codigo = value!;

                      codigoDescuento = value;
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
                      pickerColor: widget.descuentoModificar.color1,
                      onColorChanged: (color) => setState(() {
                        cardColor = color;
                        widget.descuentoModificar.color1 = color;
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
                      pickerColor: widget.descuentoModificar.color2,
                      onColorChanged: (color) => setState(() {
                        widget.descuentoModificar.color2 = color;
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
                      pickerColor: widget.descuentoModificar.color3,
                      onColorChanged: (color) => setState(() {
                        widget.descuentoModificar.color3 = color;
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
                /*
                const Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Text(
                    "Elige el primer color",
                  ),
                ),

                Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Card(
                      elevation: 25,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      shadowColor: color1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: ColorPicker(
                          pickerColor: widget.descuentoModificar.color1,
                          onColorChanged: (color) => setState(() {
                            widget.descuentoModificar.color1 = color;
                          }),
                        ),
                      ),
                    )),
                const Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Text(
                    "Elige el segundo color",
                  ),
                ),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 25,
                      shadowColor: color2,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: ColorPicker(
                          pickerColor: widget.descuentoModificar.color2,
                          onColorChanged: (color) => setState(() {
                            widget.descuentoModificar.color2 = color;
                          }),
                        ),
                      ),
                    )),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "Previsualizacion de descuento",
                  ),
                ),
                */
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: CardDescuento(
              descripcion: widget.descuentoModificar.descripcion,
              color1: widget.descuentoModificar.color1,
              color2: widget.descuentoModificar.color2,
              porcentaje: widget.descuentoModificar.porcentaje,
              color3: widget.descuentoModificar.color3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: TextButton.icon(
                onPressed: () {
                  if (validateForm()) {
                    widget.descuentoModificar.reference.set({
                      "Descripcion": descripcion,
                      "Porcentaje": porcentaje,
                      "Clave": codigoDescuento,
                      "Color1": widget.descuentoModificar.color1.value,
                      "Color2": widget.descuentoModificar.color2.value,
                      "Color3:": widget.descuentoModificar.color3.value
                    }, SetOptions(merge: true)).whenComplete(
                        () => Navigator.of(context).pop());
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
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
                  "Modificar Descuento",
                )),
          )
        ],
      ),
    );
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
