import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  const SubmitButton({super.key,   
  this.onTap,
  required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        width: 300,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 2, 47, 83),
          borderRadius: BorderRadius.circular(9),
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