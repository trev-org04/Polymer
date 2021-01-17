import 'package:flutter/material.dart';
import 'package:project_polymer/screens/events/event_tile/event_tile.dart';
import 'package:project_polymer/screens/events/upcoming_events/upcoming_carousel.dart';
import 'package:project_polymer/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:project_polymer/service/database.dart';
import 'package:project_polymer/models/data.dart';
import 'package:project_polymer/models/user.dart';
import 'package:project_polymer/shared/loading.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_fonts/google_fonts.dart';

class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  var _calendarController = CalendarController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StreamProvider<List<Data>>.value(
              value: DatabaseService().data,
              child: Scaffold(
                backgroundColor: Color(0xff181818),
                body: Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 12.5),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                child: Text(
                                  'Events',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                      color: Color(0xffE2E2E2),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 25.0),
                                ),
                              ),
                            ]),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Calendar',
                                  style: GoogleFonts.poppins(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600,
                                      color: white)),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: elementColor,
                              borderRadius: BorderRadius.circular(15)),
                          padding: const EdgeInsets.all(8.0),
                          child: TableCalendar(
                            availableCalendarFormats: {
                              CalendarFormat.month: 'Month'
                            },
                            calendarController: _calendarController,
                            calendarStyle: CalendarStyle(
                                selectedStyle: GoogleFonts.poppins(
                                    color: white, fontWeight: FontWeight.w500),
                                todayStyle: GoogleFonts.poppins(
                                    color: white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                                selectedColor: buttonBlue,
                                outsideWeekendStyle: GoogleFonts.poppins(
                                    color: white, fontWeight: FontWeight.w500),
                                outsideStyle: GoogleFonts.poppins(
                                    color: white, fontWeight: FontWeight.w500),
                                weekendStyle: GoogleFonts.poppins(
                                    color: white, fontWeight: FontWeight.w500),
                                renderDaysOfWeek: false,
                                todayColor: Color(0xff181818),
                                weekdayStyle: GoogleFonts.poppins(
                                    color: white, fontWeight: FontWeight.w500)),
                            headerStyle: HeaderStyle(
                              leftChevronIcon: Icon(Icons.arrow_back_ios,
                                  size: 13, color: white),
                              centerHeaderTitle: true,
                              rightChevronIcon: Icon(Icons.arrow_forward_ios,
                                  size: 13, color: white),
                              titleTextStyle: GoogleFonts.poppins(
                                  color: white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                              formatButtonVisible: false,
                            ),
                          ),
                        ),
                        EventTile(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Upcoming Events',
                                  style: GoogleFonts.poppins(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600,
                                      color: white)),
                            ],
                          ),
                        ),
                        UpcomingCarousel(),
            Padding(
              padding: EdgeInsets.fromLTRB(44, 20, 44, 60),
              child: ButtonTheme(
                splashColor: whiteOpacity,
                minWidth: 225.0,
                height: 40.0,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11.0)),
                    textColor: Color(0xffE2E2E2),
                    color: Color(0xff0099FF),
                    child: Text(
                      'Add An Event',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: Color(0xffE2E2E2),
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0),
                    ),
                    onPressed: () {}),
              ),
            ),
                      ],
                    ),
                  ),
                )),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}

//https://www.youtube.com/watch?v=rjnrAYZ71dE
//https://github.com/aphrx/flutter_calendar/tree/main/lib
