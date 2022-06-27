import 'package:flutter/material.dart';
import 'package:sirena_de_sal/constants.dart';
import 'package:sirena_de_sal/funciones/funciones_firebase.dart';

class ScreenActualizaciones extends StatefulWidget {
  const ScreenActualizaciones({Key? key}) : super(key: key);

  @override
  State<ScreenActualizaciones> createState() => _ScreenActualizacionesState();
}

class _ScreenActualizacionesState extends State<ScreenActualizaciones> {
  TextEditingController titulo = TextEditingController();
  TextEditingController texto = TextEditingController();
  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anunciar una nueva actualizacion"),
        titleTextStyle: estiloLetras20,
        backgroundColor: color2,
      ),
      body: Form(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(25),
              child: Text(
                "Agrega el texto que quieres que los usuarios reciban",
                style: estiloLetras20,
              ),
            ),
            TextFormField(
              controller: titulo,
              decoration: InputStyle("titulo a recibir"),
              validator: (v) {
                v!.isEmpty ? "Titulo es requerido" : null;
              },
            ),
            SizedBox(
              height: 35,
            ),
            TextFormField(
              controller: texto,
              decoration: InputStyle("Texto a recibir"),
              validator: (v) {
                v!.isEmpty ? "texto es requerido" : null;
              },
            ),
            Container(
              margin: EdgeInsets.all(50),
              height: 50,
              decoration: BoxDecoration(
                  color: color3, borderRadius: BorderRadius.circular(30)),
              child: IconButton(
                  onPressed: () {
                    sendNotification(titulo.text, texto.text);
                  },
                  icon: Icon(Icons.arrow_forward_outlined)),
            ),
          ],
        ),
      ),
    );
  }
}
