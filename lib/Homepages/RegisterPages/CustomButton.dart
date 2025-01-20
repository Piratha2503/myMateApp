import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Color primaryColor;
  final Color hoverColor;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.primaryColor,
    required this.hoverColor,
    required this.onPressed,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.95,
      upperBound: 1.0,
    );
    _scaleAnimation = _controller;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onPressDown() {
    setState(() {
      _isPressed = true;
    });
    HapticFeedback.lightImpact(); // Haptic feedback
    _controller.reverse(); // Scale down
  }

  void onPressUp() {
    setState(() {
      _isPressed = false;
    });
    _controller.forward(); // Scale up
    widget.onPressed(); // Trigger onPressed callback
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: GestureDetector(
        onTapDown: (_) => onPressDown(),
        onTapUp: (_) => onPressUp(),
        onTapCancel: () => _controller.forward(),
        child: ScaleTransition(
          scale: _scaleAnimation,
            child: ElevatedButton(
              onPressed: null, // Controlled by GestureDetector
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  _isHovered || _isPressed
                      ? widget.hoverColor
                      : widget.primaryColor,
                ),
                elevation: MaterialStateProperty.all(
                  _isHovered || _isPressed ? 8 : 4,
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                ),
              ),
              child: Text(
                widget.text,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
        ),
      ),
    );
  }
}
