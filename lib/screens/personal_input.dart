import 'package:barclays_onboarding/screens/address_input.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../constants.dart';

class AccountType {
  final String name;

  AccountType(this.name);
}

class PersonalInputPage extends StatefulWidget {
  const PersonalInputPage({super.key});

  @override
  State<PersonalInputPage> createState() => _PersonalInputPageState();
}

class _PersonalInputPageState extends State<PersonalInputPage> {
  DateTime? _selectedDate;

  List<AccountType> _accType = [
    AccountType('Select Account'),
    AccountType('Savings Account'),
    AccountType('Personal Account'),
    AccountType('Joint Account')
  ];

  late AccountType _selectedAccount = _accType[0];
  @override
  Widget build(BuildContext context) {
    double textscale = MediaQuery.of(context).textScaleFactor;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    TextEditingController nameController = TextEditingController();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 300 / 640,
              width: width,
              child: Image.asset(
                'assets/images/profile_page.png',
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                  SizedBox(height: 5),
                  Text(
                    'Full Name',
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 14 * textscale,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                    alignment: Alignment.center,
                    width: width,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromRGBO(0, 118, 181, 1), width: 3),
                        borderRadius: BorderRadius.circular(16)),
                    child: TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        decoration:
                            kInputDecoration.copyWith(hintText: "Your Name")),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Date of Birth',
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 14 * textscale,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                    alignment: Alignment.center,
                    width: width,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromRGBO(0, 118, 181, 1), width: 3),
                        borderRadius: BorderRadius.circular(16)),
                    child: TextFormField(
                      readOnly: true,
                      keyboardType: TextInputType.name,
                      decoration: kInputDecoration.copyWith(
                        contentPadding: EdgeInsets.zero,
                        suffix: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.calendar_month,
                            color: Colors.black,
                          ),
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
                  SizedBox(height: 20),
                  Text(
                    'Type of Account',
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 14 * textscale,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),
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
                        isDense: true,
                        dropdownColor: Colors.white,
                        hint: const Text('Select Account'),
                        value: _selectedAccount,
                        onChanged: (AccountType? newValue) {
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
          ],
        ),
      ),
    );
  }
}
