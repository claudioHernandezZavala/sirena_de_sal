import 'package:flutter/material.dart';

class LeavesContainer extends StatelessWidget {
  const LeavesContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
              image: AssetImage(
                "assets/romero.png",
              ),
              alignment: Alignment.topCenter,
              opacity: 0.5,
              centerSlice: Rect.fromCircle(center: Offset(6, 6), radius: 4),
              scale: 1,
              filterQuality: FilterQuality.none,
              fit: BoxFit.contain,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.7), BlendMode.dstIn),
              repeat: ImageRepeat.repeat)),
    );
  }
}
