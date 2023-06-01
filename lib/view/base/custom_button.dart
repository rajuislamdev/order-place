import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function() onPressed;
  final String buttonText;
  final bool transparent;
  final double height;
  final double width;
  final double radius;
  const CustomButton({
    required this.onPressed,
    required this.buttonText,
    this.transparent = false,
    this.width = 200,
    this.height = 42,
    this.radius = 12,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.primary,
      minimumSize: Size(width, height),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );

    return Center(
      child: SizedBox(
        width: width,
        child: TextButton(
          onPressed: onPressed,
          style: flatButtonStyle,
          child: Center(
            child: Text(
              buttonText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
