import 'package:flutter/material.dart';
import 'dart:async';

class TypingAnimation extends StatefulWidget {
  final List<String> texts;
  final TextStyle? textStyle;
  final Duration typingSpeed;
  final Duration pauseDuration;
  final Duration deleteSpeed;
  final bool showCursor;
  final Color? cursorColor;

  const TypingAnimation({
    super.key,
    required this.texts,
    this.textStyle,
    this.typingSpeed = const Duration(milliseconds: 100),
    this.pauseDuration = const Duration(milliseconds: 2000),
    this.deleteSpeed = const Duration(milliseconds: 50),
    this.showCursor = true,
    this.cursorColor,
  });

  @override
  State<TypingAnimation> createState() => _TypingAnimationState();
}

class _TypingAnimationState extends State<TypingAnimation>
    with TickerProviderStateMixin {
  late AnimationController _cursorController;
  late Animation<double> _cursorAnimation;

  int _currentTextIndex = 0;
  int _currentCharIndex = 0;
  String _displayText = '';
  bool _isDeleting = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Cursor blinking animation
    _cursorController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _cursorAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _cursorController, curve: Curves.easeInOut),
    );

    _cursorController.repeat(reverse: true);
    _startTyping();
  }

  @override
  void dispose() {
    _cursorController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTyping() {
    _timer = Timer.periodic(
      _isDeleting ? widget.deleteSpeed : widget.typingSpeed,
      (timer) {
        if (!mounted) return;

        setState(() {
          if (_isDeleting) {
            if (_displayText.isNotEmpty) {
              _displayText = _displayText.substring(0, _displayText.length - 1);
            } else {
              _isDeleting = false;
              _currentTextIndex = (_currentTextIndex + 1) % widget.texts.length;
              _currentCharIndex = 0; // Reset character index for new text
              timer.cancel();
              _startTyping();
            }
          } else {
            if (_currentCharIndex < widget.texts[_currentTextIndex].length) {
              _displayText +=
                  widget.texts[_currentTextIndex][_currentCharIndex];
              _currentCharIndex++;
            } else {
              _isDeleting = true;
              timer.cancel();
              Timer(widget.pauseDuration, () {
                if (mounted) _startTyping();
              });
            }
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(_displayText, style: widget.textStyle),
        if (widget.showCursor)
          AnimatedBuilder(
            animation: _cursorAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _cursorAnimation.value,
                child: Container(
                  width: 2,
                  height: widget.textStyle?.fontSize ?? 16,
                  color: widget.cursorColor ?? widget.textStyle?.color,
                  margin: const EdgeInsets.only(left: 2),
                ),
              );
            },
          ),
      ],
    );
  }
}
