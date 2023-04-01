import 'dart:ffi';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:awesome_card/awesome_card.dart';
import 'package:barclays_onboarding/constants.dart';
import 'package:barclays_onboarding/widgets/custom_credit_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  var response;
  HomePage({Key? key, required this.response}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List value = [
    [CupertinoIcons.paperplane_fill, "Transfer"],
    [CupertinoIcons.add_circled, "Top Up"],
    [CupertinoIcons.arrow_down_square, "Recieve"],
    [CupertinoIcons.qrcode_viewfinder, "Scan"],
  ];
  bool flip = false;
  @override
  Widget build(BuildContext context) {
    widget.response = widget.response as Map;
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
        ),
        child: ClipOval(
          child: FloatingActionButton(
            child: Icon(
              CupertinoIcons.add_circled_solid,
              color: Colors.white,
            ),
            backgroundColor: Color(
              0xff0076b5,
            ),
            onPressed: () {},
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        leftCornerRadius: 15,
        rightCornerRadius: 15,
        inactiveColor: Colors.grey,
        gapLocation: GapLocation.center,
        backgroundColor: Colors.white,
        icons: [
          Icons.home,
          Icons.bar_chart_outlined,
          Icons.wallet,
          Icons.account_circle_outlined,
        ],
        activeIndex: 0,
        onTap: (int) {},
      ),
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.grid_view,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.bell,
            ),
          ),
        ],
        centerTitle: true,
        title: Text(
          "My Dashboard",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 0,
        ),
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  flip = !flip;
                  setState(() {});
                },
                child: CustomCreditCard(
                    cardNumber: widget.response["accountNo"] ?? "",
                    cardExpiry: "10/25",
                    cardHolderName: widget.response["name"] ?? "",
                    cvv: "456",
                    bankName: Image.asset(
                      "assets/images/namelogo.png",
                    ),
                    cardType: CardType
                        .other, // Optional if you want to override Card Type
                    showBackSide: flip,
                    frontBackground: CardBackgrounds.custom(
                      0xFF286987,
                    ),
                    backBackground: CardBackgrounds.white,
                    showShadow: true,
                    textExpDate: 'Exp. Date',
                    textName: 'Name',
                    textExpiry: 'MM/YY'),
              ),
              SizedBox(
                height: height * 40 / 892,
              ),
              Container(
                height: height * 260 / 892,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 2,
                  children: List.generate(
                    4,
                    (index) => Container(
                      height: height * 20 / 892,
                      width: width * 100 / 468,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            color: Colors.black12,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            value[index][0],
                            color: Color(0xff0076b5),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            value[index][1],
                            style: TextStyle(
                              fontSize: 17,
                              color: Color(0xff0076b5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
