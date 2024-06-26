import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubmitButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  const SubmitButton({super.key,   
  this.onTap,
  required this.text});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        width: width,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          )
        ),
      )
    );
  }
}