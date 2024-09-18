import 'package:flutter/material.dart';

import '../../core/theme.dart';

class MyElevatedButton extends StatefulWidget {
  final Function()? onPress;
  final Color? buttonColor;
  final double? elevation;
  final Widget child;
  final bool? disableButton;
  final BorderSide? border;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  const MyElevatedButton(
      {super.key,
      required this.onPress,
      required this.child,
      this.buttonColor,
      this.elevation,
      this.border,
      this.disableButton,
      this.height,
      this.width,
      this.padding});

  @override
  State<MyElevatedButton> createState() => _MyElevatedButtonState();
}

class _MyElevatedButtonState extends State<MyElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      height: widget.height,
      width: widget.width,
      child: ElevatedButton(
          style: ButtonStyle(
              elevation: WidgetStateProperty.all(widget.elevation),
              backgroundColor: WidgetStateProperty.resolveWith<Color>(
                (states) {
                  if (states.contains(WidgetState.disabled)) {
                    return widget.buttonColor?.withOpacity(0.5) ?? ColorTheme.primaryColor.withOpacity(0.5);
                  }
                  return widget.buttonColor ?? ColorTheme.primaryColor;
                },
              ),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                side: widget.border ?? BorderSide.none,
                borderRadius: BorderRadius.circular(50.0),
              ))),
          onPressed: widget.disableButton == true ? null : widget.onPress,
          child: widget.child),
    );
  }
}

class MyOutlineButton extends StatefulWidget {
  final double elevation;
  final Color buttonColor;
  final Function() onPress;
  final Widget child;
  final double borderWidth;
  final Color borderColor;
  const MyOutlineButton(
      {super.key,
      required this.buttonColor,
      required this.child,
      required this.elevation,
      required this.onPress,
      required this.borderColor,
      required this.borderWidth});

  @override
  State<MyOutlineButton> createState() => _MyOutlineButtonState();
}

class _MyOutlineButtonState extends State<MyOutlineButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            elevation: WidgetStateProperty.all(widget.elevation),
            backgroundColor: WidgetStateProperty.all<Color>(widget.buttonColor),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              side: BorderSide(
                  width: widget.borderWidth, color: widget.borderColor),
              borderRadius: BorderRadius.circular(15.0),
            ))),
        onPressed: widget.onPress,
        child: widget.child);
  }
}
