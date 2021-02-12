import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_polymer/screens/events/event_tile/event_tile.dart';
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Subject',
                                        style: GoogleFonts.poppins(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w600,
                                            color: white)),
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: TextFormField(
                                  style: GoogleFonts.poppins(
                                    color: whiteOpacity,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.0,
                                  ),
                                  decoration: textInputDecoration,
                                  validator: (val) =>
                                      val.isEmpty ? 'Enter a title' : null,
                                  onChanged: (val) {
                                    setState(() => title = val);
                                  },
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                                    child: Text('Date',
                                        style: GoogleFonts.poppins(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w600,
                                            color: white)),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: _showDatePicker,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: elementColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 0, 0, 0),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                                    child: Text('Subject',
                                        style: GoogleFonts.poppins(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w600,
                                            color: white)),
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: elementColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  child: DropdownButtonFormField(
                                      hint: Text('',
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
                              Padding(
                                padding: EdgeInsets.fromLTRB(30, 25, 30, 0),
                                child: ButtonTheme(
                                  splashColor: whiteOpacity,
                                  minWidth: 225.0,
                                  height: 40.0,
                                  child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(11.0),
                                      ),
                                      textColor: white,
                                      color: buttonBlue,
                                      child: Text(
                                        'Create Event',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            color: white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15.0),
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState.validate()) {
                                          final user = Provider.of<User>(
                                              context,
                                              listen: false);
                                          dynamic result =
                                              await databaseService.createEvent(
                                                  user.uid,
                                                  title,
                                                  subject,
                                                  modalDate);
                                          if (result != null) {
                                            setState(() {
                                              String error =
                                                  'Unable to create event';
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20.0))),
                                                    backgroundColor:
                                                        canvasColor,
                                                    title: new Text("Error",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color: white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                    content: new Text(error,
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color:
                                                                    whiteOpacity,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                    actions: <Widget>[
                                                      new FlatButton(
                                                        child: new Text("Close",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    color:
                                                                        white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            });
                                          } else {
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

  Map<int, Color> color =
{
50:Color.fromRGBO(136,14,79, .1),
100:Color.fromRGBO(136,14,79, .2),
200:Color.fromRGBO(136,14,79, .3),
300:Color.fromRGBO(136,14,79, .4),
400:Color.fromRGBO(136,14,79, .5),
500:Color.fromRGBO(136,14,79, .6),
600:Color.fromRGBO(136,14,79, .7),
700:Color.fromRGBO(136,14,79, .8),
800:Color.fromRGBO(136,14,79, .9),
900:Color.fromRGBO(136,14,79, 1),
};

  _showDatePicker() async {
    
    MaterialColor cColor = MaterialColor(0xff181818, color);
    DateTime date = await showDatePicker(
        context: context,
        initialDate: modalDate != null ? modalDate : DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2022),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: cColor,
                primaryColorDark: cColor,
                accentColor: cColor,
              ),
            dialogBackgroundColor: cColor,
          ),
          child: child,
      );
},
        );
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
      _controller =
          new TextEditingController(text: dateFormat.format(modalDate));
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
    TextEditingController _noEventController =
        new TextEditingController(text: '');
    TextEditingController _noUpEventController =
        new TextEditingController(text: '');
    Widget noEventText = Container(
        alignment: Alignment.center,
        child: TextField(
            textAlign: TextAlign.center,
            enabled: false,
            enableInteractiveSelection: false,
            controller: _noEventController,
            style: GoogleFonts.poppins(
                color: white, fontWeight: FontWeight.w600, fontSize: 20.0)));
    Widget noUpcomingEventText = Container(
        alignment: Alignment.center,
        child: TextField(
            maxLines: 2,
            maxLengthEnforced: true,
            textAlign: TextAlign.center,
            enabled: false,
            enableInteractiveSelection: false,
            controller: _noUpEventController,
            style: GoogleFonts.poppins(
                color: white, fontWeight: FontWeight.w600, fontSize: 20.0)));
    bool noEventsToShow = false;
    bool areUpcomingEvents = false;

    return StreamBuilder<QuerySnapshot>(
        stream: stream.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            QuerySnapshot userEvents = snapshot.data;
            Widget upcomingEventCarousel;
            List eventChecker = userEvents.documents
                .where((event) =>
                    dateFormat.format(event['date'].toDate()) == selectedDate)
                .toList();
            List upcomingEvents = userEvents.documents
                .where((event) => (event['date']
                        .compareTo(Timestamp.fromDate(DateTime.now())) >
                    0))
                .toList();

            if (eventChecker.isEmpty) {
              noEventsToShow = true;
              _noEventController.text = 'No Events';
            }

            if (upcomingEvents.isEmpty == false) {
              Widget icon;
              Widget iconChooser(String subject) {
                if (subject == 'Math') {
                  icon = mathLogoBig;
                } else if (subject == 'Reading') {
                  icon = readingLogoBig;
                } else if (subject == 'English') {
                  icon = englishLogoBig;
                } else if (subject == 'Science') {
                  icon = scienceLogoBig;
                } else {
                  icon = notiLogoBig;
                }
                return icon;
              }

              List<Widget> mappedUpcomingEvents = upcomingEvents
                  .map((val) => buildUpEventTile(iconChooser(val['subject']),
                      val['title'], dateFormat.format(val['date'].toDate())))
                  .toList();
              areUpcomingEvents = true;
              upcomingEventCarousel =
                  UpcomingCarousel(cardList: mappedUpcomingEvents);
            } else {
              areUpcomingEvents = false;
              _noUpEventController.text = 'No Upcoming Events';
            }

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
                          margin: noEventsToShow
                              ? const EdgeInsets.fromLTRB(0, 0, 0, 15)
                              : const EdgeInsets.all(0),
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
                                }()),
                            noEventsToShow
                                ? noEventText
                                : Container(width: 0, height: 0),
                          ],
                        ),
                        Container(
                          margin: noEventsToShow
                              ? const EdgeInsets.fromLTRB(0, 2.5, 0, 0)
                              : const EdgeInsets.all(0),
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
                        areUpcomingEvents
                            ? upcomingEventCarousel
                            : noUpcomingEventText,
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

Widget buildUpEventTile(Widget icon, String event, String date) {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.fromLTRB(7, 5, 15, 5),
    margin: EdgeInsets.only(right: 20),
    decoration: BoxDecoration(
      color: elementColor,
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    child: Column(
      children: [
        Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(5, 10, 15, 10),
                child: icon,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(event,
                        style: GoogleFonts.poppins(
                            color: white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15)),
                    Text(date,
                        style: GoogleFonts.poppins(
                            color: whiteOpacity,
                            fontWeight: FontWeight.w400,
                            fontSize: 12)),
                  ],
                ),
              )
            ]),
      ],
    ),
  );
}

class UpcomingCarousel extends StatefulWidget {
  final List cardList;
  UpcomingCarousel({@required this.cardList});
  @override
  _UpcomingCarouselState createState() => _UpcomingCarouselState();
}

class _UpcomingCarouselState extends State<UpcomingCarousel> {
  PageController _controller =
      PageController(initialPage: 0, viewportFraction: .5);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List cardList = widget.cardList;
    return Container(
      height: 66,
      margin: EdgeInsets.fromLTRB(0, 0, 10, 10),
      child: Center(
        child: buildUpcomingList(cardList),
      ),
    );
  }

  Widget buildUpcomingList(List cards) {
    return ListView(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        children: [
          for (var card in cards)
            SizedBox(
              child: card,
            ),
        ]);
  }
}
