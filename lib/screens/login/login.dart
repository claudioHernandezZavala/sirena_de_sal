import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sirena_de_sal/backend/authServices.dart';
import 'package:sirena_de_sal/bounciPageRoute.dart';
import 'package:sirena_de_sal/constants.dart';
import 'package:sirena_de_sal/screens/login/register.dart';
import 'package:video_player/video_player.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController eController = TextEditingController();
  TextEditingController pController = TextEditingController();
  late VideoPlayerController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.asset("assets/video.mp4")
      ..initialize().then((value) {
        _controller.setVolume(0);
        _controller.play();

        _controller.setLooping(true);
        setState(() {});
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFBF8F1),
      body: SafeArea(
        child: Stack(
          children: [
            VideoPlayer(_controller),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Image.asset(
                    "assets/logoSirena.jpg",
                    width: width * 0.2,
                    height: height * 0.15,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Center(
                    child: Container(
                      width: width * 0.8,
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: color1.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              "Bienvenido",
                              style: estiloLetras22,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: TextFormField(
                                controller: eController,
                                decoration:
                                    const InputDecoration(hintText: "Email"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: TextFormField(
                                controller: pController,
                                obscureText: true,
                                decoration:
                                    const InputDecoration(hintText: "Password"),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextButton.icon(
                                onPressed: () {
                                  firebaseSignIn(eController.text,
                                      pController.text, context);
                                },
                                style: ButtonStyle(
                                    minimumSize:
                                        MaterialStateProperty.all<Size?>(
                                            Size(width * 0.6, 35)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color?>(
                                            color3)),
                                icon: Icon(
                                  Icons.lock_open,
                                  color: color2,
                                ),
                                label: const Text(
                                  "Sign in",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              "O inicia con google",
                              style: estiloLetras20,
                            ),
                            Container(
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: color3),
                                child: IconButton(
                                    onPressed: () {
                                      //    _controller.pause();
                                      //    _controller.dispose();
                                      googleSignIn(context);
                                    },
                                    icon:
                                        const FaIcon(FontAwesomeIcons.google))),
                            Text(
                              "Aun no tienes una cuenta?",
                              style: height <= 700
                                  ? estiloLetras18
                                  : estiloLetras20,
                            ),
                            TextButton.icon(
                                onPressed: () {
                                  Navigator.of(context)
                                      .push(BouncyPageRoute(RegisterPage()));
                                },
                                style: ButtonStyle(
                                    minimumSize:
                                        MaterialStateProperty.all<Size?>(
                                            Size(width * 0.6, 35)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color?>(
                                            color3)),
                                icon: Icon(
                                  Icons.receipt,
                                  color: color2,
                                ),
                                label: const Text(
                                  "Sign up",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
