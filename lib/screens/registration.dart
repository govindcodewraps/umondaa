import 'package:hardware_lo/app_config.dart';
import 'package:hardware_lo/custom/btn.dart';
import 'package:hardware_lo/custom/device_info.dart';
import 'package:hardware_lo/custom/google_recaptcha.dart';
import 'package:hardware_lo/my_theme.dart';
import 'package:hardware_lo/screens/common_webview_screen.dart';
import 'package:hardware_lo/ui_elements/auth_ui.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hardware_lo/custom/input_decorations.dart';
import 'package:hardware_lo/custom/intl_phone_input.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:hardware_lo/screens/otp.dart';
import 'package:hardware_lo/screens/login.dart';
import 'package:hardware_lo/custom/toast_component.dart';
import 'package:toast/toast.dart';
import 'package:hardware_lo/repositories/auth_repository.dart';
import 'package:hardware_lo/helpers/shared_value_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:validators/validators.dart';
import '../repositories/address_repository.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool _obscureText = true;
  bool _obscureText2 = true;
  String _register_by = "email"; //phone or email
  String initialCountry = 'US';

  // PhoneNumber phoneCode = PhoneNumber(isoCode: 'US', dialCode: "+1");
  var countries_code = <String>[];

  String _phone = "";
  bool _isAgree = false;
  bool _isCaptchaShowing=false;
 String googleRecaptchaKey = "";

  //controllers
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();


  @override
  void initState() {
    //on Splash Screen hide statusbar
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
    fetch_country();
  }

  fetch_country() async {
    var data = await AddressRepository().getCountryList();
    data.countries.forEach((c) => countries_code.add(c.code));
  }

  @override
  void dispose() {
    //before going to other screen show statusbar
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  onPressSignUp() async {
    var name = _nameController.text.toString();
    var email = _emailController.text.toString();
    var password = _passwordController.text.toString();
    var password_confirm = _passwordConfirmController.text.toString();

    if (name == "") {
      ToastComponent.showDialog(
          AppLocalizations.of(context).enter_your_name,
          gravity: Toast.center,
          duration: Toast.lengthLong);
      return;
    } else if (_register_by == 'email' && (email == "" || !isEmail(email))) {
      ToastComponent.showDialog(
          AppLocalizations.of(context).enter_email,
          gravity: Toast.center,
          duration: Toast.lengthLong);
      return;
    } else if (_register_by == 'phone' && _phone == "") {
      ToastComponent.showDialog(
          AppLocalizations.of(context).enter_phone_number,
          gravity: Toast.center,
          duration: Toast.lengthLong);
      return;
    } else if (password == "") {
      ToastComponent.showDialog(
          AppLocalizations.of(context).enter_password,
          gravity: Toast.center,
          duration: Toast.lengthLong);
      return;
    } else if (password_confirm == "") {
      ToastComponent.showDialog(
          AppLocalizations.of(context)
              .confirm_your_password,
          gravity: Toast.center,
          duration: Toast.lengthLong);
      return;
    } else if (password.length < 6) {
      ToastComponent.showDialog(
          AppLocalizations.of(context)
              .password_must_contain_at_least_6_characters,
          gravity: Toast.center,
          duration: Toast.lengthLong);
      return;
    } else if (password != password_confirm) {
      ToastComponent.showDialog(
          AppLocalizations.of(context)
              .passwords_do_not_match,
          gravity: Toast.center,
          duration: Toast.lengthLong);
      return;
    }

    var signupResponse = await AuthRepository().getSignupResponse(
        name,
        _register_by == 'email' ? email : _phone,
        password,
        password_confirm,
        _register_by,
        googleRecaptchaKey
    );

    if (signupResponse.result == false) {

      var message ="";
      signupResponse.message.forEach((key,value){
        value.forEach((messages){
          message +=messages+"\n";
        });
      });

      ToastComponent.showDialog(message,
          gravity: Toast.center, duration:3);
    } else {
      ToastComponent.showDialog(signupResponse.message,
          gravity: Toast.center, duration: Toast.lengthLong);
      if ((mail_verification_status.$ && _register_by == "email") ||
          _register_by == "phone") {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Otp(
            verify_by: _register_by,
            user_id: signupResponse.user_id,
          );
        }));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Login();
        }));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screen_height = MediaQuery.of(context).size.height;
    final _screen_width = MediaQuery.of(context).size.width;
    return AuthScreen.buildScreen(
        context,
        "${AppLocalizations.of(context).join_ucf} " +
            AppConfig.app_name,
        buildBody(context, _screen_width));
  }

  Column buildBody(BuildContext context, double _screen_width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: _screen_width * (3 / 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  AppLocalizations.of(context).name_ucf,
                  style: TextStyle(
                      color: MyTheme.accent_color, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  height: 36,
                  child: TextField(
                    controller: _nameController,
                    autofocus: false,
                    decoration: InputDecorations.buildInputDecoration_1(
                        hint_text: "John Doe"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  _register_by == "email"
                      ? AppLocalizations.of(context).email_ucf
                      : AppLocalizations.of(context).phone_ucf,
                  style: TextStyle(
                      color: MyTheme.accent_color, fontWeight: FontWeight.w600),
                ),
              ),
              if (_register_by == "email")
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 36,
                        child: TextField(
                          controller: _emailController,
                          autofocus: false,
                          decoration: InputDecorations.buildInputDecoration_1(
                              hint_text: "johndoe@example.com"),
                        ),
                      ),
                      otp_addon_installed.$
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  _register_by = "phone";
                                });
                              },
                              child: Text(
                                AppLocalizations.of(context)
                                    .or_register_with_a_phone,
                                style: TextStyle(
                                    color: MyTheme.accent_color,
                                    fontStyle: FontStyle.italic,
                                    decoration: TextDecoration.underline),
                              ),
                            )
                          : Container()
                    ],
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 36,
                        child: CustomInternationalPhoneNumberInput(
                          countries: countries_code,
                          onInputChanged: (PhoneNumber number) {
                            print(number.phoneNumber);
                            setState(() {
                              _phone = number.phoneNumber;
                            });
                          },
                          onInputValidated: (bool value) {
                            print(value);
                          },
                          selectorConfig: SelectorConfig(
                            selectorType: PhoneInputSelectorType.DIALOG,
                          ),
                          ignoreBlank: false,
                          autoValidateMode: AutovalidateMode.disabled,
                          selectorTextStyle:
                              TextStyle(color: MyTheme.font_grey),
                          initialValue: PhoneNumber(
                              isoCode: countries_code[0].toString()),
                          textFieldController: _phoneNumberController,
                          formatInput: true,
                          keyboardType: TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          inputDecoration:
                              InputDecorations.buildInputDecoration_phone(
                                  hint_text: "01XXX XXX XXX"),
                          onSaved: (PhoneNumber number) {
                            //print('On Saved: $number');
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _register_by = "email";
                          });
                        },
                        child: Text(
                          AppLocalizations.of(context)
                              .or_register_with_an_email,
                          style: TextStyle(
                              color: MyTheme.accent_color,
                              fontStyle: FontStyle.italic,
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  AppLocalizations.of(context).password_ucf,
                  style: TextStyle(
                      color: MyTheme.accent_color, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 36,
                      child: TextField(
                        controller: _passwordController,
                        autofocus: false,
                        obscureText: _obscureText,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration:

                        // InputDecorations.buildInputDecoration_1(
                        //     hint_text: "• • • • • • • •"),
                        InputDecoration(
                            hintText: "• • • • • • • •",
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: _obscureText
                                  ? Icon(Icons.visibility,color: MyTheme.accent_color
                                // Feather.eye_off, // Use Feather for Flutter icons
                              )
                                  : Icon(
                                Icons.visibility_off,color: Colors.grey,
                              ),
                            ),
                            filled: true,
                            fillColor: MyTheme.white,
                            hintStyle: TextStyle(fontSize: 12.0, color: MyTheme.textfield_grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: MyTheme.noColor,
                                  width: 0.2),
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(6.0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: MyTheme.accent_color,
                                  width: 0.5),
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(6.0),
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.0)
                        ),
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)
                          .password_must_contain_at_least_6_characters,
                      style: TextStyle(
                          color: MyTheme.textfield_grey,
                          fontStyle: FontStyle.italic),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  AppLocalizations.of(context)
                      .retype_password_ucf,
                  style: TextStyle(
                      color: MyTheme.accent_color, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  height: 36,
                  child: TextField(
                    controller: _passwordConfirmController,
                    autofocus: false,
                    obscureText: _obscureText2,
                    enableSuggestions: false,
                    autocorrect: false,

                    decoration:
                    // InputDecorations.buildInputDecoration_1(
                    //     hint_text: "• • • • • • • •"),
                    InputDecoration(
                        hintText: "• • • • • • • •",
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText2 = !_obscureText2;
                            });
                          },
                          child: _obscureText2
                              ? Icon(Icons.visibility,color: MyTheme.accent_color
                            // Feather.eye_off, // Use Feather for Flutter icons
                          )
                              : Icon(
                            Icons.visibility_off,color: Colors.grey,
                          ),
                        ),
                        filled: true,
                        fillColor: MyTheme.white,
                        hintStyle: TextStyle(fontSize: 12.0, color: MyTheme.textfield_grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: MyTheme.noColor,
                              width: 0.2),
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(6.0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: MyTheme.accent_color,
                              width: 0.5),
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(6.0),
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0)
                    ),

                  ),
                ),
              ),
              if(google_recaptcha.$)
              Container(
                height: _isCaptchaShowing?350:50,
                width: 300,
                child: Captcha((keyValue) {
                  googleRecaptchaKey = keyValue;
                  setState((){});
                },
                  handleCaptcha: (data){
                  if(_isCaptchaShowing.toString() !=  data) {
                        _isCaptchaShowing = data;
                        setState((){});
                      }
                    },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 15,
                      width: 15,
                      child: Checkbox(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          value: _isAgree,
                          onChanged: (newValue) {
                            _isAgree = newValue;
                            setState(() {});
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        width: DeviceInfo(context).width - 130,
                        child: RichText(
                            maxLines: 2,
                            text: TextSpan(
                                style: TextStyle(
                                    color: MyTheme.font_grey, fontSize: 12),
                                children: [
                                  TextSpan(
                                    text: "I agree to the",
                                  ),
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CommonWebviewScreen(
                                                      page_name:
                                                          "Terms Conditions",
                                                      url:
                                                          "${AppConfig.RAW_BASE_URL}/mobile-page/terms",
                                                    )));
                                      },
                                    style:
                                        TextStyle(color: MyTheme.accent_color),
                                    text: " Terms Conditions",
                                  ),
                                  TextSpan(
                                    text: " &",
                                  ),
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CommonWebviewScreen(
                                                      page_name:
                                                          "Privacy Policy",
                                                      url:
                                                          "${AppConfig.RAW_BASE_URL}/mobile-page/privacy-policy",
                                                    )));
                                      },
                                    text: " Privacy Policy",
                                    style:
                                        TextStyle(color: MyTheme.accent_color),
                                  )
                                ])),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Container(
                  height: 45,
                  child: Btn.minWidthFixHeight(
                    minWidth: MediaQuery.of(context).size.width,
                    height: 50,
                    color: MyTheme.accent_color,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6.0))),
                    child: Text(
                      AppLocalizations.of(context)
                          .sign_up_ucf,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    onPressed: _isAgree
                        ? () {
                            onPressSignUp();
                          }
                        : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Text(
                      AppLocalizations.of(context)
                          .already_have_an_account,
                      style: TextStyle(color: MyTheme.font_grey, fontSize: 12),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      child: Text(
                        AppLocalizations.of(context).log_in,
                        style: TextStyle(
                            color: MyTheme.accent_color,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Login();
                        }));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
