// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:med_report/_misc/global-properties.dart';
import 'package:med_report/_request/login-request.dart';
import 'package:med_report/_request/registration-request.dart';
import 'package:med_report/views/widgets/alert-message.dart';
import 'package:med_report/views/widgets/button-widget.dart';

import '../home-page.dart';
import 'forgot-pwd-page.dart';

class AuthPage extends StatefulWidget {
  final String? _username;
  const AuthPage({Key? key, String? username}) :
        _username = username, super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();

}

class _AuthPageState extends State<AuthPage> {
  List<String> textfieldStrings = [
    "", //firstName
    "", //lastName
    "", //email
    "", //tele
    "", //password
  ];

  bool checkedValue = false,
      register = false;

  final _userNamekey = GlobalKey<FormState>();
  final _lastNamekey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormState>();
  final _teleKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();

  // final _confirmPasswordKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    var brightness = MediaQuery
        .of(context)
        .platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      body: Center(
        child: Container(
          height: size.height,
          width: size.height,
          decoration: BoxDecoration(
            color: isDarkMode ? darkColor0 : brightColor0,
          ),
          child: SafeArea(
              child: Stack(
                  children: [
              SingleChildScrollView(
              child: Column(
              children: [
                  Padding(
                  padding: register ?
                  EdgeInsets.only(top: size.height * 0.03)
                  : EdgeInsets.only(top: size.height * 0.15),
          child: Align(
            child: register
                ? Text(
              'Create an Account',
              style: GoogleFonts.poppins(
                color: isDarkMode ? brightColor0 : darkColor1,
                fontSize: size.height * 0.025,
                fontWeight: FontWeight.bold,
              ),
            )
                : Text(
              'Welcome Back',
              style: GoogleFonts.poppins(
                color: isDarkMode
                    ? brightColor0 : darkColor1,
                fontSize: size.height * 0.025,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: size.height * 0.01),
        ),
        buildTextField(
            "User Name",
            Icons.person_outlined,
            false,
            size,
                (valuename) {
              if (valuename.length <= 2) {
                AlertMessage.get(
                    message: 'Username must contain more than 3 characters');
                return '';
              }
              return null;
            },
            _userNamekey,
            0,
            isDarkMode,
            initialText: widget._username
        ),
        register
            ? buildTextField(
          "Full Name",
          Icons.person_outlined,
          false,
          size,
              (valuesurname) {
            if (valuesurname.length <= 2) {
              AlertMessage.get(
                  message: 'Name must contain more than 4 characters');
              return '';
            }
            return null;
          },
          _lastNamekey,
          1,
          isDarkMode,
        )
            : Container(),
        register ?
        Form(
          child: buildTextField(
            "Email",
            Icons.email_outlined,
            false,
            size,
                (valuemail) {
              if (valuemail.length < 5) {
                AlertMessage.get(
                    message: 'The email you provided is not valid');
                return '';
              }
              if (!RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+")
                  .hasMatch(valuemail)) {
                AlertMessage.get(
                    message: 'The email you provided is not valid');
                return '';
              }
              return null;
            },
            _emailKey,
            2,
            isDarkMode,
          ),
        )
            : Container(),
        register ?
        buildTextField(
          "Telephone",
          Icons.phone_outlined,
          false,
          size,
              (teleValue) {
            if (teleValue.length < 2) {
              AlertMessage.get(message: 'Enter a valid contact');
              return '';
            }
            if (!RegExp(r"^").hasMatch(teleValue)) {
              AlertMessage.get(message: 'Enter a valid contact');
              return '';
            }
            return null;
          },
          _teleKey,
          3,
          isDarkMode,
        )
            : Container(),
        Form(
          child: buildTextField(
            "Passsword",
            Icons.lock_outline,
            true,
            size,
                (valuepassword) {
              if (valuepassword.length < 6) {
                AlertMessage.get(
                    message: 'Password must contain more than 8 characters');
                return '';
              }
              return null;
            },
            _passwordKey,
            4,
            isDarkMode,
          ),
        ),
        Padding(
          padding:
          register ?
          EdgeInsets.symmetric(
              horizontal: size.width * 0.015, vertical: size.height * 0.02)
              :
          EdgeInsets.symmetric(
              horizontal: size.width * 0.12, vertical: size.height * 0.025),
          child: register
              ? CheckboxListTile(
            title: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "By creating an account, you agree to our ",
                    style: TextStyle(
                      color: isDarkMode ? brightColor2 : darkColor1,
                      fontSize: size.height * 0.015,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  WidgetSpan(
                    child: InkWell(
                      onTap: () {
                        // ignore: avoid_print
                        print('Conditions of Use');
                      },
                      child: Text(
                        "Conditions of Use",
                        style: TextStyle(
                          color: isDarkMode ? brightColor2 : darkColor1,
                          fontSize: size.height * 0.015,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  TextSpan(
                    text: " and ",
                    style: TextStyle(
                      color: isDarkMode ? brightColor2 : darkColor1,
                      fontSize: size.height * 0.015,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  WidgetSpan(
                    child: InkWell(
                      onTap: () {
                        // ignore: avoid_print
                        print('Privacy Notice');
                      },
                      child: Text(
                        "Privacy Notice",
                        style: TextStyle(
                          color: isDarkMode ? brightColor2 : darkColor1,
                          fontSize: size.height * 0.015,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            activeColor: const Color(0xff7B6F72),
            value: checkedValue,
            onChanged: (newValue) {
              setState(() {
                checkedValue = newValue!;
              });
            },
            controlAffinity:
            ListTileControlAffinity.leading,
          )
              : InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                      const ForgotPasswordPage()),
                );
              },
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  "Forgot your password ?",
                  style: TextStyle(
                    color: isDarkMode ? brightColor2 : darkColor1,
                    fontSize: size.height * 0.02,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
          ),
        ),
        AnimatedPadding(
          duration: const Duration(milliseconds: 500),
          padding: register
              ? EdgeInsets.only(top: size.height * 0.01)
              : EdgeInsets.only(top: size.height * 0.04),
          child: ButtonWidget(
              text: register ? "Register" : "Login",
              blackColor: isDarkMode
              ? [
              Colors.green,
              Colors.black,
              ]
                  : const [Colors.blue, Color(0xff9DCEFF)],
          textColor: const [
            Colors.white,
            Colors.white,
          ],
          onPressed: () async {
            if (register) {
              //validation for register
              if (_userNamekey.currentState!.validate()) {
                if (_lastNamekey.currentState!.validate()) {
                  if (_emailKey.currentState!.validate()) {
                    if (_passwordKey.currentState!.validate()) {
                      if (checkedValue == false) {
                        AlertMessage.get(message: 'Accept our Privacy Policy and Term Of Use');
                      } else {
                        signUp(textfieldStrings[0], textfieldStrings[4]).then((apiResponse) {
                          if(apiResponse.success){
                            setState(() {
                              register = false;
                            });
                          }
                          else {
                            AlertMessage.get(message: apiResponse.message);
                          }
                        }).catchError((error) => AlertMessage.get(message: error.message));
                        // TODO
                        // Confirm password and email page
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) =>
                        //       const ConfirmationPage(
                        //         data: <String,
                        //             String>{ /* TODO Pass data including email-auth-code*/
                        //         },
                        //       )
                        //   ),
                        // );
                        // If password matches
                        // Send Https request
                        // Confirm email
                        print('register');
                      }
                    }
                  }
                }
              }
            } else {
              //validation for login
              if (_userNamekey.currentState!.validate()) {
                if (_passwordKey.currentState!.validate()) {
                  login(textfieldStrings[0], textfieldStrings[4]).then((apiResponse) {
                    if(apiResponse.success){
                      Get.to(() => HomePage(userData: apiResponse));
                    }
                    else {
                      AlertMessage.get(message: apiResponse.message);
                    }
                  }).catchError((error) => AlertMessage.get(message: error.message));
                }
              }
            }
          },
        ),
      ),
      AnimatedPadding(
        duration: const Duration(milliseconds: 500),
        padding: EdgeInsets.only(
          top: register
              ? size.height * 0.025
              : size.height * 0.15,
        ),
        child: Row(
          //TODO: replace text logo with your logo
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'medA',
              style: GoogleFonts.poppins(
                color: isDarkMode ? brightColor2 : darkColor1,
                fontSize: size.height * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '+',
              style: GoogleFonts.poppins(
                color: const Color(0xff3b22a1),
                fontSize: size.height * 0.06,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      InkWell(
        child: RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
                children: [
                  TextSpan(
                    text: register
                        ? "Already have an account? "
                        : "Don’t have an account yet? ",
                    style: TextStyle(
                      color: isDarkMode ? brightColor2 : darkColor1,
                      fontSize: size.height * 0.018,
                    ),
                  ),
                  WidgetSpan(
                    child: register
                        ? Text(
                      "Login",
                      style: TextStyle(
                        foreground: Paint()
                          ..shader = const LinearGradient(
                            colors: <Color>[
                              Color(0xffEEA4CE),
                              Color(0xffC58BF2),
                            ],
                          ).createShader(
                            const Rect.fromLTWH(
                              0.0,
                              0.0,
                              200.0,
                              70.0,
                            ),
                          ),
                        fontSize: size.height * 0.018,
                      ),
                    )
                        : Text(
                      "Register",
                      style: TextStyle(
                        foreground: Paint()
                          ..shader = const LinearGradient(
                            colors: <Color>[
                              Color(0xffEEA4CE),
                              Color(0xffC58BF2),
                            ],
                          ).createShader(
                            const Rect.fromLTWH(
                                0.0, 0.0, 200.0, 70.0),
                          ),
                        // color: const Color(0xffC58BF2),
                        fontSize: size.height * 0.018,
                      ),
                    ),
                  )
                ]
            )
        ),
        onTap: () =>
            setState(() {
              if (register) {
                register = false;
              } else {
                register = true;
              }
            }),
      )
      ],
    ),
    ),
    ],
    ),
    ),
    ),
    ),
    );
  }

  bool pwVisible = false;

  Widget buildTextField(String hintText,
      IconData icon,
      bool password,
      size,
      FormFieldValidator validator,
      Key key,
      int stringToEdit,
      bool isDarkMode,
      {String? initialText}) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.02),
      child: Container(
        width: size.width * 0.9,
        height: size.height * 0.065,
        decoration: BoxDecoration(
          color: isDarkMode ? darkColor1 : brightColor2,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Form(
          key: key,
          child: TextFormField(
            initialValue: initialText,
            style: TextStyle(
                color: isDarkMode ? brightColor0 : darkColor0),
            onChanged: (value) {
              setState(() {
                textfieldStrings[stringToEdit] = value;
              });
            },
            validator: validator,
            textInputAction: TextInputAction.next,
            obscureText: password ? !pwVisible : false,
            decoration: InputDecoration(
              errorStyle: const TextStyle(height: 0),
              hintStyle: const TextStyle(
                color: Color(0xffADA4A5),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(
                top: size.height * 0.02,
              ),
              hintText: hintText,
              prefixIcon: Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.001,
                ),
                child: Icon(
                  icon,
                  color: const Color(0xff7B6F72),
                ),
              ),
              suffixIcon: password
                  ? Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.001,
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      pwVisible = !pwVisible;
                    });
                  },
                  child: pwVisible
                      ? const Icon(
                    Icons.visibility_off_outlined,
                    color: Color(0xff7B6F72),
                  )
                      : const Icon(
                    Icons.visibility_outlined,
                    color: Color(0xff7B6F72),
                  ),
                ),
              )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}