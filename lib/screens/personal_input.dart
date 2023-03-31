import 'package:barclays_onboarding/models/aadhaar_data.dart';
import 'package:barclays_onboarding/screens/address_input.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../constants.dart';

class AccountType {
  final String name;

  AccountType(this.name);
}

class PersonalInputPage extends StatefulWidget {
  final AadhaarData? aadhaarData;
  const PersonalInputPage({super.key, this.aadhaarData});

  @override
  State<PersonalInputPage> createState() => _PersonalInputPageState();
}

class _PersonalInputPageState extends State<PersonalInputPage> {
  final _myBox = Hive.box("hoursBox");
  DateTime? _selectedDate;
  TextEditingController name = TextEditingController();
  TextEditingController dob = TextEditingController();

  List<AccountType> _accType = [
    AccountType('Select Account'),
    AccountType('Savings'),
    AccountType('Personal'),
    AccountType('Joint')
  ];

  late AccountType _selectedAccount = _accType[0];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.aadhaarData != null) {
      name.text = widget.aadhaarData!.name;
      dob.text = widget.aadhaarData!.dob;
    }
  }

  @override
  Widget build(BuildContext context) {
    double textscale = MediaQuery.of(context).textScaleFactor;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
              'Edit Profile',
              style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 37 * textscale,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Full Name',
              style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 14 * textscale,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
              alignment: Alignment.center,
              width: width,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromRGBO(0, 118, 181, 1), width: 3),
                  borderRadius: BorderRadius.circular(16)),
              child: TextFormField(
                  controller: name,
                  keyboardType: TextInputType.name,
                  decoration: kInputDecoration.copyWith(hintText: "Your Name")),
            ),
            SizedBox(height: 30),
            Text(
              'Date of Birth',
              style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 14 * textscale,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
              alignment: Alignment.center,
              width: width,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromRGBO(0, 118, 181, 1), width: 3),
                  borderRadius: BorderRadius.circular(16)),
              child: TextFormField(
                controller: dob,
                readOnly: true,
                keyboardType: TextInputType.name,
                decoration: kInputDecoration.copyWith(
                  contentPadding: EdgeInsets.zero,
                  suffix: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.calendar_month),
                    onPressed: () {
                      DatePicker.showDatePicker(
                        context,
                        showTitleActions: true,
                        minTime: DateTime(1900, 1, 1),
                        maxTime: DateTime.now(),
                        onConfirm: (date) {
                          setState(() {
                            _selectedDate = date;
                          });
                        },
                        currentTime: DateTime.now(),
                        locale: LocaleType.en,
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Type of Account',
              style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 14 * textscale,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            Container(
              width: width,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromRGBO(0, 118, 181, 1), width: 3),
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: DropdownButton<AccountType>(
                  underline: null,
                  isExpanded: true,
                  isDense: true,
                  dropdownColor: Colors.white,
                  hint: const Text('Select Account'),
                  value: _selectedAccount,
                  onChanged: (AccountType? newValue) {
                    _myBox.put(kAccountType, newValue);
                    setState(() {
                      _selectedAccount = newValue!;
                    });
                  },
                  items: _accType.map((AccountType _accType) {
                    return DropdownMenuItem<AccountType>(
                      value: _accType,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          _accType.name,
                          style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 13 * textscale),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: height * 48 / 892),
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => AddressInputPage(),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
