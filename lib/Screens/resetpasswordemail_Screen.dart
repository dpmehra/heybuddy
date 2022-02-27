import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heybuddy/Screens/enterconfirmpassword.dart';
import 'package:heybuddy/Screens/forgetpasswordotp.dart';
import 'package:heybuddy/Screens/otpScreen.dart';
import 'package:heybuddy/api/forgotpassword.dart';
import 'package:heybuddy/color&font/colors.dart';
import 'package:heybuddy/color&font/textStyle.dart';
import 'package:heybuddy/widgets/custom_bar.dart';

import 'logoName.dart';

class ResetEmailScreen extends StatefulWidget {
  const ResetEmailScreen({Key? key}) : super(key: key);

  @override
  _ResetEmailScreenState createState() => _ResetEmailScreenState();
}

class _ResetEmailScreenState extends State<ResetEmailScreen> {
  String dialCodeDigits = "+91";
  TextEditingController _controller = TextEditingController();
  submit(BuildContext context) async {
    if (_controller.text.isEmpty || _controller.text.length < 5) {
      final snackBar = SnackBar(
        content: Text("Enter your valid email"),
        backgroundColor: text6,
        duration: Duration(milliseconds: 2000),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        isLoading1 = false;
      });
    } else {
      var output = await ForgotPassword.forgot(_controller.text);
      if (output['status'] == false) {
        final snackBar = SnackBar(
          content: Text("User Not Exists"),
          backgroundColor: text6,
          duration: Duration(milliseconds: 2000),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        setState(() {
          isLoading1 = false;
        });
      } else if (output['status'] == true) {
        print("tokeen is${output['token']}");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Verification(
                      email: _controller.text,
                      tkn: output['token'],
                    )));
        setState(() {
          isLoading1 = false;
        });
      }
    }
  }

  bool isLoading1 = false;
  @override
  Widget build(BuildContext context) {
    const double kDesignWidth = 375;
    const double kDesignHeight = 812;
    double _widthScale = MediaQuery.of(context).size.width / kDesignWidth;
    double _heightScale = MediaQuery.of(context).size.height / kDesignHeight;
    // final String aspirant = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: _widthScale * 24),
          child: Column(
            children: [
              logoName(),
              SizedBox(
                height: _heightScale * 93.53,
              ),
              Row(
                children: [
                  Text(
                    "Reset Password",
                    style: CustomTextStyle.Blue4(context),
                  ),
                ],
              ),
              SizedBox(
                height: _heightScale * 32,
              ),
              // Row(
              //   children: [
              //     Padding(
              //       padding: EdgeInsets.only(left: _widthScale * 10.0),
              //       child: Text(
              //         "Enter Your Country Code",
              //         style: GoogleFonts.poppins(
              //           textStyle: TextStyle(
              //               color: text2(context),
              //               fontSize: _widthScale * 13,
              //               fontWeight: FontWeight.w600),
              //         ),
              //       ),
              //     ),
              //     SizedBox(
              //       width: _widthScale * 20,
              //     ),
              //     CountryCodePicker(
              //       onChanged: (country) {
              //         setState(() {
              //           dialCodeDigits = country.dialCode!;
              //         });
              //       },
              //       initialSelection: "भारत",
              //       showCountryOnly: false,
              //       showOnlyCountryWhenClosed: false,
              //       favorite: ["+91", "भारत"],
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: _heightScale * 1,
              // ),
              // TextField(
              //   decoration: InputDecoration(
              //     hintText: "Phone Number",
              //     prefix: Padding(
              //       padding: EdgeInsets.all(4),
              //       child: Text(dialCodeDigits),
              //     ),
              //   ),
              //   maxLength: 12,
              //   keyboardType: TextInputType.number,
              //   controller: _controller,
              // ),
              TextField(
                controller: _controller,
                autofocus: false,
                // keyboardType: TextInputType.number,
                style: TextStyle(
                    fontSize: _widthScale * 15.0, color: black(context)),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: textFieldColor(context),
                  hintText: 'Enter email to proceed',
                  hintStyle: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: _widthScale * 15,
                          color: text12.withOpacity(0.8))),
                  contentPadding: EdgeInsets.only(
                    left: _widthScale * 14.0,
                    //bottom: _widthScale * 8.0,
                    // top: _widthScale * 8.0
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: col1),
                    borderRadius: BorderRadius.circular(_widthScale * 6),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: textFieldColor(context),
                    ),
                    borderRadius: BorderRadius.circular(_widthScale * 6),
                  ),
                ),
              ),

              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: _widthScale * 10.0),
                    child: Text(
                      "Enter your registered email",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: text2(context),
                            fontSize: _widthScale * 13,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: _heightScale * 50),

              Container(
                // margin: EdgeInsets.symmetric(horizontal: 25),
                width: double.infinity,
                height: _widthScale * 56,
                child: ElevatedButton(
                    onPressed: () async {
                      if (isLoading1) return;
                      setState(() {
                        isLoading1 = true;
                      });
                      // await Future.delayed(Duration(seconds: 2));
                      submit(context);
                      // setState(() {
                      //   isLoading1 = false;
                      // });

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => SignInPhone()));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: isLoading1 ? text6.withOpacity(0.4) : text6,
                      shape: new RoundedRectangleBorder(
                        borderRadius:
                            new BorderRadius.circular(_widthScale * 10.0),
                      ),
                    ),
                    child: isLoading1
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: _heightScale * 20,
                                width: _widthScale * 20,
                                child: CircularProgressIndicator(
                                  color: white(context),
                                ),
                              ),
                              SizedBox(
                                width: _widthScale * 20,
                              ),
                              Text("Please Wait...")
                            ],
                          )
                        : Text(
                            "Next",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: _widthScale * 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
              ),
              SizedBox(
                height: _widthScale * 282,
              ),

              // Row(
              //   children: [
              //     SizedBox(
              //       width: MediaQuery.of(context).size.height * 0.02,
              //     ),
              //     Container(
              //       height: 1,
              //       width: MediaQuery.of(context).size.width * 0.3,
              //       color: row,
              //     ),
              //     Text(
              //       "  Or Sign In Using ",
              //       style: GoogleFonts.poppins(
              //         textStyle: TextStyle(color: text5, fontSize: 12),
              //       ),
              //     ),
              //     Container(
              //       height: 1,
              //       width: MediaQuery.of(context).size.width * 0.3,
              //       color: row,
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.048,
              // ),
              // Row(
              //   children: [
              //     Image.asset(
              //       "assets/googlephoto.jpg",
              //     ),
              //     SizedBox(width: MediaQuery.of(context).size.width * 0.1),
              //     Image.asset(
              //       "assets/Rectangle 390.jpg",
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 50,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
