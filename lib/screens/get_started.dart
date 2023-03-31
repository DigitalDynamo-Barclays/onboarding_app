// ignore_for_file: camel_case_types

import 'package:barclays_onboarding/constants/buttons.dart';
import 'package:barclays_onboarding/screens/upload_selector.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Country {
  final String name;
  final String flag;

  Country(this.name, this.flag);
}

class getStarted extends StatefulWidget {
  const getStarted({super.key});

  @override
  State<getStarted> createState() => _getStartedState();
}

class _getStartedState extends State<getStarted> {
  List<Country> _countries = [
    Country('India', '🇮🇳'),
    Country('UK', '🇬🇧'),
  ];

  late Country _selectedCountry = _countries[0];

  @override
  Widget build(BuildContext context) {
    double textscale = MediaQuery.of(context).textScaleFactor;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Stack(
              children: [
                Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      end: Alignment.bottomCenter,
                      begin: Alignment.topCenter,
                      colors: [
                        Color(0xff060f1b).withOpacity(0.0),
                        Color(0xff060f1b).withOpacity(0.0),
                        Color(0xff060f1b).withOpacity(0.0),
                        Color(0xff060f1b).withOpacity(0.0),
                        Color(0xff060f1b).withOpacity(0.0),
                        Color(0xff060f1b).withOpacity(0.0),
                        Color(0xff060f1b).withOpacity(0.0),
                        Color(0xff060f1b).withOpacity(0.5),
                        Color(0xff060f1b).withOpacity(0.7),
                        Color(0xff060f1b),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(
                              color: Color(0x7F819299),
                              borderRadius: BorderRadius.circular(16)),
                          // height: height * 30 / 640,
                          child: DropdownButton<Country>(
                            underline: null,
                            isDense: true,
                            dropdownColor: const Color(0x7F819299),
                            hint: const Text('Country'),
                            value: _selectedCountry,
                            onChanged: (Country? newValue) {
                              setState(() {
                                _selectedCountry = newValue!;
                              });
                            },
                            items: _countries.map((Country country) {
                              return DropdownMenuItem<Country>(
                                value: country,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      country.flag,
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10 * textscale),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(width: 10),
                                    const VerticalDivider(
                                      thickness: 1.5,
                                      width: 0,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      country.name,
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10 * textscale),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 84 / 640,
                      width: width * 270 / 360,
                      child: Image.asset('assets/images/namelogo.png'),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Welcome',
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 40 * textscale,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Managing your finances has \n never been easier',
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 20 * textscale,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    button1(
                      height,
                      width,
                      textscale,
                      'Get Started',
                      Colors.white,
                      Colors.blue,
                      () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectionPage(
                                countryName: _selectedCountry.name),
                          ),
                        );
                      },
                    ),
                    TextButton(
                      onPressed: null,
                      child: Text(
                        'Import existing account',
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: textscale * 14,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: height * 62 / 640),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
