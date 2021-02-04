import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  final _formKey = GlobalKey<FormState>();
  DatabaseService databaseService = new DatabaseService();

  DateFormat dateFormat = DateFormat('MMMMEEEEd');
  String selectedDate;
  String today;
  DateTime date;
  String title = '';
  String subject = '';
  DateTime modalDate;
  Text userSelectedDate;
  List modalOptions = ['Science', 'Math', 'English', 'Reading', 'Other'];
  TextEditingController _controller;

  void addEventModal(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        backgroundColor: canvasColor,
        builder: (BuildContext context) {
          return FractionallySizedBox(
              heightFactor: 0.8,
              child: Container(
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 12.5),
                      child: Column(children: [
                        Container(
                          height: 6.5,
                          width: 60.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(110.0),
                              color: whiteOpacity),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 25, 0, 10),
                              child: Text(
                                'Add An Event',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(
                                    color: white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25.0),
                              ),
                            ),
                          ],
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: TextFormField(
                                  style: GoogleFonts.poppins(
                                    color: whiteOpacity,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.0,
                                  ),
                                  decoration: textInputDecoration.copyWith(
                                    hintText: 'Event Title',
                                  ),
                                  validator: (val) =>
                                      val.isEmpty ? 'Enter a title' : null,
                                  onChanged: (val) {
                                    setState(() => title = val);
                                  },
                                ),
                              ),
                              GestureDetector(
                                onTap: _showDatePicker,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: elementColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                      child: TextField(
                                        enabled: false,
                                        enableInteractiveSelection: false,
                                        controller: _controller,
                                          style: GoogleFonts.poppins(
                                            color: whiteOpacity,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15.0,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: Container(
                                  alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: elementColor,
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(15)),
                                      ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                    child: DropdownButtonFormField(
                                        hint: Text('Choose a Subject',
                                            style: GoogleFonts.poppins(
                                              color: whiteOpacity,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15.0,
                                            )),
                                        elevation: 0,
                                        //onTap: _showDatePicker,
                                        validator: (val) => val == null
                                            ? 'Please choose a subject'
                                            : null,
                                        onChanged: (val) {
                                          setState(() => subject = val);
                                        },
                                        items: modalOptions.map((val) {
                                          return DropdownMenuItem(
                                            value: val,
                                            child: Text(val,
                                                style: GoogleFonts.poppins(
                                                  color: whiteOpacity,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15.0,
                                                )),
                                          );
                                        }).toList()),
                                  ),
                                ),
                              ),
                                                      Padding(
                  padding: EdgeInsets.fromLTRB(44, 30, 44, 10),
                  child: ButtonTheme(
                    splashColor: whiteOpacity,
                    minWidth: 225.0,
                    height: 40.0,
                    child: RaisedButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11.0),), textColor: white, color: buttonBlue, child: Text('Create Event', textAlign: TextAlign.center, style: GoogleFonts.poppins(color: white, fontWeight: FontWeight.w600, fontSize: 15.0),), onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    final user = Provider.of<User>(context, listen: false);
                                    dynamic result =
                                        await databaseService.createEvent(user.uid, title, subject, modalDate);
                                    if (result != null) {
                                      setState(() {
                                        String error = 'Unable to create event';
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(20.0))),
                                              backgroundColor: canvasColor,
                                              title: new Text("Error",
                                                  style: GoogleFonts.poppins(
                                                      color: white,
                                                      fontWeight: FontWeight.w600)),
                                              content: new Text(error,
                                                  style: GoogleFonts.poppins(
                                                      color: whiteOpacity,
                                                      fontWeight: FontWeight.w500)),
                                              actions: <Widget>[
                                                new FlatButton(
                                                  child: new Text("Close",
                                                      style: GoogleFonts.poppins(
                                                          color:
                                                              white,
                                                          fontWeight: FontWeight.w500)),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      });
                                    }
                                    else {
                                      Navigator.pop(context);
                                    }
                                  }
                                }),
                          ),
                        )
                            ],
                          ),
                        ),
                      ]))));
        });
  }

  _showDatePicker() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: modalDate != null ? modalDate : DateTime.now(),
        lastDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().month + 1));
    if (date != null) {
      setState(() {
        modalDate = date;
        _controller.text = dateFormat.format(modalDate);
      });
    }
  }

  void _getEventsOnDate(DateTime day, _, List l) {
    selectedDate = dateFormat.format(day);
    setState(() {});
  }

  @override
  void initState() {
    modalDate = DateTime.now();
    setState(() {
      today = dateFormat.format(DateTime.now());
      selectedDate = today;
      /*.userSelectedDate = Text(dateFormat.format(modalDate),
          style: GoogleFonts.poppins(
            color: whiteOpacity,
            fontWeight: FontWeight.w500,
            fontSize: 15.0,
          ),
          textAlign: TextAlign.left);*/
      _controller = new TextEditingController(text: dateFormat.format(modalDate));
    });
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
    var stream = DatabaseService(uid: user.uid).getEvents;

    return StreamBuilder<QuerySnapshot>(
        stream: stream.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            QuerySnapshot userEvents = snapshot.data;

            return StreamProvider<List<Event>>.value(
              value: DatabaseService().events,
              child: Scaffold(
                backgroundColor: canvasColor,
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
                                      color: white,
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
                            builders: CalendarBuilders(
                              selectedDayBuilder: (context, date, _) {
                                return Container(
                                  decoration: new BoxDecoration(
                                    color: buttonBlue,
                                    shape: BoxShape.rectangle,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7.0)),
                                  ),
                                  margin: const EdgeInsets.all(5.0),
                                  width: 100,
                                  height: 100,
                                  child: Center(
                                    child: Text('${date.day}',
                                        style: GoogleFonts.poppins(
                                            color: white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15.0)),
                                  ),
                                );
                              },
                              todayDayBuilder: (context, date, _) {
                                return Container(
                                  decoration: new BoxDecoration(
                                    color: canvasColor,
                                    shape: BoxShape.rectangle,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7.0)),
                                  ),
                                  margin: const EdgeInsets.all(5.0),
                                  width: 100,
                                  height: 100,
                                  child: Center(
                                    child: Text(
                                      '${date.day}',
                                      style: GoogleFonts.poppins(
                                          color: white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                );
                              },
                            ),
                            formatAnimation: FormatAnimation.slide,
                            onDaySelected: _getEventsOnDate,
                            availableGestures: AvailableGestures.none,
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
                                outsideWeekendStyle: GoogleFonts.poppins(
                                    color: whiteOpacity,
                                    fontWeight: FontWeight.w500),
                                outsideStyle: GoogleFonts.poppins(
                                    color: whiteOpacity,
                                    fontWeight: FontWeight.w500),
                                weekendStyle: GoogleFonts.poppins(
                                    color: white, fontWeight: FontWeight.w500),
                                renderDaysOfWeek: true,
                                todayColor: canvasColor,
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
                            daysOfWeekStyle: DaysOfWeekStyle(
                              weekdayStyle: GoogleFonts.poppins(
                                  color: whiteOpacity,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                              weekendStyle: GoogleFonts.poppins(
                                  color: whiteOpacity,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            for (var event in userEvents.documents)
                              if (dateFormat.format(event['date'].toDate()) ==
                                  selectedDate)
                                (() {
                                  return EventTile(
                                      subject: event['subject'],
                                      date: dateFormat
                                          .format(event['date'].toDate()),
                                      title: event['title']);
                                }())
                          ],
                        ),
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
                                textColor: white,
                                color: buttonBlue,
                                child: Text(
                                  'Add An Event',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      color: isLightTheme ? canvasColor : white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.0),
                                ),
                                onPressed: () {
                                  addEventModal(context);
                                }),
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
