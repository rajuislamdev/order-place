import 'package:flutter/material.dart';

class QuantityButton extends StatelessWidget {
  final bool isIncrement;
  final void Function()? onPressed;
  const QuantityButton(
      {super.key, required this.isIncrement, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border:
                Border.all(width: 1, color: Theme.of(context).primaryColor)),
        child: Icon(
          isIncrement ? Icons.add : Icons.remove,
          color: isIncrement ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
