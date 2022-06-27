import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sirena_de_sal/bounciPageRoute.dart';
import 'package:sirena_de_sal/constants.dart';
import 'package:sirena_de_sal/screens/admin/panel_general.dart';
import 'package:sirena_de_sal/usuario/pedidos.dart';
import 'package:url_launcher/url_launcher_string.dart';

Widget adminTile(BuildContext context) {
  if (FirebaseAuth.instance.currentUser != null &&
      (FirebaseAuth.instance.currentUser?.email == "claudio.ahz123@gmail.com" ||
          FirebaseAuth.instance.currentUser?.email ==
              "adminprueba@gmail.com")) {
    return Container(
      color: color3,
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(BouncyPageRoute(const PanelGeneral()));
        },
        title: Text(
          "Admin panel",
          style: style(),
        ),
        leading: const Icon(
          Icons.style,
          color: Colors.white,
        ),
      ),
    );
  } else {
    return const SizedBox();
  }
}

Widget pedidosTile(BuildContext context) {
  if (FirebaseAuth.instance.currentUser != null) {
    return Container(
      color: color3,
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: const Icon(
          Icons.assignment,
          color: Colors.white,
        ),
        onTap: () {
          Navigator.of(context).push(BouncyPageRoute(const Pedidos()));
        },
        title: Text(
          "Mis pedidos",
          style: style(),
        ),
      ),
    );
  } else {
    return const SizedBox();
  }
}

Drawer drawer(BuildContext context) {
  return Drawer(
    backgroundColor: color2,
    child: ListView(
      children: [
        const SizedBox(
          height: 45,
        ),
        pedidosTile(context),
        Container(
          color: color3,
          margin: const EdgeInsets.only(bottom: 15),
          child: ListTile(
            leading: const Icon(
              Icons.book,
              color: Colors.white,
            ),
            onTap: () {
              //Navigator.of(context).push(BouncyPageRoute(const LoginPage()));
            },
            title: Text(
              "Terminos y servicios",
              style: style(),
            ),
          ),
        ),
        Container(
          color: color3,
          margin: const EdgeInsets.only(bottom: 15),
          child: ListTile(
            leading: const FaIcon(
              FontAwesomeIcons.instagram,
              color: Colors.white,
            ),
            onTap: () {
              launchUrlString("https://www.instagram.com/sirena.de.sal/",
                  mode: LaunchMode.externalApplication);
            },
            title: Text(
              "Visitanos en Instagram",
              style: style(),
            ),
          ),
        ),
        Container(
          color: color3,
          margin: const EdgeInsets.only(bottom: 15),
          child: ListTile(
            leading: const FaIcon(
              FontAwesomeIcons.facebook,
              color: Colors.white,
            ),
            onTap: () {
              launchUrlString("https://www.facebook.com/Sirenaadesal/",
                  mode: LaunchMode.externalApplication);
            },
            title: Text(
              "Visitanos en Facebook",
              style: style(),
            ),
          ),
        ),
        adminTile(context),
      ],
    ),
  );
}

TextStyle style() {
  return const TextStyle(color: Colors.white);
}
