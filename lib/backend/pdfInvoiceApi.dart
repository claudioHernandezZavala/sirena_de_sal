import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:sirena_de_sal/backend/pdfApi.dart';

import '../clases/invoices/invoiceClass.dart';

class PdfInvoiceApi {
  static Future<File> generate(
      Invoice invoice, double descuento, double total, String uuid) async {
    final pdf = Document();
    Widget header = await buildHeader(invoice);

    pdf.addPage(MultiPage(
      build: (context) => [
        SizedBox(height: 25),
        header,
        SizedBox(height: 35),
        buildInvoice(invoice),
        SizedBox(height: 25),
        buildTotal(invoice, descuento, total)
      ],
      //footer: (context) => buildFooter(invoice),
    ));

    return PdfApi.saveDocument(name: 'my_invoice$uuid.pdf', pdf: pdf);
  }
}

Future<Widget> buildHeader(Invoice invoice) async {
  final ByteData bytes = await rootBundle.load('assets/logoSirena.jpg');
  final Uint8List byteList = bytes.buffer.asUint8List();

  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Sirena de sal', style: const TextStyle(fontSize: 25)),
        SizedBox(height: 25),
        Text("Fecha de pedido" + invoice.invoiceInfo.invoiceDate.toString(),
            style: const TextStyle(fontSize: 15)),
        Text("ID de tu pedido:" + invoice.invoiceInfo.invoiceId,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
      ]),
      Image(MemoryImage(byteList), width: 80, height: 80)
    ]),
    SizedBox(height: 50),
    Text("Factura", style: const TextStyle(fontSize: 35))
  ]);
}

Widget buildInvoice(Invoice invoice) {
  final headers = ['Unidades', 'Descripcion', 'precio', 'total'];
  final data = invoice.items.map((item) {
    final total = item.precio * item.cantidad;
    return [
      '${item.cantidad}',
      item.nombre,
      (item.precio.toStringAsFixed(2)),
      (total.toStringAsFixed(2))
    ];
  }).toList();
  return Table.fromTextArray(
    headers: headers,
    data: data,
    cellStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    headerDecoration: const BoxDecoration(color: PdfColors.grey300),
    cellHeight: 30,
  );
}

Widget buildTotal(Invoice invoice, double descuento, double total) {
  return Container(
    alignment: Alignment.centerRight,
    child: Row(
      children: [
        Spacer(flex: 6),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildText(
                title: 'Sub-total',
                value: '${total.toStringAsFixed(2)} Lps.',
                unite: true,
              ),
              buildText(
                title: 'Descuento',
                value: '- ${descuento.toStringAsFixed(2)} Lps.',
                unite: true,
              ),
              Divider(),
              buildText(
                title: 'Total',
                titleStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                value: '${(total).toStringAsFixed(2)} Lps.',
                unite: true,
              ),
              SizedBox(height: 2 * PdfPageFormat.mm),
              Container(height: 1, color: PdfColors.grey400),
              SizedBox(height: 0.5 * PdfPageFormat.mm),
              Container(height: 1, color: PdfColors.grey400),
            ],
          ),
        ),
      ],
    ),
  );
}

buildText({
  required String title,
  required String value,
  double width = double.infinity,
  TextStyle? titleStyle,
  bool unite = false,
}) {
  final style =
      titleStyle ?? TextStyle(fontWeight: FontWeight.bold, fontSize: 15);

  return Container(
    width: width,
    child: Row(
      children: [
        Expanded(child: Text(title, style: style)),
        Text(value, style: unite ? style : null),
      ],
    ),
  );
}
