import 'package:barclays_onboarding/widgets/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:barclays_onboarding/services/media_service.dart';

class APICalls {
  late final MediaService _mediaService;
  late BuildContext _context;

  APICalls(BuildContext context) {
    _mediaService = MediaService();
    _context = context;
  }

  sendPersonalInfo({
    required String name,
    required String dob,
    required String block,
    required String street,
    required String city,
    required String state,
    required String zip,
    required String country,
    required String accountType,
  }) {
    try {
      var response = _mediaService.post(
        '/personal-info',
        {
          "name": name,
          "dob": dob,
          "accountType": accountType,
          "address": {
            "block": block,
            "street": street,
            "city": city,
            "state": state,
            "zip": zip,
            "country": country
          }
        },
      );
      return response;
    } catch (e) {
      showSnackBar(
        _context,
        e.toString(),
        Colors.red,
      );
    }
  }

  sendContactInfo({required String phone, required String email}) {
    try {
      var response = _mediaService.post(
        '/personal-info',
        {"phone": phone, "email": email},
      );
      return response;
    } catch (e) {
      showSnackBar(
        _context,
        e.toString(),
        Colors.red,
      );
    }
  }
}
