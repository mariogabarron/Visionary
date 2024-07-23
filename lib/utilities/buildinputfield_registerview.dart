import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildInputField(
    {required String label,
    String? hintText,
    bool obscureText = false,
    required TextInputType inputType}) {
  TextInputType keyboardType = TextInputType.text;

  if (inputType == TextInputType.emailAddress) {
    keyboardType = TextInputType.emailAddress;
  } else if (inputType == TextInputType.visiblePassword) {
    keyboardType = TextInputType.visiblePassword;
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 50.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: const Color(0xFFFEFCEE),
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(66, 254, 252, 238),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: TextField(
            keyboardType: keyboardType,
            style: GoogleFonts.poppins(
              color: const Color(0xFFFEFCEE),
            ),
            obscureText: obscureText,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors
                  .transparent, // Make the background transparent so that the container's color is visible
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(
                color: const Color.fromARGB(255, 122, 121, 115),
                fontSize: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
