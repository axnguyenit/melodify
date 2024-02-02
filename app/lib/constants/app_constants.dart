import 'package:country_picker/country_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppConstants {
  static const termsAndConditionURL = 'https://example.com/m_terms.html';

  static double statusBarHeight = 0.0;

  static Size screenSize = const Size(0.0, 0.0);

  static const appName = 'Melodify';

  static const defaultPhoneCountryCode = kDebugMode ? '+84' : '+33';

  static const defaultDateFormat = 'dd-MM-yyyy';

  static const maximumUploadFileSize = 4 * 1024 * 1024;

  static const appPadding = 16.0;

  static const formFieldHeight = 48.0;

  static const formFieldBorderRadius = 8.0;

  static const inputContentPadding = EdgeInsets.fromLTRB(16, 12, 0, 12);

  static const defaultGalleryExtensions = ['jpg', 'png'];

  static const minLengthOfPassword = 8;

  static const smsCountDownTime = 30; // seconds

  static final defaultCountry = kDebugMode
      ? Country(
          phoneCode: '84',
          // e164_cc
          countryCode: 'VN',
          e164Sc: 0,
          geographic: true,
          level: 1,
          name: 'Vietnam',
          example: '337965469',
          displayName: 'Vietnam (VN) [+84]',
          displayNameNoCountryCode: 'Vietnam (VN)',
          e164Key: '84-VN-0',
        )
      : Country(
          phoneCode: '33',
          countryCode: 'FR',
          e164Sc: 0,
          geographic: true,
          level: 1,
          name: 'France',
          example: '612345678',
          displayName: 'France (FR) [+33]',
          displayNameNoCountryCode: 'France (FR)',
          e164Key: '33-FR-0',
        );
}
