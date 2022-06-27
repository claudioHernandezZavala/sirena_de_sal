import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirena_de_sal/constants.dart';

import '../../../clases/categoria.dart';
import '../../screens/admin/categorias/modificar_categorias.dart';

class AdminCategComp extends StatelessWidget {
  final List<Categoria> categorias;
  const AdminCategComp({
    Key? key,
    required this.categorias,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return categorias.isEmpty
        ? Container()
        : Expanded(
            child: ListView.builder(
                itemCount: categorias.length + 1,
                itemBuilder: (context, index) {
                  if (index == categorias.length) {
                    return SizedBox(
                      height: 60,
                    );
                  }
                  return cardCategoriasAdmin(categoria: categorias[index]);
                }));
  }
}

class cardCategoriasAdmin extends StatelessWidget {
  const cardCategoriasAdmin({
    Key? key,
    required this.categoria,
  }) : super(key: key);

  final Categoria categoria;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        actions: [
          IconSlideAction(
            caption: "Eliminar",
            color: const Color(0xFF8C0000),
            icon: Icons.delete,
            onTap: () {
              FirebaseStorage.instance
                  .refFromURL(categoria.imagen)
                  .delete()
                  .whenComplete(() => categoria.referencia.delete());
            },
          ),
          IconSlideAction(
            caption: "Modificar",
            color: Colors.green,
            icon: Icons.mode_edit,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ModificarCategoria(categoriaModificar: categoria)));
            },
          )
        ],
        actionPane: const SlidableDrawerActionPane(),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: color3, width: 2),
            ),
            color: colorwaux,
            elevation: 20,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Image.network(
                      categoria.imagen,
                      height: 120,
                      width: 120,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(categoria.categoriaTexto,
                              style: GoogleFonts.yuseiMagic(
                                  color: color4,
                                  fontSize: 21,
                                  letterSpacing: 2)),
                        ],
                      ),
                    ),
                  ],
                ))),
      ),
    );
  }
}
