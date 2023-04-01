import 'package:barclays_onboarding/models/aadhaar_data.dart';
import 'package:barclays_onboarding/screens/loading_page.dart';
import 'package:barclays_onboarding/screens/upload_file.dart';
import 'package:barclays_onboarding/services/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
  final AadhaarData? aadhaarData;
  const AddressInputPage({super.key, this.aadhaarData});

  @override
  State<AddressInputPage> createState() => _AddressInputPageState();
}

class _AddressInputPageState extends State<AddressInputPage> {
  final _myBox = Hive.box("hoursBox");
  DateTime? _selectedDate;
  bool loading = false;

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
  GlobalKey<FormState> form = GlobalKey<FormState>();
  TextEditingController houseController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController postController = TextEditingController();
  setCountry() async {
    var country = await _myBox.get(kSelectedCountry);
    if (country.toString().toLowerCase() == 'india') {
      _selectedCountry = _countries[0];
    } else {
      _selectedCountry = _countries[1];
    }

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCountry();
    if (widget.aadhaarData != null) {
      houseController.text = widget.aadhaarData!.house.toString();
      areaController.text = widget.aadhaarData!.street.toString() +
          " " +
          widget.aadhaarData!.area.toString();
      cityController.text = widget.aadhaarData!.city.toString();
      postController.text = widget.aadhaarData!.zip.toString();
      stateController.text = widget.aadhaarData!.state.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    double textscale = MediaQuery.of(context).textScaleFactor;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: !loading,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: (loading)
          ? LoadingPage()
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Image.asset(
                    'assets/images/address_page.png',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    transform: Matrix4.translationValues(0, -80, 0),
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                    child: Form(
                      key: form,
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
                                    color: Color.fromRGBO(0, 118, 181, 1),
                                    width: 3),
                                borderRadius: BorderRadius.circular(16)),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value == "") {
                                  return "Please enter value!";
                                }
                              },
                              controller: houseController,
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
                                    color: Color.fromRGBO(0, 118, 181, 1),
                                    width: 3),
                                borderRadius: BorderRadius.circular(16)),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value == "") {
                                  return "Please enter value!";
                                }
                              },
                              controller: areaController,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                hintText: 'Area',
                                hintStyle: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 13 * textscale,
                                    fontWeight: FontWeight.w500),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
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
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 10, 0),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color.fromRGBO(
                                                  0, 118, 181, 1),
                                              width: 3),
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value == "") {
                                            return "Please enter value!";
                                          }
                                        },
                                        controller: cityController,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          hintText: 'City',
                                          hintStyle: GoogleFonts.montserrat(
                                              color: Colors.black,
                                              fontSize: 13 * textscale,
                                              fontWeight: FontWeight.w500),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
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
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 10, 0),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color.fromRGBO(
                                                  0, 118, 181, 1),
                                              width: 3),
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value == "") {
                                            return "Please enter value!";
                                          }
                                        },
                                        controller: postController,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          hintText: 'Postcode',
                                          hintStyle: GoogleFonts.montserrat(
                                              color: Colors.black,
                                              fontSize: 13 * textscale,
                                              fontWeight: FontWeight.w500),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
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
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 10, 0),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color.fromRGBO(
                                                  0, 118, 181, 1),
                                              width: 3),
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value == "") {
                                            return "Please enter value!";
                                          }
                                        },
                                        keyboardType: TextInputType.name,
                                        controller: stateController,
                                        decoration: InputDecoration(
                                          hintText: 'State',
                                          hintStyle: GoogleFonts.montserrat(
                                              color: Colors.black,
                                              fontSize: 13 * textscale,
                                              fontWeight: FontWeight.w500),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
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
                                      'Country',
                                      style: GoogleFonts.montserrat(
                                          color: Colors.black,
                                          fontSize: 14 * textscale,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color.fromRGBO(
                                                  0, 118, 181, 1),
                                              width: 3),
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: DropdownButton<Country>(
                                        underline: null,
                                        isExpanded: true,
                                        dropdownColor: const Color(0xffffffff),
                                        hint: Text(
                                          'Country',
                                          style: GoogleFonts.montserrat(
                                            color: Colors.black,
                                          ),
                                        ),
                                        value: _selectedCountry,
                                        onChanged: (Country? newValue) {
                                          setState(() {
                                            _selectedCountry = newValue!;
                                          });
                                        },
                                        items:
                                            _countries.map((Country country) {
                                          return DropdownMenuItem<Country>(
                                            value: country,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text(
                                                  country.flag,
                                                  style: GoogleFonts.montserrat(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14 * textscale),
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xff0679B7)),
                                padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                    horizontal: 0,
                                    vertical: 20,
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                if (form.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  print(widget.aadhaarData!.dob);
                                  String accountType =
                                      await _myBox.get(kAccountType);
                                  var response =
                                      await APICalls(context).sendPersonalInfo(
                                    name: widget.aadhaarData!.name.toString(),
                                    dob: widget.aadhaarData!.dob.toString(),
                                    block: widget.aadhaarData!.house.toString(),
                                    street:
                                        widget.aadhaarData!.street.toString() +
                                            " " +
                                            widget.aadhaarData!.area.toString(),
                                    city: widget.aadhaarData!.city.toString(),
                                    state: widget.aadhaarData!.state.toString(),
                                    zip: widget.aadhaarData!.zip.toString(),
                                    country: _selectedCountry.name,
                                    accountType: accountType,
                                  );
                                  await _myBox.put(kUid, response["uid"]);
                                  await _myBox.put(
                                    kDetails,
                                    widget.aadhaarData!.toJson(),
                                  );
                                  setState(() {
                                    loading = false;
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (builder) => GetDocument(),
                                    ),
                                  );
                                }
                              },
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
