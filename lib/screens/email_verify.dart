import 'package:barclays_onboarding/constants.dart';
import 'package:barclays_onboarding/constants/buttons.dart';
import 'package:barclays_onboarding/screens/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailVerifyPage extends StatefulWidget {
  const EmailVerifyPage({super.key});

  @override
  State<EmailVerifyPage> createState() => _EmailVerifyPageState();
}

class _EmailVerifyPageState extends State<EmailVerifyPage> {
  @override
  Widget build(BuildContext context) {
    double textscale = MediaQuery.of(context).textScaleFactor;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    TextEditingController emailController = TextEditingController();

    routeVerifyEmail() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OtpVerification()));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email\nVerification',
              style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 37 * textscale,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.start,
            ),
            Text(
              'We will send an email with a verification \ncode on this email id',
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
                controller: emailController,
                keyboardType: TextInputType.name,
                decoration: kInputDecoration.copyWith(
                  hintText: 'Enter your Email Id',
                ),
              ),
            ),
            SizedBox(height: 30),
            button1(
                height,
                width,
                textscale,
                'Verify Email',
                Color.fromRGBO(0, 118, 181, 1),
                Colors.white,
                routeVerifyEmail())
          ],
        ),
      ),
    );
  }
}
