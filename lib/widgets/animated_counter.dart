import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';
import '../config/theme.dart';

class AnimatedCounter extends StatefulWidget {
  final int endValue;
  final Duration duration;
  final TextStyle? textStyle;
  final String? suffix;
  final String? prefix;
  final bool showPlus;

  const AnimatedCounter({
    super.key,
    required this.endValue,
    this.duration = const Duration(milliseconds: 2000),
    this.textStyle,
    this.suffix,
    this.prefix,
    this.showPlus = false,
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _animation = Tween<double>(
      begin: 0.0,
      end: widget.endValue.toDouble(),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _checkIfVisible() {
    if (!_hasAnimated) {
      final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final position = renderBox.localToGlobal(Offset.zero);
        final screenHeight = MediaQuery.of(context).size.height;

        // Trigger animation when widget is 80% visible
        if (position.dy < screenHeight * 0.8) {
          _hasAnimated = true;
          _controller.forward();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    WidgetsBinding.instance.addPostFrameCallback((_) => _checkIfVisible());

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final currentValue = _animation.value.round();
        final displayValue =
            widget.showPlus && currentValue > 0
                ? '+$currentValue'
                : '$currentValue';

        return Text(
          '${widget.prefix ?? ''}$displayValue${widget.suffix ?? ''}',
          style:
              widget.textStyle ??
              TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontSize: 32,
                fontWeight: AppTheme.bold,
                color: themeController.textPrimaryColor,
              ),
        );
      },
    );
  }
}


