import 'dart:io';

import 'package:barclays_onboarding/constants/buttons.dart';
import 'package:barclays_onboarding/models/aadhaar_data.dart';
import 'package:barclays_onboarding/screens/personal_input.dart';
import 'package:barclays_onboarding/widgets/show_snack_bar.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mime_type/mime_type.dart';
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
      backgroundColor: Color(0xff0076b5),
      body: Stack(
        children: [
          Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset("assets/images/signup_image.png")),
          Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 100 / 892,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Let's Sign You Up!",
                    style: GoogleFonts.montserrat(
                      color: const Color(0xffFCFCFE),
                      fontWeight: FontWeight.w500,
                      fontSize: 28 * textscale,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: (widget.countryName == "India")
                      ? button2(
                          height,
                          width,
                          textscale,
                          'Scan Aadhaar',
                          CupertinoIcons.qrcode_viewfinder,
                          const Color(0xff06b1ea),
                          Colors.white,
                          () async {
                            String barcodeScanRes;
                            try {
                              barcodeScanRes =
                                  await FlutterBarcodeScanner.scanBarcode(
                                '#00aeef',
                                'Cancel',
                                true,
                                ScanMode.QR,
                              );
                            } on PlatformException {
                              barcodeScanRes =
                                  'Failed to get platform version.';
                            }
                            print(barcodeScanRes);
                            if (!mounted) return;
                            final data = XmlDocument.parse(barcodeScanRes);
                            var document =
                                data.getElement("PrintLetterBarcodeData")!;
                            var uid = document.getAttribute("uid");
                            print("uid");
                            print(uid);
                            if (RegExp(r"^\d{4}\d{4}\d{4}$")
                                .hasMatch(uid.toString())) {
                              AadhaarData data = AadhaarData(
                                uid: uid.toString(),
                                name: document.getAttribute("name").toString(),
                                gender:
                                    document.getAttribute("gender").toString(),
                                house:
                                    document.getAttribute("house").toString(),
                                state:
                                    document.getAttribute("state").toString(),
                                street:
                                    document.getAttribute("street").toString(),
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
                        )
                      : Column(
                          children: [
                            button2(
                              height,
                              width,
                              textscale,
                              'Upload Electricity Bill',
                              null,
                              const Color(0xff06b1ea),
                              Colors.white,
                              () async {
                                File? file;
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles();

                                if (result != null) {
                                  if (result.files.single.extension == 'pdf') {
                                    file = File(result.files.single.path!);
                                    String fileName = file!.path
                                        .toString()
                                        .split('/')[file!.path
                                            .toString()
                                            .split('/')
                                            .length -
                                        1];
                                    String mimeType = mime(fileName)!;
                                    print(mimeType);
                                    String mimee = mimeType.split('/')[0];
                                    String type = mimeType.split('/')[1];
                                    FormData formData = new FormData.fromMap({
                                      'document': await MultipartFile.fromFile(
                                          file!.path,
                                          filename: fileName,
                                          contentType: MediaType(mimee, type))
                                    });
                                    var response = await Dio().post(
                                      "https://api.mindee.net/v1/products/mindee/proof_of_address/v1/predict",
                                      data: formData,
                                      options: Options(
                                        headers: {
                                          "Authorization":
                                              "b99503ae6741c730db66da45e7bb2767"
                                        },
                                      ),
                                    );
                                    print(response.data["document"]["inference"]
                                        ["prediction"]);
                                  } else {
                                    showSnackBar(
                                      context,
                                      "Wrong file, please select a pdf!",
                                      Colors.red.shade700,
                                    );
                                  }
                                } else {
                                  showSnackBar(
                                    context,
                                    "Unable to get file, user cancelled!",
                                    Colors.red.shade700,
                                  );
                                }
                              },
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            button2(
                              height,
                              width,
                              textscale,
                              'Upload Driving License',
                              null,
                              const Color(0xff06b1ea),
                              Colors.white,
                              () {},
                            ),
                          ],
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
                        color: Colors.white70,
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
                    Colors.white,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PersonalInputPage(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 40 / 892,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
