import 'package:flutter/material.dart';

class DescriptionWidget extends StatelessWidget {
  final String description;
  const DescriptionWidget({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Container(
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(color: Colors.white),
          child: Text(
            description,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                height: 1.5,
                fontSize: 15,
                color: Color(0xFF1C0A00)),
          ),
        ),
        Positioned(
          left: 20,
          child: RotationTransition(
              turns: const AlwaysStoppedAnimation(35 / 360),
              child: Container(
                width: 5,
                height: 50,
                color: Colors.black,
              )),
        ),
        Positioned(
          bottom: 1,
          right: 20,
          child: RotationTransition(
              turns: const AlwaysStoppedAnimation(35 / 360),
              child: Container(
                width: 5,
                height: 50,
                color: Colors.black,
              )),
        ),
      ],
    );
  }
}
