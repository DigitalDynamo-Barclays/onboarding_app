import 'dart:io';

import 'package:barclays_onboarding/constants.dart';
import 'package:barclays_onboarding/models/aadhaar_data.dart';
import 'package:barclays_onboarding/screens/email_verify.dart';
import 'package:barclays_onboarding/screens/loading_page.dart';
import 'package:barclays_onboarding/services/media_service.dart';
import 'package:barclays_onboarding/widgets/show_snack_bar.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

class GetDocument extends StatefulWidget {
  const GetDocument({Key? key}) : super(key: key);

  @override
  State<GetDocument> createState() => _GetDocumentState();
}

class _GetDocumentState extends State<GetDocument> {
  final _myBox = Hive.box("hoursBox");
  late String country;
  File? file;
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    country = _myBox.get(kSelectedCountry);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var textscale = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !loading,
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: (loading)
          ? LoadingPage()
          : SizedBox(
              height: height,
              width: width,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Great!',
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 37 * textscale,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        'Upload your ${(country == "UK") ? "BRP" : "PAN"} card to continue verification',
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 16 * textscale,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: height * 80 / 892,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();

                            if (result != null) {
                              if (result.files.single.extension != 'pdf') {
                                file = File(result.files.single.path!);
                                setState(() {});
                              } else {
                                showSnackBar(
                                  context,
                                  "Wrong file, please select other than a pdf!",
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
                          child: Container(
                            height: height * 220 / 892,
                            width: width * 220 / 412,
                            decoration: BoxDecoration(
                              border: Border.all(color: kPrimaryColor),
                              borderRadius: BorderRadius.circular(16),
                              color: kPrimaryColor.withOpacity(0.1),
                            ),
                            child: (file != null)
                                ? Center(
                                    child: Text(
                                      file!.path.toString().split('/')[file!
                                              .path
                                              .toString()
                                              .split('/')
                                              .length -
                                          1],
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                : Icon(
                                    CupertinoIcons.arrow_up_doc,
                                    size: 64,
                                    color: kSecondaryColor,
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 100 / 892,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xff0679B7)),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                horizontal: 0,
                                vertical: 20,
                              ),
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              loading = true;
                            });
                            AadhaarData aadhaarData = AadhaarData.fromJson(
                                await _myBox.get(kDetails));
                            var name = aadhaarData.name.toString();
                            if (file == null) {
                              showSnackBar(
                                context,
                                "Please add a file!",
                                Colors.red.shade700,
                              );
                            } else {
                              String fileName = file!.path
                                      .toString()
                                      .split('/')[
                                  file!.path.toString().split('/').length - 1];
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
                                (country == "India")
                                    ? "https://api.mindee.net/v1/products/Utkarsh3012/pan_card/v1/predict"
                                    : "https://api.mindee.net/v1/products/Utkarsh3012/british_residence_permit/v1/predict",
                                data: formData,
                                options: Options(
                                  headers: {
                                    "Authorization":
                                        "b99503ae6741c730db66da45e7bb2767"
                                  },
                                ),
                              );
                              // print(response.data["document"]["inference"]
                              //             ['prediction']["name"]["values"][0]
                              //         ["content"] +
                              //     response.data["document"]["inference"]
                              //             ['prediction']["name"]["values"][1]
                              //         ["content"]);
                              var predictedName = (country == "India")?response.data["document"]
                              ["inference"]['prediction']["name"]
                              ["values"][0]["content"] +
                                  " " +
                                  response.data["document"]["inference"]
                                  ['prediction']["name"]["values"][1]
                                  ["content"]:response.data["document"]
                              ["inference"]['prediction']["name"]
                              ["values"][1]["content"] +
                                  " " +
                                  response.data["document"]["inference"]
                                  ['prediction']["name"]["values"][0]
                                  ["content"];
                              var confidence = dpStringMatch(
                                name.toString().toLowerCase(),
                                predictedName.toString().toLowerCase(),
                              );
                              print(confidence);
                              if (confidence >= 0.6) {
                                showSnackBar(
                                  context,
                                  "Document verification succesful!",
                                  Colors.green.shade600,
                                );
                                var uid = _myBox.get(kUid);
                                FormData formData = new FormData.fromMap({
                                  'file': await MultipartFile.fromFile(
                                      file!.path,
                                      filename: fileName,
                                      contentType: MediaType(mimee, type))
                                });
                                var response = await Dio().post(
                                  "https://onboardingbackend.up.railway.app/onboarding/id-img/$uid",
                                  data: formData,
                                  options: Options(
                                    headers: {
                                      "Authorization":
                                          "b99503ae6741c730db66da45e7bb2767"
                                    },
                                  ),
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (builder) => VerifyPage(
                                      type: "Phone",
                                    ),
                                  ),
                                );
                              } else {
                                showSnackBar(
                                  context,
                                  "Document not verified, please try again!",
                                  Colors.red.shade600,
                                );
                              }
                              setState(() {
                                loading = false;
                              });
                            }
                          },
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 80 / 892,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

double dpStringMatch(String str1, String str2) {
  int m = str1.length;
  int n = str2.length;

  // Create a 2D array to store the lengths of the longest common suffixes
  // of substrings. The (i, j)th entry of this array stores the length of the
  // longest common suffix of str1[0..i-1] and str2[0..j-1].
  List<List<int>> dp = List.generate(m + 1, (_) => List<int>.filled(n + 1, 0));

  // Initialize the length of the longest common suffix to zero for all
  // possible combinations of substrings.
  int maxLength = 0;

  // Update the entries of the 2D array based on the recurrence relation
  // dp[i][j] = dp[i - 1][j - 1] + 1 if str1[i - 1] == str2[j - 1], otherwise
  // dp[i][j] = 0. We also keep track of the maximum length of a common substring
  // seen so far.
  for (int i = 1; i <= m; i++) {
    for (int j = 1; j <= n; j++) {
      if (str1[i - 1] == str2[j - 1]) {
        dp[i][j] = dp[i - 1][j - 1] + 1;
        maxLength = maxLength > dp[i][j] ? maxLength : dp[i][j];
      } else {
        dp[i][j] = 0;
      }
    }
  }

  // Return the length of the longest common substring.
  return maxLength / m;
}
