// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heybuddy/Screens/welcome.dart';
import 'package:heybuddy/color&font/colors.dart';
import 'package:provider/provider.dart';

class ProfessionalAddComments extends StatefulWidget {
  // const AppointmentBooked({Key? key}) : super(key: key);

  @override
  _ProfessionalAddCommentsState createState() =>
      _ProfessionalAddCommentsState();
}

class _ProfessionalAddCommentsState extends State<ProfessionalAddComments> {
  var time;

  var add = TimeOfDay.minutesPerHour / 2;
  String getText() {
    if (time == null) {
      return 'Select Time';
    } else {
      final hours = time.hour;
      final minutes = time.minute;
      // final extratime = TimeOfDay(hour: hours, minute: minutes);
      if (minutes < 10) {
        return '$hours:${0}${minutes} - $hours:${minutes + 30}';
      } else if (minutes > 10 && minutes < 30) {
        return '$hours:$minutes - $hours:${minutes + 30}'; //'$hours:$minutes';
      } else if (minutes > 30) {
        return '$hours:$minutes - ${hours + 1}:${0}${minutes + 30 - 60}';
      }
    }
    return "";
  }

  Future pickTime(BuildContext context) async {
    final initialTime = TimeOfDay.now();
    final newTime = await showTimePicker(
      context: context,
      initialTime: time ?? initialTime,
    );

    if (newTime == null) return;

    setState(() => time = newTime);
  }

  @override
  Widget build(BuildContext context) {
    const double kDesignWidth = 375;
    const double kDesignHeight = 812;
    double _widthScale = MediaQuery.of(context).size.width / kDesignWidth;
    double _heightScale = MediaQuery.of(context).size.height / kDesignHeight;

    var word = Provider.of<Favourite>(context).fav;
    var size = MediaQuery.of(context).size;
    Widget spacevert = SizedBox(
      height: size.height * 0.04,
    );

    Widget spacehort2 = SizedBox(
      width: size.width * 0.1,
    );
    Widget spacevert1 = SizedBox(
      height: size.height * 0.03,
    );
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: white(context).withOpacity(0.6),
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: text9,
          ),
        ),
        title: Text(
          "Appointment",
          style: GoogleFonts.poppins(
              color: whitebox(context),
              fontSize: _widthScale * 18,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: _widthScale * 24),
          child: Column(
            children: [
              SizedBox(
                height: _heightScale * 44,
              ),
              Image.asset("assets/Group 246 (2).png"),
              SizedBox(
                height: _heightScale * 32,
              ),
              Appointment("Booking id: ", "0321231", text9),
              SizedBox(
                height: _heightScale * 32,
              ),
              Appointment("Topic: ", "Interview process at Amazon", text9),
              SizedBox(
                height: _heightScale * 32,
              ),
              Appointment("Professional: ", "Manipreet Mittapelli", text9),
              SizedBox(
                height: _heightScale * 32,
              ),
              Appointment("Status: ", "Add Comments", Colors.orange),
              SizedBox(
                height: _heightScale * 32,
              ),
              Appointment("Date: ", "17 November 2021", text9),
              SizedBox(
                height: _heightScale * 32,
              ),
              Row(
                children: [
                  Text(
                    "Time Slot",
                    style: GoogleFonts.poppins(
                        fontSize: _widthScale * 16, color: text9),
                  ),
                ],
              ),
              SizedBox(
                height: _heightScale * 23,
              ),
              Appointment("12:00 - 12:30", "", text9),
              SizedBox(
                height: _heightScale * 32,
              ),
              Appointment("Add Comments for aspirants", "", text9),
              SizedBox(
                height: _heightScale * 20,
              ),
              Container(
                //margin: EdgeInsets.only(left: 30, right: 30),
                child: TextField(
                  autofocus: false,
                  maxLines: 5,
                  style: TextStyle(
                      fontSize: _widthScale * 15.0, color: black(context)),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: white(context).withOpacity(0.5),
                    hintText: 'typing',
                    hintStyle: GoogleFonts.poppins(
                        textStyle: TextStyle(fontSize: _widthScale * 16)),
                    contentPadding: EdgeInsets.only(
                        left: _widthScale * 14.0,
                        bottom: _heightScale * 8.0,
                        top: _heightScale * 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: textFieldColor(context),
                      ),
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
              ),
              SizedBox(
                height: _heightScale * 12,
              ),
              Row(
                children: [
                  Text(
                    "Submit reponse to complete the booking",
                    style: GoogleFonts.poppins(fontSize: _widthScale * 12),
                  ),
                ],
              ),
              SizedBox(
                height: _heightScale * 19,
              ),
              Container(
                width: double.infinity,
                height: _widthScale * 56,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: text6,
                      shape: new RoundedRectangleBorder(
                        borderRadius:
                            new BorderRadius.circular(_widthScale * 10.0),
                      ),
                    ),
                    child: Text(
                      'Submit',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(fontSize: _widthScale * 18),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Appointment(String heading, String data, Color col) {
    const double kDesignWidth = 375;
    const double kDesignHeight = 812;
    double _widthScale = MediaQuery.of(context).size.width / kDesignWidth;
    double _heightScale = MediaQuery.of(context).size.height / kDesignHeight;

    return Row(
      children: [
        Text(
          heading,
          style: GoogleFonts.poppins(
              fontSize: _widthScale * 16,
              color: black(context),
              fontWeight: FontWeight.w500),
        ),
        Text(
          data,
          style: GoogleFonts.poppins(fontSize: _widthScale * 16, color: col),
        ),
      ],
    );
  }
}
