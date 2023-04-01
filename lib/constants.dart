import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kAccountType = "accountType";
const kUid = "uid";
const kDetails = "details";
const kPhone = "phoneNumber";
const kEmail = "email";
const kSelectedCountry = "selectedCountry";
const kStatus = "status";

const kPrimaryColor = Color(0xFF00aeef);
const kSecondaryColor = Color(0xFF00395d);
const kTertiaryColor = Color(0xFFFFFFFF);

var kInputDecoration = InputDecoration(
  hintText: 'YYYY/MM/DD',
  hintStyle: GoogleFonts.montserrat(
      color: Colors.black, fontSize: 13, fontWeight: FontWeight.w500),
  floatingLabelBehavior: FloatingLabelBehavior.never,
);
