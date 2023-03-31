import 'package:barclays_onboarding/constants/buttons.dart';
import 'package:barclays_onboarding/models/aadhaar_data.dart';
import 'package:barclays_onboarding/screens/personal_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xml/xml.dart';

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
                CupertinoIcons.qrcode_viewfinder,
                const Color.fromRGBO(0, 118, 181, 1),
                Colors.white,
                () async {
                  String barcodeScanRes;
                  try {
                    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                      '#00aeef',
                      'Cancel',
                      true,
                      ScanMode.QR,
                    );
                  } on PlatformException {
                    barcodeScanRes = 'Failed to get platform version.';
                  }
                  print(barcodeScanRes);
                  if (!mounted) return;
                  final data = XmlDocument.parse(barcodeScanRes);
                  var document = data.getElement("PrintLetterBarcodeData")!;
                  var uid = document.getAttribute("uid");
                  print("uid");
                  print(uid);
                  if (RegExp(r"^\d{4}\d{4}\d{4}$").hasMatch(uid.toString())) {
                    AadhaarData data = AadhaarData(
                      uid: uid.toString(),
                      name: document.getAttribute("name").toString(),
                      gender: document.getAttribute("gender").toString(),
                      house: document.getAttribute("house").toString(),
                      state: document.getAttribute("state").toString(),
                      street: document.getAttribute("street").toString(),
                      city: document.getAttribute("vtc").toString(),
                      area: document.getAttribute("po").toString(),
                      zip: document.getAttribute("pc").toString(),
                      dob: document.getAttribute("dob").toString(),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => PersonalInputPage(
                          aadhaarData: data,
                        ),
                      ),
                    );
                  } else {}
                },
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
                null,
                const Color.fromRGBO(0, 118, 181, 1),
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PersonalInputPage(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
