import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirena_de_sal/screens/homepage.dart';
import 'package:sirena_de_sal/widgets/leavesFall.dart';
import 'package:ticket_widget/ticket_widget.dart';

import '../../backend/pdfInvoiceApi.dart';
import '../../clases/ItemCarrito.dart';
import '../../clases/invoices/customerInfo.dart';
import '../../clases/invoices/invoiceClass.dart';
import '../../constants.dart';
import '../../usuario/infoUsuario.dart';

class Recibo extends StatefulWidget {
  final double descuento;
  final double total;
  final String cupon;
  final justGeneralInfo info;
  final String idPedido;
  final List<ItemsCarrito> items;
  final String extra;
  const Recibo(
      {Key? key,
      required this.descuento,
      required this.total,
      required this.cupon,
      required this.info,
      required this.idPedido,
      required this.items,
      required this.extra})
      : super(key: key);

  @override
  State<Recibo> createState() => _ReciboState();
}

class _ReciboState extends State<Recibo> {
  List<invoiceItem> invoiceItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var element in widget.items) {
      invoiceItems.add(invoiceItem(
          nombre: element.nombre,
          cantidad: element.cantidadProducto,
          precio: element.precio));
    }
    for (var element in widget.items) {
      element.referenciaItemCarrito.delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: color4,
        appBar: AppBar(
          backgroundColor: color2,
          foregroundColor: color3,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (ctx) => const HomePage()),
                      (route) => false);
                },
                icon: const Icon(Icons.home))
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color?>(color3)),
                    onPressed: () async {
                      Invoice invoice;
                      invoice = Invoice(
                          descuento: widget.descuento,
                          customerInfo: Customer(
                              Direccion: "Direccion: ${widget.info.direccion}",
                              RTN: '${widget.info.rtn}'),
                          items: invoiceItems,
                          invoiceInfo: InvoiceInfo(
                              extraDescription: widget.extra,
                              invoiceDate: DateTime.now(),
                              dueDate: DateTime.now(),
                              invoiceId: widget.idPedido));
                      await PdfInvoiceApi.generate(invoice, widget.descuento,
                              widget.total, widget.idPedido)
                          .whenComplete(() {
                        Fluttertoast.showToast(
                            msg: "PDF descargado en carpeta descargas",
                            backgroundColor: Colors.green);
                      });
                    },
                    child: const Text(
                      "Descargar una factura pdf",
                      style: TextStyle(color: Colors.white),
                    )),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Gracias por tu compra!",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: TicketWidget(
                    width: 350,
                    height: 550,
                    color: colorwaux,
                    isCornerRounded: true,
                    child: Stack(
                      children: [
                        const LeavesContainer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/logoSirena.jpg",
                                  width: 100,
                                  height: 100,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 25),
                              child: Text(
                                "Recibo de compra",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 23),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5, left: 25),
                              child: Text(
                                widget.idPedido,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 40, top: 25),
                              child: Text(
                                "Cliente",
                                style: style,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 40, top: 10),
                              child: Text(
                                widget.info.nombre,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Divider(
                                color: Colors.black,
                                thickness: 0.5,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 40, top: 25),
                              child: Text(
                                "Pago total",
                                style: style,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 40, top: 10),
                              child: Text(
                                "Lps. " + widget.total.toStringAsFixed(2),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 40, top: 25),
                              child: Text(
                                "Cupon aplicado",
                                style: style,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 40, top: 15),
                              child: Text(
                                widget.cupon,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

var style = GoogleFonts.yuseiMagic(color: color4, fontSize: 18);
var styleSubtitulo = GoogleFonts.yuseiMagic(
    color: color4, fontSize: 10, fontStyle: FontStyle.italic);
/*
 mostrar
              ? Expanded(child: SfPdfViewer.file(pdf))
              : Center(
                  child: FlatButton(
                    onPressed: () async {
                      List<invoiceItem> invoiceItems = [];
                      items.forEach((element) {
                        invoiceItems.add(invoiceItem(
                            nombre: element.nombre,
                            cantidad: element.cantidadProducto,
                            precio: element.precio));
                      });
                      Invoice invoice;
                      invoice = Invoice(
                          descuento: 25,
                          customerInfo: Customer(
                              Direccion: "Reparto por bajo",
                              RTN: '0801200212708'),
                          items: invoiceItems,
                          invoiceInfo: InvoiceInfo(
                              extraDescription: 'nooow',
                              invoiceDate: DateTime.now(),
                              dueDate: DateTime.now(),
                              invoiceId: '454213512'));

                      pdf = await PdfInvoiceApi.generate(
                          invoice, widget.descuento, widget.total);
                      if (pdf != null) {
                        setState(() {
                          mostrar = true;
                        });
                      } else {
                        print("vacio");
                      }
                    },
                    child: Text("generar"),
                  ),
                ),
 */
