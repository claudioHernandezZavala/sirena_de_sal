import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sirena_de_sal/bounciPageRoute.dart';
import 'package:sirena_de_sal/screens/admin/actualizaciones/screen_actualizaciones.dart';
import 'package:sirena_de_sal/screens/admin/categorias/admin_categorias.dart';
import 'package:sirena_de_sal/screens/admin/descuentos/panel_descuentos.dart';
import 'package:sirena_de_sal/screens/admin/pedidos/admin_pedidos.dart';
import 'package:sirena_de_sal/screens/admin/productos/panel_productos.dart';

import '../../constants.dart';

class PanelGeneral extends StatelessWidget {
  const PanelGeneral({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Panel",
          style: styleLetrasAppBar,
        ),
        centerTitle: true,
        backgroundColor: color2,
        foregroundColor: color3,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(BouncyPageRoute(PanelProductos()));
            },
            child: Container(
              margin: const EdgeInsets.all(15),
              height: 250,
              decoration: BoxDecoration(
                  color: color3,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 10,
                      spreadRadius: 5,
                      offset: Offset(6, 6),
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(0.1),
                      blurRadius: 16,
                      spreadRadius: 5,
                      offset: Offset(6, 6),
                    ),
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  FaIcon(
                    FontAwesomeIcons.objectGroup,
                    color: Colors.teal,
                    size: 35,
                  ),
                  Text(
                    "Productos",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(BouncyPageRoute(PanelDescuentos()));
            },
            child: Container(
              margin: const EdgeInsets.all(15),
              height: 250,
              decoration: BoxDecoration(
                  color: color3,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 10,
                      spreadRadius: 5,
                      offset: Offset(6, 6),
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 5,
                      offset: Offset(6, 6),
                    ),
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  FaIcon(
                    FontAwesomeIcons.percent,
                    color: Colors.yellow,
                    size: 35,
                  ),
                  Text(
                    "Descuentos",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(BouncyPageRoute(PanelCategorias()));
            },
            child: Container(
              margin: const EdgeInsets.all(15),
              height: 250,
              decoration: BoxDecoration(
                  color: color3,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 10,
                      spreadRadius: 5,
                      offset: Offset(6, 6),
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(0.1),
                      blurRadius: 16,
                      spreadRadius: 5,
                      offset: Offset(6, 6),
                    ),
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  FaIcon(
                    FontAwesomeIcons.list,
                    color: Colors.lightBlueAccent,
                    size: 35,
                  ),
                  Text(
                    "Categorias",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(BouncyPageRoute(AdminPedidos()));
            },
            child: Container(
              margin: const EdgeInsets.all(15),
              height: 250,
              decoration: BoxDecoration(
                  color: color3,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 16,
                      spreadRadius: 5,
                      offset: Offset(6, 6),
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(0.1),
                      blurRadius: 16,
                      spreadRadius: 5,
                      offset: Offset(6, 6),
                    ),
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  FaIcon(
                    FontAwesomeIcons.clipboardCheck,
                    color: Colors.lightGreenAccent,
                    size: 35,
                  ),
                  Text(
                    "Pedidos",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(BouncyPageRoute(ScreenActualizaciones()));
            },
            child: Container(
              margin: const EdgeInsets.all(15),
              height: 250,
              decoration: BoxDecoration(
                  color: color3,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 16,
                      spreadRadius: 5,
                      offset: Offset(6, 6),
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(0.1),
                      blurRadius: 16,
                      spreadRadius: 5,
                      offset: Offset(6, 6),
                    ),
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  FaIcon(
                    FontAwesomeIcons.clipboardCheck,
                    color: Colors.lightGreenAccent,
                    size: 35,
                  ),
                  Text(
                    "Actualizacion",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
