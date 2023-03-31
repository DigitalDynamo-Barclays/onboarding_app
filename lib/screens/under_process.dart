import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class UnderProcessPage extends StatefulWidget {
  const UnderProcessPage({super.key});

  @override
  State<UnderProcessPage> createState() => _UnderProcessPageState();
}

class _UnderProcessPageState extends State<UnderProcessPage> {
  @override
  Widget build(BuildContext context) {
    double textscale = MediaQuery.of(context).textScaleFactor;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/verify_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height * 220 / 640),
            Text(
              'Verification\nunder process',
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 26 * textscale,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              "This may take a while, we're verifying \nyour details",
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 16 * textscale,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
            Spacer(),
            LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.white, size: 35),
            SizedBox(height: height * 55 / 640),
          ],
        ),
      ),
    );
  }
}
