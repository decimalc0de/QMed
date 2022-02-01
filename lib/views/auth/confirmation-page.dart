// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:med_report/views/widgets/button-widget.dart';

import 'authentication-page.dart';

class ConfirmationPage extends StatefulWidget {
  final Map<String, String> _data;
  const ConfirmationPage({Key? key, required data}) :
        _data = data, super(key: key);

  @override
  _ConfirmationPageState createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  /*
  * 0: confirm password
  * 1: auth code from email
  */
  List textfieldValues = ["", ""];

  bool authEmail = false, register = false;
  String _message = "Some message from server";

  final _authCodeKey = GlobalKey<FormState>();
  final _confirmPasswordKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      body: Center(
        child: Container(
          height: size.height,
          width: size.height,
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xff151f2c) : Colors.white,
          ),
          child: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.03),
                        child: Align(
                          child: Text(
                            'Confirm Password',
                            style: GoogleFonts.poppins(
                              color: isDarkMode
                                  ? Colors.white
                                  : const Color(0xff1D1617),
                              fontSize: size.height * 0.025,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.01),
                      ),
                      !register ?
                      Form(
                        child: buildTextField(
                          "Password",
                          Icons.lock_outline,
                          true,
                          size,
                          (valuepassword) {
                            if (valuepassword != "peter"/*widget._data['password']*/) {
                              buildSnackError(
                                'Passwords must match',
                                context,
                                size,
                              );
                              return '';
                            }
                            return null;
                          },
                          _confirmPasswordKey,
                          0,
                          isDarkMode,
                        ),
                      )
                      :
                      Column(
                        children: [
                          Text(_message),
                          Form(
                            child: buildTextField(
                              "medA code",
                              Icons.qr_code,
                              false,
                              size,
                                (valueAuthCode) {
                                if (valueAuthCode != widget._data['authCode']) {
                                  // TODO
                                  // Auth code does not match error
                                  buildSnackError(
                                    'Auth code is invalid',
                                    context,
                                    size,
                                  );
                                  // OR
                                  // Time elapse error
                                  // Resend another email
                                  // OR
                                  // Change your current email
                                  return '';
                                }
                                return null;
                              },
                              _authCodeKey,
                              1,
                              isDarkMode,
                            ),
                          ),
                        ],
                      ),
                      AnimatedPadding(
                        duration: const Duration(milliseconds: 500),
                        padding: EdgeInsets.only(top: size.height * 0.05),
                        child: ButtonWidget(
                          text: "Confirm",
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
                            if(!register) {
                              if (_confirmPasswordKey.currentState!.validate()) {
                                // TODO
                                // Send https request for new registered user
                                // Send confirmation email from backend
                                postData(widget._data).then((response) => {
                                  if(response != null) {
                                    if(response['status'] == 200)
                                    setState(() {
                                      _message = response['message'];
                                      register = authEmail = true;
                                    })
                                  }
                                });
                              }
                            }
                            else if(register && authEmail) {
                              if (_authCodeKey.currentState!.validate()) {
                                var username = widget._data['username'];
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                      AuthPage(username: username )),
                                  (route) => false
                                );
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
                                color: isDarkMode ? Colors.white : Colors.black,
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
  Widget buildTextField(
    String hintText,
    IconData icon,
    bool password,
    size,
    FormFieldValidator validator,
    Key key,
    int stringToEdit,
    bool isDarkMode,
  ) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.02),
      child: Container(
        width: size.width * 0.9,
        height: size.height * 0.065,
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.black : Colors.grey[200],
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Form(
          key: key,
          child: TextFormField(
            style: TextStyle(
                color: isDarkMode ? const Color(0xffADA4A5) : Colors.black),
            onChanged: (value) {
              setState(() {
                textfieldValues[stringToEdit] = value;
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

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> buildSnackError(
      String error, context, size) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.black,
        content: SizedBox(
          height: size.height * 0.02,
          child: Center(
            child: Text(error),
          ),
        ),
      ),
    );
  }
}

/*
 * Post Request #SubmitRegistration
 */
Future<Map?> postData(Map<String, String> data) async{
  try {
    String uri = "https://jsonplaceholder.typicode.com/posts";
    final response = await post(Uri.parse(uri), body: data);
    return jsonDecode(response.body) as Map;
  }
  catch(ex) {
    // TODO
    // Network exception
  }

}