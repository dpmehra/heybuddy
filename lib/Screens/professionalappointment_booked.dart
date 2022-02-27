// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heybuddy/Screens/welcome.dart';
import 'package:heybuddy/api/api_profile.dart';
import 'package:heybuddy/api/second_tab_api.dart';
import 'package:heybuddy/api/signup_api.dart';
import 'package:heybuddy/api/unique_calendar.dart';
import 'package:heybuddy/color&font/colors.dart';
import 'package:provider/provider.dart';

class ProfessionalAppointmentBooked extends StatefulWidget {
  var index;
  ProfessionalAppointmentBooked({required this.index});
  // const AppointmentBooked({Key? key}) : super(key: key);

  @override
  _ProfessionalAppointmentBookedState createState() =>
      _ProfessionalAppointmentBookedState();
}

class _ProfessionalAppointmentBookedState
    extends State<ProfessionalAppointmentBooked> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // get2ndtabapi();
    onTap();
    getDataProfile();
  }

  var tkn = datam.read('f');
  var responseid;
  getDataProfile() async {
    responseid = await getdata(tkn); //61eff7e265af2b2bef40cde8
    print("//////$responseid");

    return responseid;
  }

  // var valout;
  // List resout = [];
  // get2ndtabapi() async {
  //   valout = await secondTabPayment(tkn);
  //   resout = valout;
  //   return resout;
  // }
  var output;
  onTap() async {
    output = await UniqueUserCalendar.uniqueUser(widget.index, tkn);
    return output;
  }

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

  String getCapitalizeStringaa(String str) {
    if (str.length <= 1) {
      return str.toUpperCase();
    }
    return '${str[0].toUpperCase()}${str.substring(1)}';
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
          child: FutureBuilder(
              future: onTap(),
              builder: (context, snapShot) {
                return output == null
                    ? Container(
                        height: _heightScale * 650,
                        width: double.infinity,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ))
                    : Column(
                        children: [
                          // Container(
                          //   height: size.height * 0.74,
                          // child:
                          Column(
                            children: [
                              SizedBox(
                                height: _heightScale * 44,
                              ),
                              Image.asset("assets/Group 246.png"),
                              SizedBox(
                                height: _heightScale * 32,
                              ),
                              Appointment(
                                  "Booking id: ",
                                  output['orderId']
                                      .toString()
                                      .replaceRange(0, 6, ""),
                                  text9),
                              SizedBox(
                                height: _heightScale * 32,
                              ),
                              Appointment("Topic: ", output['topic'], text9),
                              SizedBox(
                                height: _heightScale * 32,
                              ),
                              FutureBuilder(
                                  future: getDataProfile(),
                                  builder: (context, snapShot) {
                                    return Appointment(
                                        "Name: ",
                                        output["Aspirant"] == responseid['_id']
                                            ? output['professionalname'] != null
                                                ? getCapitalizeStringaa(
                                                    output['professionalname'])
                                                : "No Detail"
                                            : output['professionalname'] != null
                                                ? getCapitalizeStringaa(
                                                    output['aspirantname'])
                                                : "No Detail",
                                        text9);
                                  }),
                              SizedBox(
                                height: _heightScale * 32,
                              ),
                              Appointment(
                                  "Status: ", output['status'], Colors.green),
                              SizedBox(
                                height: _heightScale * 32,
                              ),
                              Appointment(
                                  "Date: ",
                                  output['Date']
                                      .toString()
                                      .replaceRange(10, 24, ""),
                                  text9),
                              SizedBox(
                                height: _heightScale * 30,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Time Slot",
                                    style: GoogleFonts.poppins(
                                        fontSize: _widthScale * 16,
                                        color: text9),
                                  ),
                                ],
                              ),
                              // spacevert,
                              SizedBox(
                                height: _heightScale * 30,
                              ),
                              // Container(
                              //   //  margin: EdgeInsets.only(left: 16, right: 15),
                              //   height: _heightScale * 56,
                              //   width: double.maxFinite,
                              //   decoration: BoxDecoration(
                              //     color: white.withOpacity(0.5),
                              //     borderRadius: BorderRadius.all(
                              //         Radius.circular(_widthScale * 6)),
                              //   ),
                              //   child: InkWell(
                              //     onTap: () {
                              //       pickTime(context);
                              //     },
                              //     child: ListTile(
                              //       title: Text(
                              //         "12:00 - 12:30",
                              //         style: GoogleFonts.poppins(
                              //             fontSize: _widthScale * 18,
                              //             color: col3),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              Appointment(
                                  "",
                                  output['meetingTime'] == ""
                                      ? ""
                                      : output['meetingTime'],
                                  // .toString(),
                                  // .replaceRange(10, 24, ""),
                                  text9),
                            ],
                          ),
                          // ),
                          SizedBox(
                            height: _heightScale * 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "The link has been sent to your gmail and calender",
                                style: GoogleFonts.poppins(
                                    fontSize: _widthScale * 12),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: _heightScale * 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Kindly join it",
                                style: GoogleFonts.poppins(
                                    fontSize: _widthScale * 12),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: _heightScale * 20,
                          ),
                          // Container(
                          //   width: double.infinity,
                          //   height: _widthScale * 56,
                          //   child: ElevatedButton(
                          //       onPressed: () {},
                          //       style: ElevatedButton.styleFrom(
                          //         primary: text6,
                          //         shape: new RoundedRectangleBorder(
                          //           borderRadius: new BorderRadius.circular(
                          //               _widthScale * 10.0),
                          //         ),
                          //       ),
                          //       child: Text(
                          //         'Join Meeting',
                          //         style: GoogleFonts.poppins(
                          //           textStyle:
                          //               TextStyle(fontSize: _widthScale * 18),
                          //         ),
                          //       )),
                          // ),
                        ],
                      );
              }),
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
              fontWeight: FontWeight.w600),
        ),
        Text(
          data,
          style: GoogleFonts.poppins(fontSize: _widthScale * 16, color: col),
        ),
      ],
    );
  }
}
