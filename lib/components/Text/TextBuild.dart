import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextBuild extends StatelessWidget {
  final String text;
  final double textSize;
  final FontWeight finalWeight;

  const TextBuild(
      {super.key,
      required this.text,
      required this.textSize,
      required this.finalWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.lexendDeca(
        textStyle: TextStyle(fontWeight: finalWeight, fontSize: textSize),
      ),
    );
  }
}
