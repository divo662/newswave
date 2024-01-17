import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class FadeInRight extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double delay;

  FadeInRight({
    required this.child,
    this.duration = const Duration(seconds: 2),
    this.delay = 0.0,
  });

  @override
  _FadeInRightState createState() => _FadeInRightState();
}

class _FadeInRightState extends State<FadeInRight>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<double> _slideRight;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    final animationDelay = Duration(milliseconds: (widget.delay * 1000).toInt());
    _fadeIn = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0, 1, curve: Curves.easeOut),
      ),
    );

    _slideRight = Tween<double>(
      begin: -30.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0, 1, curve: Curves.easeOut),
      ),
    );

    Future.delayed(animationDelay, () {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeIn.value,
          child: Transform.translate(
            offset: Offset(_slideRight.value, 0.0),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

