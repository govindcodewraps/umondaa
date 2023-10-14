import 'package:flutter/material.dart';

var this_year = DateTime.now().year.toString();

class AppConfig {
  static String copyright_text =
      "@ ActiveItZone " + this_year; //this shows in the splash screen
  static String app_name = "Umonda"; //this shows in the splash screen
  //static String purchase_code = "ad293f46-417c-4357-a54e-fd3ac9d22ff8";


  static String purchase_code = "a94b130c-1ffa-4a1a-818a-77ff4adb4bfd";
  //enter your purchase code for the app from codecanyon
  //static String purchase_code = ""; //enter your purchase code for the app from codecanyon

  //Default language config
  static String default_language = "en";
  static String mobile_app_code = "en";
  static bool app_language_rtl = false;

  //configure this
  static const bool HTTPS = false;

 // static const DOMAIN_PATH = "192.168.6.1/ecommerce"; //localhost
  //static const DOMAIN_PATH = "https://hardwarelo.com"; //localhost


       static const DOMAIN_PATH = "https://umonda.com"; //localhost
       //static const DOMAIN_PATH = "https://webcluestechnology.com/demo/erp/umonda"; //localhost

// directly inside the public folder

  //do not configure these below
  static const String API_ENDPATH = "api/v2";
  static const String PROTOCOL = HTTPS ? "https://" : "http://";
  static const String RAW_BASE_URL = "${DOMAIN_PATH}";
  static const String BASE_URL = "${RAW_BASE_URL}/${API_ENDPATH}";

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}
