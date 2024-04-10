import 'package:flutter/material.dart';

class AlertBox extends StatelessWidget {
  const AlertBox({super.key, required this.alertTitle, required this.text});
  final String alertTitle;
  final String text;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(alertTitle),content: Text(text),
    );
  }
}