import 'customerInfo.dart';

class Invoice {
  Customer customerInfo;
  double descuento;
  InvoiceInfo invoiceInfo;
  List<invoiceItem> items;
  Invoice(
      {required this.customerInfo,
      required this.descuento,
      required this.items,
      required this.invoiceInfo});
}

class InvoiceInfo {
  String extraDescription;
  DateTime invoiceDate;
  DateTime dueDate;
  String invoiceId;
  InvoiceInfo(
      {required this.extraDescription,
      required this.invoiceDate,
      required this.dueDate,
      required this.invoiceId});
}

class invoiceItem {
  String nombre;
  double precio;
  int cantidad;
  invoiceItem(
      {required this.nombre, required this.precio, required this.cantidad});
}
