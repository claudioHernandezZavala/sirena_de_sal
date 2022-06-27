import 'package:cloud_firestore/cloud_firestore.dart';

class infoUser {
  String nombre;
  String direccion;
  int numero;
  String rtn;
  List<DocumentReference> favorites;

  String geolocation;
  bool suscrito;

  DocumentReference referencia;
  infoUser(this.nombre, this.direccion, this.numero, this.rtn, this.geolocation,
      this.referencia, this.favorites, this.suscrito);
  Map toJson() => {
        'Nombre': this.nombre,
        'Direccion': this.direccion,
        'Numero': this.numero,
        'RTN': this.rtn,
        'favorites': this.favorites,
        'suscrito': this.suscrito
      };
}

class justGeneralInfo {
  String nombre, direccion;
  int numero;
  String rtn;
  String token;

  justGeneralInfo(
      this.nombre, this.direccion, this.numero, this.rtn, this.token);
  factory justGeneralInfo.fromJson(dynamic json) {
    return justGeneralInfo(
        json['Nombre'] as String,
        json['Direccion'] as String,
        json["Numero"] as int,
        json["RTN"],
        json["token"]);
  }
  Map toJson() => {
        'Nombre': this.nombre,
        'Direccion': this.direccion,
        'Numero': this.numero,
        'RTN': this.rtn,
        'token': this.token
      };
}
