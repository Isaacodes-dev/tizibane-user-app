import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BulletPoint extends StatelessWidget {
  final String qualificationText;
  const BulletPoint({super.key, required this.qualificationText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "• ",
            style: TextStyle(fontSize: 20.0),
          ),
          Expanded(
            child: Text(
              qualificationText,
              style: GoogleFonts.lexendDeca(
                textStyle: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
