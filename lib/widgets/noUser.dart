import 'package:flutter/material.dart';

import '../bounciPageRoute.dart';
import '../constants.dart';
import '../screens/login/login.dart';

class NoUserWidget extends StatelessWidget {
  const NoUserWidget({Key? key, required this.width, required this.heigth})
      : super(key: key);

  final double width;
  final double heigth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: heigth,
        width: width,
        color: color2,
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              CircleAvatar(
                radius: 75,
                backgroundImage: const AssetImage(
                  "assets/logoSirena.jpg",
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Container(
                height: heigth * 0.4,
                width: 250,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                    color: color1, borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Material(
                      child: Text(
                        "Sign in for more fun!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                    TextButton.icon(
                        onPressed: () {
                          Navigator.of(context)
                              .push(BouncyPageRoute(const LoginPage()));
                        },
                        style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size?>(
                                Size(width * 0.6, 35)),
                            backgroundColor:
                                MaterialStateProperty.all<Color?>(color3)),
                        icon: const Icon(
                          Icons.lock_open,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Sign in",
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
