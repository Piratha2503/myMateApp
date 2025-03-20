import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:flutter/material.dart';

class StyledSwitch extends StatefulWidget {
  final void Function(bool isToggled) onToggled;
  final bool initialValue;
  final Color activeColor;
  final Color inactiveColor;
  final Color thumbColorActive;
  final Color thumbColorInactive;
  final double size;

  const StyledSwitch({
    Key? key,
    required this.onToggled,
    this.initialValue = false,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.thumbColorActive = Colors.white,
    this.thumbColorInactive = Colors.white,
    this.size = 25,
  }) : super(key: key);

  @override
  State<StyledSwitch> createState() => _StyledSwitchState();
}

class _StyledSwitchState extends State<StyledSwitch> {
  late bool isToggled;
  late double innerPadding;

  @override
  void initState() {
    super.initState();
    isToggled = widget.initialValue;
    innerPadding = widget.size / 10;
  }

  void _toggleSwitch() {
    setState(() => isToggled = !isToggled);
    widget.onToggled(isToggled);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSwitch,
      child: AnimatedContainer(
        height: widget.size,
        width: widget.size * 2,
        padding: EdgeInsets.all(innerPadding),
        alignment: isToggled ? Alignment.centerRight : Alignment.centerLeft, // Fixed alignment issue
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: isToggled ? widget.activeColor.withOpacity(0.5) : widget.inactiveColor.withOpacity(0.5),
        ),
        child: Container(
          width: widget.size - innerPadding * 2,
          height: widget.size - innerPadding * 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: isToggled ? widget.thumbColorActive : widget.thumbColorInactive,
          ),
        ),
      ),
    );
  }
}
