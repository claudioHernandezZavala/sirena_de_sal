import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:sirena_de_sal/bounciPageRoute.dart';
import 'package:sirena_de_sal/screens/homepage.dart';
import 'package:sirena_de_sal/widgets/leavesFall.dart';

import '../../constants.dart';

class Onboard extends StatefulWidget {
  const Onboard({Key? key}) : super(key: key);

  @override
  _OnboardState createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  late LiquidController liquidcontroller;
  final formKey = GlobalKey<FormState>();

  TextEditingController nombre = TextEditingController();
  TextEditingController numero = TextEditingController();
  @override
  void initState() {
    liquidcontroller = LiquidController();
    super.initState();
  }

  Widget _buildDot(int index) {
    double selecttive = index / 2;
    double zoom = 1.0 + (2.0 - 1.0) * selecttive;
    return SizedBox(
      width: 25.0,
      child: Center(
        child: Material(
          color: Colors.white,
          type: MaterialType.circle,
          child: SizedBox(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }

  int page = 0;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final pages = [
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: [
            const LeavesContainer(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Una bienvenida a \nSirena de sal",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.alfaSlabOne(
                        textStyle: TextStyle(fontSize: 20, color: color4)),
                  ),
                  Image.asset(
                    "assets/logoSirena.jpg",
                    width: 120,
                    height: 120,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          colors: [Colors.black, Colors.black12],
          begin: Alignment.bottomCenter,
          end: Alignment.center,
        ).createShader(bounds),
        blendMode: BlendMode.darken,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              color: Color(0xFFF2A154),
              image: DecorationImage(
                  image: AssetImage("assets/pic2.jpeg"), fit: BoxFit.fill)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Tenemos productos unicos",
                textAlign: TextAlign.center,
                style: GoogleFonts.alfaSlabOne(
                    textStyle: TextStyle(
                        fontSize: 15, color: color4, backgroundColor: color1)),
              )
            ],
          ),
        ),
      ),
      ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          colors: [Colors.black, Colors.black12],
          begin: Alignment.bottomCenter,
          end: Alignment.center,
        ).createShader(bounds),
        blendMode: BlendMode.darken,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              color: Color(0xFFFFB4B4),
              image: DecorationImage(
                  image: AssetImage("assets/picpedidos.jpeg"),
                  fit: BoxFit.cover,
                  colorFilter:
                      ColorFilter.mode(Colors.grey, BlendMode.dstATop))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Entregas a todo el pais",
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.alfaSlabOne(
                      textStyle: TextStyle(
                          fontSize: 18,
                          color: color4,
                          backgroundColor: color1)))
            ],
          ),
        ),
      ),
      ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: [Colors.black.withOpacity(0.8), Colors.black12],
          begin: Alignment.bottomRight,
          end: Alignment.centerLeft,
        ).createShader(bounds),
        blendMode: BlendMode.darken,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              color: Color(0xFFFFB4B4),
              image: DecorationImage(
                  image: AssetImage("assets/pic3.jpeg"),
                  fit: BoxFit.cover,
                  colorFilter:
                      ColorFilter.mode(Colors.grey, BlendMode.dstATop))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 25,
              ),
              Text("Creative accessories\n for magical souls",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20, color: color4, backgroundColor: color1)),
              const SizedBox(
                height: 25,
              ),
              Center(
                child: Image.asset(
                  "assets/logoSirena.jpg",
                  height: 220,
                  width: 230,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    ];
    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe(
              waveType: WaveType.liquidReveal,
              onPageChangeCallback: pageChangeCallback,
              enableLoop: false,
              enableSideReveal: true,
              slideIconWidget: Icon(
                Icons.arrow_forward_ios,
                color: color3,
              ),
              liquidController: liquidcontroller,
              pages: pages),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Column(
              children: <Widget>[
                const Expanded(child: SizedBox()),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(pages.length, (int index) {
                      return AnimatedContainer(
                        duration: const Duration(microseconds: 300),
                        height: 10,
                        width: (index == page) ? 30 : 10,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: (index == page)
                                ? Colors.white
                                : Colors.black.withOpacity(0.5)),
                      );
                    })),
              ],
            ),
          ),
          page == pages.length - 1
              ? Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color?>(color3)),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context2) => AlertDialog(
                                  title: const Text(
                                      "Como deberiamos de identificarte?"),
                                  backgroundColor: color2,
                                  content: Container(
                                    width: w * 0.6,
                                    height: h * 0.3,
                                    child: Form(
                                      key: formKey,
                                      child: ListView(
                                        children: [
                                          TextFormField(
                                            controller: nombre,
                                            decoration: const InputDecoration(
                                                hintText: 'Tu nombre'),
                                            validator: (value) {
                                              return value!.isEmpty
                                                  ? 'Un nombre es requerido'
                                                  : null;
                                            },
                                          ),
                                          TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller: numero,
                                            decoration: const InputDecoration(
                                                hintText: 'Tu numero'),
                                            validator: (value) {
                                              return value!.isEmpty
                                                  ? 'Un numero es requerido'
                                                  : null;
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          if (validateForm()) {
                                            FirebaseAuth.instance.currentUser
                                                ?.updateDisplayName(
                                                    nombre.text);
                                            CollectionReference referencia;
                                            referencia = FirebaseFirestore
                                                .instance
                                                .collection("usuarios/");
                                            referencia
                                                .doc(FirebaseAuth
                                                    .instance.currentUser?.uid)
                                                .set({
                                              "Nombre": nombre.text,
                                              "Numero": int.parse(numero.text)
                                            }, SetOptions(merge: true));

                                            Navigator.of(context2).pop();
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    BouncyPageRoute(HomePage()),
                                                    (route) => false);
                                          }
                                        },
                                        child: const Text("Confirmar"))
                                  ],
                                ));
                      },
                      child: const Text(
                        "iniciar",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              : Container(),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 35, right: 20),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  liquidcontroller.animateToPage(
                      page: pages.length - 1, duration: 700);
                },
                child: const Text(
                  "Skip",
                  style: TextStyle(color: Colors.white),
                ),
                color: color3,
              ),
            ),
          ),
          page != pages.length - 1
              ? Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        liquidcontroller.jumpToPage(
                            page: liquidcontroller.currentPage + 1 >
                                    pages.length - 1
                                ? 0
                                : liquidcontroller.currentPage + 1);
                      },
                      child: const Text("Next",
                          style: TextStyle(color: Colors.white)),
                      color: color3,
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  bool validateForm() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  pageChangeCallback(int lpage) {
    setState(() {
      page = lpage;
    });
  }
}
