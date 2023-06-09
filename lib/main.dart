import 'package:barclays_onboarding/constants.dart';
import 'package:barclays_onboarding/screens/get_started.dart';
import 'package:barclays_onboarding/screens/homepage.dart';
import 'package:barclays_onboarding/screens/under_process.dart';
import 'package:barclays_onboarding/screens/upload_file.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("hoursBox");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var _myBox = Hive.box("hoursBox");
    var status = _myBox.get(kStatus);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Barclay's On-boarding",
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.nunitoTextTheme(),
      ),
      home: (status == "underVerification") ? UnderProcessPage() : getStarted(),
    );
  }
}
