import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget button1(height, width, textscale, text, color1, color2, route) {
  return GestureDetector(
    onTap: route,
    child: Container(
      height: height * 40 / 640,
      width: width * 313 / 360,
      decoration: BoxDecoration(
        color: color1,
        borderRadius: BorderRadius.circular(16),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: GoogleFonts.montserrat(
            color: color2,
            fontSize: textscale * 17,
            fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget button2(height, width, textscale, text, icon, color1, color2, route) {
  return GestureDetector(
    onTap: route,
    child: Container(
      height: height * 61 / 640,
      width: width * 357 / 360,
      decoration: BoxDecoration(
        color: color1,
        borderRadius: BorderRadius.circular(16),
        border: (color1 == null)
            ? Border.all(
                width: 2,
                color: color2,
              )
            : null,
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: color2,
              size: textscale * 30,
            ),
            SizedBox(width: 10),
          ] else
            SizedBox(),
          Text(
            text,
            style: GoogleFonts.montserrat(
                color: color2,
                fontSize: textscale * 18,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
