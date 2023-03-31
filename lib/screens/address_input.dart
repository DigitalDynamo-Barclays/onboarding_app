import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../constants.dart';

class AccountType {
  final String name;

  AccountType(this.name);
}

class Country {
  final String name;
  final String flag;

  Country(this.name, this.flag);
}

class AddressInputPage extends StatefulWidget {
  const AddressInputPage({super.key});

  @override
  State<AddressInputPage> createState() => _AddressInputPageState();
}

class _AddressInputPageState extends State<AddressInputPage> {
  DateTime? _selectedDate;

  List<AccountType> _accType = [
    AccountType('Select Account'),
    AccountType('Savings'),
    AccountType('Personal'),
    AccountType('Joint')
  ];

  late AccountType _selectedAccount = _accType[0];

  List<Country> _countries = [
    Country('India', '🇮🇳'),
    Country('UK', '🇬🇧'),
  ];

  late Country _selectedCountry = _countries[0];

  @override
  Widget build(BuildContext context) {
    double textscale = MediaQuery.of(context).textScaleFactor;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    TextEditingController nameController = TextEditingController();
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
              'Address',
              style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 37 * textscale,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'House no. / Apartment',
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
                controller: nameController,
                keyboardType: TextInputType.name,
                decoration: kInputDecoration.copyWith(
                  hintText: 'House no.',
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Street / Area',
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
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: 'Area',
                  hintStyle: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 13 * textscale,
                      fontWeight: FontWeight.w500),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width / 2.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'City',
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 14 * textscale,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromRGBO(0, 118, 181, 1),
                                width: 3),
                            borderRadius: BorderRadius.circular(16)),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: 'City',
                            hintStyle: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 13 * textscale,
                                fontWeight: FontWeight.w500),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width / 2.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Postcode',
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 14 * textscale,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromRGBO(0, 118, 181, 1),
                                width: 3),
                            borderRadius: BorderRadius.circular(16)),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: 'Postcode',
                            hintStyle: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 13 * textscale,
                                fontWeight: FontWeight.w500),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width / 2.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'State',
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 14 * textscale,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromRGBO(0, 118, 181, 1),
                                width: 3),
                            borderRadius: BorderRadius.circular(16)),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: 'State',
                            hintStyle: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 13 * textscale,
                                fontWeight: FontWeight.w500),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width / 2.5,
                  height: height * 40 / 640,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Country',
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 14 * textscale,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromRGBO(0, 118, 181, 1),
                                width: 3),
                            borderRadius: BorderRadius.circular(16)),
                        child: DropdownButton<Country>(
                          underline: null,
                          isDense: true,
                          dropdownColor: const Color(0x7F819299),
                          hint: const Text('Country'),
                          value: _selectedCountry,
                          onChanged: (Country? newValue) {
                            setState(() {
                              _selectedCountry = newValue!;
                            });
                          },
                          items: _countries.map((Country country) {
                            return DropdownMenuItem<Country>(
                              value: country,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    country.flag,
                                    style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12 * textscale),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(width: 10),
                                  const VerticalDivider(
                                    thickness: 1.5,
                                    width: 0,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    country.name,
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10 * textscale),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
                    print("YHESLH");
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
