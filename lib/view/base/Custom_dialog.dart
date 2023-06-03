// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:place_order/view/base/custom_button.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String buttonText;
  final String imagePath;
  final void Function() onTap;
  const CustomDialog({
    Key? key,
    required this.title,
    required this.buttonText,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 60,
              width: 60,
            ),
            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            CustomButton(
              width: 200,
              buttonText: 'Okay',
              onPressed: onTap,
            ),
          ],
        ),
      ),
    );
  }
}
