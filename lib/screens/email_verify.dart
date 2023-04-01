import 'dart:math';

import 'package:barclays_onboarding/constants.dart';
import 'package:barclays_onboarding/constants/buttons.dart';
import 'package:barclays_onboarding/screens/loading_page.dart';
import 'package:barclays_onboarding/screens/otp_screen.dart';
import 'package:barclays_onboarding/services/media_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class VerifyPage extends StatefulWidget {
  final String type;
  const VerifyPage({super.key, required this.type});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    double textscale = MediaQuery.of(context).textScaleFactor;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    TextEditingController emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: (loading)
          ? LoadingPage()
          : Container(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.type}\nVerification',
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 37 * textscale,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    'We will send an ${widget.type.toLowerCase() == "email" ? "mail" : "message"} with a verification code on this ${(widget.type.toLowerCase() == 'email') ? "email id" : "phone number"}.',
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 14 * textscale,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                    alignment: Alignment.center,
                    width: width,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromRGBO(0, 118, 181, 1), width: 3),
                        borderRadius: BorderRadius.circular(16)),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value == "") {
                          return "Please enter value!";
                        }
                      },
                      controller: emailController,
                      keyboardType: (widget.type.toLowerCase() == 'email')
                          ? TextInputType.name
                          : TextInputType.phone,
                      decoration: kInputDecoration.copyWith(
                        hintText:
                            'Enter your ${(widget.type.toLowerCase() == 'email') ? "Email id" : "Phone number"}',
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  button1(
                    height,
                    width,
                    textscale,
                    'Verify ${widget.type}',
                    Color.fromRGBO(0, 118, 181, 1),
                    Colors.white,
                    () async {
                      setState(() {
                        loading = true;
                      });
                      var otp;
                      if (widget.type == "Phone") {
                        otp = generateOTP();
                        TwilioFlutter twilio = TwilioFlutter(
                          accountSid: "ACae417b6116dd880683ff4f98701c0124",
                          authToken: "0dd43b0e2ac91fbb7427aa27b3d620d3",
                          twilioNumber: '+14754053134',
                        );
                        await twilio.sendSMS(
                            toNumber: emailController.text,
                            messageBody: "Your OTP is ${otp}");
                      } else {
                        var response = await MediaService()
                            .get("/send-otp/${emailController.text}");
                        otp = (response as Map)["otp"];
                      }
                      setState(() {
                        loading = false;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => OtpVerification(
                            type: widget.type,
                            otp: otp.toString(),
                            data: emailController.text,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

String generateOTP() {
  var random = Random();
  int otp = random.nextInt(900000) +
      100000; // generate a random number between 100000 and 999999
  return otp.toString();
}
