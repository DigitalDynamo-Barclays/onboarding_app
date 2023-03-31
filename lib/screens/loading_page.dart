import 'package:barclays_onboarding/constants.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height * 80 / 640),
            SizedBox(
              height: height * 108 / 640,
              width: width * 101 / 360,
              child: Image.asset("assets/images/logo.png"),
            ),
            SizedBox(height: height * 180 / 640),
            const CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
