import 'package:flutter/material.dart';

class AnimatedListItemWraper extends StatelessWidget {
  final Widget child;
  final int index;
  final int totalItems;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final Offset slideOffset;

  const AnimatedListItemWraper({
    super.key,
    required this.child,
    this.index = 0,
    this.totalItems = 10,
    this.duration = const Duration(milliseconds: 400),
    this.delay = const Duration(milliseconds: 50),
    this.curve = Curves.easeOutCubic,
    this.slideOffset = const Offset(30, 0),
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: duration,
      tween: Tween(begin: 0.0, end: 1.0),
      curve: curve,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(
            slideOffset.dx * (1 - value),
            slideOffset.dy * (1 - value),
          ),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}