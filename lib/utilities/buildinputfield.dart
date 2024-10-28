import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildInputField(
    {required String label,
    String? hintText,
    bool obscureText = false,
    required TextInputType inputType,
    int? maxWords,
    required TextEditingController controller}) {
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
            buildCounter: (
              BuildContext context, {
              required int currentLength,
              required int? maxLength,
              required bool isFocused,
            }) {
              return null;
            },
            controller: controller,
            keyboardType: keyboardType,
            style: GoogleFonts.poppins(
              color: const Color(0xFFFEFCEE),
              fontWeight: FontWeight.bold,
            ),
            maxLength: maxWords,
            obscureText: obscureText,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.transparent,
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(
                color: const Color(0xFFFEFCEE),
                fontSize: 14,
                fontWeight: FontWeight.bold,
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
