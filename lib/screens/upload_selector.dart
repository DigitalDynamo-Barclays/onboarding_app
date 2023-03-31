import 'package:barclays_onboarding/constants/buttons.dart';
import 'package:barclays_onboarding/screens/get_started.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectionPage extends StatefulWidget {
  final String countryName;
  const SelectionPage({super.key, required this.countryName});

  @override
  State<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double textscale = MediaQuery.of(context).textScaleFactor;

    routeScanner() {
      /*Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ));*/
    }
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Let's Sign You Up!",
                style: GoogleFonts.montserrat(
                  color: const Color.fromRGBO(0, 118, 181, 1),
                  fontWeight: FontWeight.w500,
                  fontSize: 32 * textscale,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: height * 60 / 640),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: button2(
                height,
                width,
                textscale,
                (widget.countryName == 'India') ? 'Scan Aadhaar' : 'Scan BRP',
                Icons.qr_code_scanner,
                const Color.fromRGBO(0, 118, 181, 1),
                Colors.white,
                routeScanner(),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: Row(children: <Widget>[
                const Expanded(
                  child: Divider(
                    indent: 30,
                    thickness: 2,
                    color: Colors.black,
                    endIndent: 15,
                  ),
                ),
                Text(
                  "OR",
                  style: GoogleFonts.montserrat(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 12 * textscale,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Expanded(
                  child: Divider(
                    indent: 15,
                    thickness: 2,
                    color: Colors.black,
                    endIndent: 30,
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: button2(
                height,
                width,
                textscale,
                'Add Manually',
                null,
                const Color.fromRGBO(0, 118, 181, 1),
                Colors.white,
                routeScanner(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
