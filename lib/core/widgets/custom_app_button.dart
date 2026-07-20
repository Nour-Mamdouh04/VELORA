import 'package:flutter/material.dart';

class CustomAppButton extends StatelessWidget {
  const CustomAppButton({
    super.key,
    this.onPress,
    required this.title,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.borderRadius = 30,
    this.fontWeight = FontWeight.normal,
    this.borderSide = BorderSide.none,
    this.icon,
  });

  final VoidCallback? onPress;
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final FontWeight fontWeight;
  final BorderSide borderSide;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 355,
      height: 60,
      child: FilledButton(
        style: FilledButton.styleFrom(
          side: borderSide,
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[icon!, const SizedBox(width: 10)],
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontFamily: "DMSans",
                fontWeight: fontWeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
