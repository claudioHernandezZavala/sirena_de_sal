import 'package:flutter/material.dart';

class HeartAnimation extends StatefulWidget {
  final Widget child;
  final bool isAnimating;
  final Duration duration;
  final VoidCallback? onEnd;
  const HeartAnimation(
      {Key? key,
      required this.child,
      required this.isAnimating,
      this.duration = const Duration(milliseconds: 250),
      this.onEnd})
      : super(key: key);

  @override
  State<HeartAnimation> createState() => _HeartAnimationState();
}

class _HeartAnimationState extends State<HeartAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scale;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final half = widget.duration.inMilliseconds;
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: half));
    scale = Tween<double>(begin: 1, end: 1.15).animate(animationController);
  }

  @override
  void didUpdateWidget(HeartAnimation oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimating != oldWidget.isAnimating) {
      doAnimation();
    }
  }

  Future doAnimation() async {
    await animationController.forward();
    await animationController.reverse();
    if (widget.onEnd != null) {
      widget.onEnd!();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.elasticInOut,
      child: ScaleTransition(
        child: widget.child,
        scale: scale,
      ),
      duration: const Duration(seconds: 5),
    );
  }
}
