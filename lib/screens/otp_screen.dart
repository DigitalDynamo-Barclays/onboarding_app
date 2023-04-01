import 'package:barclays_onboarding/constants.dart';
import 'package:barclays_onboarding/screens/email_verify.dart';
import 'package:barclays_onboarding/screens/under_process.dart';
import 'package:barclays_onboarding/services/media_service.dart';
import 'package:barclays_onboarding/widgets/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class OtpVerification extends StatefulWidget {
  final String type;
  final String otp;
  final String data;
  const OtpVerification(
      {super.key, required this.type, required this.otp, required this.data});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final _myBox = Hive.box("hoursBox");
  @override
  Widget build(BuildContext context) {
    double textscale = MediaQuery.of(context).textScaleFactor;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    //TextEditingController emailController = TextEditingController();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'OTP Verification',
            style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 37 * textscale,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.start,
          ),
          Text(
            "Enter the OTP that you've received!",
            style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 14 * textscale,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: height * 80 / 892,
          ),
          OtpTextField(
            numberOfFields: 6,
            borderColor: Color(0xFF512DA8),
            //set to true to show as box or false to show as dash
            showFieldAsBox: true,
            //runs when a code is typed in
            onCodeChanged: (String code) {
              //handle validation or checks here
            },
            //runs when every textfield is filled
            onSubmit: (String verificationCode) async {
              print("sdlfajasldkf");
              print(verificationCode + widget.otp);
              if (verificationCode == widget.otp.toString() &&
                  widget.type == "Phone") {
                showSnackBar(
                  context,
                  "OTP verified successfully! Phone number saved.",
                  Colors.green.shade600,
                );
                await _myBox.put(kPhone, widget.data);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => VerifyPage(type: "Email"),
                  ),
                );
              } else if (verificationCode == widget.otp &&
                  widget.type == "Email") {
                showSnackBar(
                  context,
                  "OTP verified successfully! Email saved.",
                  Colors.green.shade600,
                );
                await _myBox.put(kEmail, widget.data);
                var mobile = await _myBox.get(kPhone);
                var uid = await _myBox.get(kUid);
                var response = await MediaService().post('/contact-info/${uid}',
                    {"phone": "$mobile", "email": "${widget.data}"});
                _myBox.put(kStatus, "underVerification");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => UnderProcessPage(),
                  ),
                );
              }
            }, // end onSubmit
          ),
        ],
      ),
    );
  }
}
