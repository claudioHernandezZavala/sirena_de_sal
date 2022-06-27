import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sirena_de_sal/constants.dart';
import 'package:sirena_de_sal/funciones/funciones_firebase.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../../clases/pedido.dart';

class ScreenPedidoInfo extends StatefulWidget {
  final pedido pedidoVer;
  const ScreenPedidoInfo({Key? key, required this.pedidoVer}) : super(key: key);

  @override
  State<ScreenPedidoInfo> createState() => _ScreenPedidoInfoState();
}

class _ScreenPedidoInfoState extends State<ScreenPedidoInfo> {
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Informacion de pedido"),
        centerTitle: true,
        backgroundColor: color2,
        foregroundColor: color3,
        titleTextStyle: styleLetrasAppBar,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 25,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "ID DE PEDIDO",
            textAlign: TextAlign.center,
            style: estiloLetras18,
          ),
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: color3, width: 2)),
                width: 250,
                child: Text(
                  widget.pedidoVer.idPedido,
                  style: estiloLetras18,
                  maxLines: 3,
                  softWrap: true,
                ),
              ),
              IconButton(
                onPressed: () {
                  FlutterClipboard.copy(widget.pedidoVer.idPedido)
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("ID copiado en el portapapeles")));
                  });
                },
                icon: Icon(
                  Icons.copy,
                  semanticLabel: "Copiar",
                  shadows: const [Shadow(color: Colors.black, blurRadius: 1)],
                  color: color3,
                ),
              )
            ],
          )),
          Center(
            child: ListTile(
              leading: Icon(
                Icons.date_range,
                color: color3,
              ),
              title: Text(
                "Fecha del pedido:",
                style: estiloLetras20,
              ),
              subtitle: Text(
                widget.pedidoVer.fechaPedido,
                style: estiloLetras18,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Center(
            child: ListTile(
              leading: Icon(
                Icons.list,
                color: color3,
              ),
              title: Text(
                "Items del pedido",
                style: estiloLetras20,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 25, right: 25),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25), color: color2),
            child: Column(
              children: [
                ...widget.pedidoVer.itemsGenerator1(),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Center(
            child: ListTile(
              leading: Icon(
                Icons.person,
                color: color3,
              ),
              title: Text(
                "Informacion del cliente",
                style: estiloLetras20,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 25, right: 25),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25), color: color2),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.text_fields,
                    color: color3,
                  ),
                  title: Text(
                    "Nombre:  " + widget.pedidoVer.infoUsuario.nombre,
                    style: estiloLetras18,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.numbers,
                    color: color3,
                  ),
                  title: Text(
                    "Numero: " + widget.pedidoVer.infoUsuario.numero.toString(),
                    style: estiloLetras18,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.star,
                    color: color3,
                  ),
                  title: Text(
                    "RTN:  " + widget.pedidoVer.infoUsuario.rtn.toString(),
                    style: estiloLetras18,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.map,
                    color: color3,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  title: Text(
                    "Direccion: " + widget.pedidoVer.infoUsuario.direccion,
                    style: estiloLetras18,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: ListTile(
              leading: Icon(
                Icons.subject,
                color: color3,
              ),
              title: Text(
                "Detalles extras sobre el  pedido",
                style: estiloLetras20,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 25),
            child: ListTile(
              leading: Icon(
                Icons.control_point_rounded,
                color: color3,
              ),
              title: Text(
                "Instrucciones extras del comprador:",
                style: estiloLetras18,
              ),
              subtitle: Text(
                widget.pedidoVer.detallesExtras,
                style: style1,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 25),
            child: ListTile(
              leading: const Icon(
                Icons.percent,
                color: Colors.deepPurple,
                size: 45,
              ),
              title: Text(
                "Cupon utilizado:",
                style: estiloLetras18,
              ),
              subtitle: Text(widget.pedidoVer.cuponUtilizado),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            margin: const EdgeInsets.only(left: 25),
            child: ListTile(
              leading: const Icon(
                Icons.monetization_on,
                color: Colors.green,
                size: 45,
              ),
              title: Text(
                "Total del pedido:",
                style: estiloLetras18,
              ),
              subtitle: Text(
                widget.pedidoVer.total.toStringAsFixed(2),
                style: estiloLetras18Dinero,
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          SizedBox(
            height: 200,
            child: Stepper(
              elevation: 15,
              type: StepperType.horizontal,
              physics: const BouncingScrollPhysics(),
              currentStep: estadoPedido(),
              steps: steps(),
            ),
          ),
          InkWell(
            onTap: () async {
              final link = WhatsAppUnilink(
                phoneNumber: '504 ${widget.pedidoVer.infoUsuario.numero}',
                text: "Hey ,${widget.pedidoVer.infoUsuario.nombre}",
              );
              String v = "Hey,${widget.pedidoVer.infoUsuario.nombre}";
              String numero = "504${widget.pedidoVer.infoUsuario.numero}";
              await launchUrl(
                  Uri.parse("whatsapp://send?phone=$numero&text=$v"));
            },
            child: Container(
              color: Colors.green.shade100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Escribirle por whatsapp",
                    style: estiloLetras18,
                  ),
                  const FaIcon(
                    FontAwesomeIcons.whatsapp,
                    color: Colors.green,
                    size: 45,
                  ),
                ],
              ),
            ),
          ),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            primary: true,
            childAspectRatio: 3 / 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            padding: const EdgeInsets.all(15),
            children: [
              TextButton.icon(
                  onPressed: () async {
                    await widget.pedidoVer.referencia
                        .update({"enProgreso": true}).then((value) {
                      setState(() {
                        widget.pedidoVer.enProgreso = true;
                      });
                    });
                  },
                  icon: const Icon(Icons.workspaces_filled, color: Colors.blue),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color?>(
                        Colors.yellow.withOpacity(0.8)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder?>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                  ),
                  label: Text(
                    "Poner pedido en progreso",
                    style: estiloLetras18,
                  )),
              TextButton.icon(
                  onPressed: () async {
                    sendPushMessage(widget.pedidoVer.infoUsuario.nombre,
                        widget.pedidoVer.infoUsuario.token);
                  },
                  icon: const Icon(Icons.check_box, color: Colors.white),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color?>(
                        Colors.green.withOpacity(0.8)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder?>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                  ),
                  label: Text(
                    "Pedido terminado",
                    style: estiloLetras18,
                  )),
              TextButton.icon(
                  onPressed: () async {
                    await widget.pedidoVer.referencia
                        .update({"entregado": true}).then((value) {
                      setState(() {
                        widget.pedidoVer.entregado = true;
                      });
                    });
                  },
                  icon: const Icon(Icons.check_box, color: Colors.white),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color?>(
                        Colors.blue.withOpacity(0.8)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder?>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                  ),
                  label: Text(
                    "Pedido entregado",
                    style: estiloLetras18,
                  )),
              TextButton.icon(
                  onPressed: () async {
                    await widget.pedidoVer.referencia.update({
                      "entregado": false,
                      "enProgreso": true,
                    }).then((value) {
                      setState(() {
                        widget.pedidoVer.entregado = false;
                        widget.pedidoVer.enProgreso = true;
                      });
                    });
                  },
                  icon: const Icon(Icons.subdirectory_arrow_left_rounded,
                      color: Colors.white),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color?>(
                        Colors.red.withOpacity(0.8)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder?>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                  ),
                  label: Text(
                    "Revertir a en progreso",
                    style: estiloLetras18,
                  )),
              TextButton.icon(
                  onPressed: () async {
                    await widget.pedidoVer.referencia.update({
                      "entregado": false,
                      "enProgreso": false,
                      "recibido": true
                    }).then((value) {
                      setState(() {
                        widget.pedidoVer.recibido = true;
                        widget.pedidoVer.enProgreso = false;
                        widget.pedidoVer.entregado = false;
                      });
                    });
                  },
                  icon: const Icon(Icons.subdirectory_arrow_left_rounded,
                      color: Colors.white),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color?>(
                        Colors.red.withOpacity(0.8)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder?>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                  ),
                  label: Text(
                    "Revertir a recibido",
                    style: estiloLetras18,
                  )),
              TextButton.icon(
                  onPressed: () {
                    widget.pedidoVer.referencia.delete();
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color?>(Colors.redAccent),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder?>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                  ),
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Cancelar pedido",
                    style: estiloLetras18,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  int estadoPedido() {
    int estado = 0;
    if (widget.pedidoVer.recibido) {
      setState(() {
        estado = 0;
        currentStep = 0;
      });
    }
    if (widget.pedidoVer.enProgreso) {
      setState(() {
        estado = 1;

        currentStep = 1;
      });
    }
    if (widget.pedidoVer.entregado) {
      setState(() {
        estado = 2;

        currentStep = 2;
      });
    }

    return estado;
  }

  List<Step> steps() {
    return [
      Step(
          isActive: currentStep >= 0,
          title: const Text("Recibido"),
          state: StepState.indexed,
          content: const Text("El administrado recibio el pedido")),
      Step(
          isActive: currentStep >= 1,
          state: StepState.editing,
          title: const Text("En progreso"),
          content: const Text("Tu pedido se esta procesando")),
      Step(
          isActive: currentStep >= 2,
          state: StepState.complete,
          title: const Text("Entregado"),
          content: const Text("Tu pedido fue entregado")),
    ];
  }
}

var style1 = const TextStyle(
    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black);
