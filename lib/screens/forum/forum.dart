import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_polymer/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:project_polymer/service/database.dart';
import 'package:project_polymer/models/data.dart';
import 'package:project_polymer/models/user.dart';
import 'package:project_polymer/shared/loading.dart';
import 'package:google_fonts/google_fonts.dart';

String selectedSubject = 'Popular';
bool userSelectedSubject = false;
bool userTypedInput = false;
String userInput = '';
PageController _cardController =
    PageController(initialPage: 0, viewportFraction: .5);
final _formKey = GlobalKey<FormState>();
DatabaseService databaseService = new DatabaseService();
int _selectedIndex = 0;
DateTime modalDate;
DateFormat dateFormat = DateFormat('MMMMEEEEd');
String title = '';
String question = '';
String subject = '';
List modalOptions = ['Science', 'Math', 'English', 'Reading'];

class Forum extends StatefulWidget {
  @override
  _ForumState createState() => _ForumState();
}

class _ForumState extends State<Forum> {
  @override
  void dispose() {
    _cardController.dispose();
    _searchbarController.removeListener(onValueChanged);
    _searchbarController.dispose();
    super.dispose();
  }

  void askQuestionModal(context) {
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
              child: SingleChildScrollView(
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
                                padding:
                                    const EdgeInsets.fromLTRB(0, 25, 0, 10),
                                child: Text(
                                  'Ask A Question',
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
                                      child: Text('Title',
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
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Question',
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
                                    maxLines: 3,
                                    maxLengthEnforced: true,
                                    style: GoogleFonts.poppins(
                                      color: whiteOpacity,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                    ),
                                    decoration: textInputDecoration,
                                    validator: (val) =>
                                        val.isEmpty ? 'Enter a question' : null,
                                    onChanged: (val) {
                                      setState(() => question = val);
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8, 20, 8, 8),
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
                                          if (_formKey.currentState
                                              .validate()) {
                                            final user = Provider.of<User>(
                                                context,
                                                listen: false);
                                            dynamic result =
                                                await databaseService
                                                    .askQuestion(
                                                        user.uid,
                                                        title,
                                                        subject,
                                                        question);
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
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  color: white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                      content: new Text(error,
                                                          style: GoogleFonts.poppins(
                                                              color:
                                                                  whiteOpacity,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                      actions: <Widget>[
                                                        new FlatButton(
                                                          child: new Text(
                                                              "Close",
                                                              style: GoogleFonts.poppins(
                                                                  color: white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
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
                        ]))),
              ));
        });
  }

  Widget buildQuestionTile(Widget icon, String title, String desc, int votes,
      String time, bool isVoted) {
    int displayedVotes = votes;

    return Container(
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: elementColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      margin: EdgeInsets.only(bottom: 15.0),
      child: Column(
        children: [
          Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 10, 20, 10),
                  child: icon,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(title,
                          style: GoogleFonts.poppins(
                              color: white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15)),
                      SizedBox(
                        width: 230,
                        child: Text(desc,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            softWrap: true,
                            style: GoogleFonts.poppins(
                                color: whiteOpacity,
                                fontWeight: FontWeight.w400,
                                fontSize: 12)),
                      ),
                    ],
                  ),
                )
              ]),
          Padding(
            padding: const EdgeInsets.fromLTRB(17.5, 5, 17.5, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        color: isVoted ? buttonBlue : Colors.transparent,
                        borderRadius: BorderRadius.circular(6)),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                            child: Icon(Icons.thumb_up,
                                size: 13,
                                color: isVoted
                                    ? isLightTheme
                                        ? canvasColor
                                        : white
                                    : whiteOpacity),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                            child: Text(displayedVotes.toString(),
                                style: GoogleFonts.poppins(
                                    color: isVoted
                                        ? isLightTheme
                                            ? canvasColor
                                            : white
                                        : whiteOpacity,
                                    fontWeight: isVoted
                                        ? FontWeight.w500
                                        : FontWeight.w400,
                                    fontSize: 12)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Text('posted ' + time + ' ago',
                    style: GoogleFonts.poppins(
                        color: whiteOpacity,
                        fontWeight: FontWeight.w400,
                        fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildQuestionTileFromDatabase(
      BuildContext context, DocumentSnapshot document) {
    final forum = UserTypedForumQuery.fromSnapshot(document);

    return Container(
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: elementColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      margin: EdgeInsets.only(bottom: 15.0),
      child: Column(
        children: [
          Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 10, 20, 10),
                  child: forum.icon,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(forum.title,
                          style: GoogleFonts.poppins(
                              color: white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15)),
                      SizedBox(
                        width: 230,
                        child: Text(forum.content,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            softWrap: true,
                            style: GoogleFonts.poppins(
                                color: whiteOpacity,
                                fontWeight: FontWeight.w400,
                                fontSize: 12)),
                      ),
                    ],
                  ),
                )
              ]),
          Padding(
            padding: const EdgeInsets.fromLTRB(17.5, 5, 17.5, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        color: forum.isVoted ? buttonBlue : Colors.transparent,
                        borderRadius: BorderRadius.circular(6)),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                            child: Icon(Icons.thumb_up,
                                size: 13,
                                color: forum.isVoted
                                    ? isLightTheme
                                        ? canvasColor
                                        : white
                                    : whiteOpacity),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                            child: Text(forum.votes.toString(),
                                style: GoogleFonts.poppins(
                                    color: forum.isVoted
                                        ? isLightTheme
                                            ? canvasColor
                                            : white
                                        : whiteOpacity,
                                    fontWeight: forum.isVoted
                                        ? FontWeight.w500
                                        : FontWeight.w400,
                                    fontSize: 12)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Text('posted ' + forum.time + ' ago',
                    style: GoogleFonts.poppins(
                        color: whiteOpacity,
                        fontWeight: FontWeight.w400,
                        fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  var userTypedForumEvents = [];

  Future resultsLoaded;
  TextEditingController _searchbarController = new TextEditingController();

  getDocsInForums() async {
    final user = Provider.of<User>(context, listen: false);
    var fData = await DatabaseService(uid: user.uid).getForums.getDocuments();
    setState(() {
      userTypedForumEvents = fData.documents;
    });
    return fData.documents;
  }

  @override
  void initState() {
    setState(() {
      modalDate = DateTime.now();
    });
    _searchbarController.addListener(onValueChanged);
    super.initState();
  }

  onValueChanged() {
    var valList = [];

    if (_searchbarController.text != '') {
      setState(() {
        userTypedInput = true;
        for(var question in userTypedForumEvents) {
          var title = UserTypedForumQuery.fromSnapshot(question).title.toLowerCase();
          if (title.contains(_searchbarController.text.toLowerCase())) {
            valList.add(question);
          }
        }
      });
    } else {
      setState(() {
        userTypedInput = false;
        valList = [];
      });
    }
    setState(() {
      userTypedForumEvents = valList;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getDocsInForums();
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
                                  'Forum',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                      color: white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 25.0),
                                ),
                              ),
                            ]),
                        Container(
                          height: 50,
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                          decoration: BoxDecoration(
                            color: elementColor,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _searchbarController,
                                  maxLines: 1,
                                  maxLengthEnforced: true,
                                  decoration: searchbarDecoration.copyWith(
                                      hintText: 'Search'),
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: white),
                                ),
                              ),
                              userTypedInput
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _searchbarController.text = '';
                                          userTypedInput = false;
                                        });
                                      },
                                      child: Icon(
                                      MdiIcons.windowClose,
                                      size: 18,
                                      color: whiteOpacity,
                                    ))
                                  : Icon(
                                      Icons.search,
                                      size: 18,
                                      color: whiteOpacity,
                                    )
                            ],
                          ),
                        ),
                        Container(
                          height: 30,
                          margin: EdgeInsets.only(bottom: 15),
                          child: buildTopicCardList(
                            buildCard('Popular', buttonBlue, 0, true),
                            buildCard('Math', mathColor, 1, false),
                            buildCard('Science', scienceColor, 2, false),
                            buildCard('English', englishColor, 3, false),
                            buildCard('Reading', readingColor, 4, false),
                          ),
                        ),
                        StreamBuilder<QuerySnapshot>(
                            stream: DatabaseService(uid: user.uid)
                                .getForums
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                QuerySnapshot forumQuestion = snapshot.data;
                                List initialForumEvents = forumQuestion
                                    .documents
                                    .where((forumQ) => forumQ['votes'] > 4)
                                    .toList();
                                List userSelectedForumEvents = forumQuestion
                                    .documents
                                    .where((forumQ) =>
                                        (forumQ['subject'] == selectedSubject))
                                    .toList();
                                return StreamProvider<
                                        List<ForumQuestion>>.value(
                                    value: DatabaseService().forums,
                                    child: userTypedInput
                                        ? ListView.builder(
                                            itemCount:
                                                userTypedForumEvents.length,
                                            shrinkWrap: true,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return buildQuestionTileFromDatabase(
                                                  context,
                                                  userTypedForumEvents[index]);
                                            },
                                          )
                                        : userSelectedSubject
                                            ? Column(
                                                children: [
                                                  for (var forumQ
                                                      in userSelectedForumEvents)
                                                    (() {
                                                      Widget icon;

                                                      Widget iconChooser(
                                                          String subject) {
                                                        if (subject == 'Math') {
                                                          icon = mathLogoBig;
                                                        } else if (subject ==
                                                            'Reading') {
                                                          icon = readingLogoBig;
                                                        } else if (subject ==
                                                            'English') {
                                                          icon = englishLogoBig;
                                                        } else if (subject ==
                                                            'Science') {
                                                          icon = scienceLogoBig;
                                                        } else {
                                                          icon = notiLogoBig;
                                                        }
                                                        return icon;
                                                      }

                                                      return buildQuestionTile(
                                                          iconChooser(forumQ[
                                                              'subject']),
                                                          forumQ['title'],
                                                          forumQ['content'],
                                                          forumQ['votes'],
                                                          '3 mins',
                                                          forumQ['isVoted']);
                                                    }())
                                                ],
                                              )
                                            : Column(
                                                children: [
                                                  for (var forumQ
                                                      in initialForumEvents)
                                                    (() {
                                                      Widget icon;

                                                      Widget iconChooser(
                                                          String subject) {
                                                        if (subject == 'Math') {
                                                          icon = mathLogoBig;
                                                        } else if (subject ==
                                                            'Reading') {
                                                          icon = readingLogoBig;
                                                        } else if (subject ==
                                                            'English') {
                                                          icon = englishLogoBig;
                                                        } else if (subject ==
                                                            'Science') {
                                                          icon = scienceLogoBig;
                                                        } else {
                                                          icon = notiLogoBig;
                                                        }
                                                        return icon;
                                                      }

                                                      return buildQuestionTile(
                                                        iconChooser(
                                                            forumQ['subject']),
                                                        forumQ['title'],
                                                        forumQ['content'],
                                                        forumQ['votes'],
                                                        '3 mins',
                                                        forumQ['isVoted'],
                                                      );
                                                    }())
                                                ],
                                              ));
                              } else {
                                return Loading();
                              }
                            }),
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
                                  'Ask A Question',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      color: isLightTheme ? canvasColor : white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.0),
                                ),
                                onPressed: () {
                                  askQuestionModal(context);
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

  Widget buildCard(String title, Color color, int index, bool isActive) {
    return InkWell(
      onTap: () {
        if (title == 'Popular') {
          setState(() {
            _selectedIndex = index;
            selectedSubject = title;
            userSelectedSubject = false;
          });
        } else {
          setState(() {
            _selectedIndex = index;
            selectedSubject = title;
            userSelectedSubject = true;
          });
        }
      },
      splashColor: color,
      radius: 0.1,
      child: Opacity(
        opacity: _selectedIndex == index ? 1 : .4,
        child: Container(
          padding: EdgeInsets.all(7.0),
          margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                color: isLightTheme ? canvasColor : white,
                fontSize: 12,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget buildTopicCardList(
      Widget card, Widget card2, Widget card3, Widget card4, Widget card5) {
    return ListView(
        controller: _cardController,
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(
            child: card,
          ),
          SizedBox(
            child: card2,
          ),
          SizedBox(
            child: card3,
          ),
          SizedBox(
            child: card4,
          ),
          SizedBox(
            child: card5,
          ),
        ]);
  }
}

/*class Searchbar extends StatefulWidget {
  @override
  _SearchbarState createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  Widget searchbar;

  TextEditingController _controller = new TextEditingController(text: 'Search');

  Widget icon = Icon(
    Icons.search,
    size: 18,
    color: whiteOpacity,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(userInput);
    print(userTypedInput);
    return Container(
      height: 50,
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
      decoration: BoxDecoration(
        color: elementColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: TextField(
              maxLines: 1,
              maxLengthEnforced: true,
              onChanged: (val) {
                setState(() {
                  userInput = val;
                  if (val == '') {
                    userTypedInput = false;
                    icon = Icon(
                      Icons.search,
                      size: 18,
                      color: whiteOpacity,
                    );
                  } else {
                    userTypedInput = true;
                    icon = Icon(
                      MdiIcons.windowClose,
                      size: 18,
                      color: whiteOpacity,
                    );
                  }
                });
              },
              decoration: searchbarDecoration.copyWith(hintText: 'Search'),
              style: GoogleFonts.poppins(
                  fontSize: 15, fontWeight: FontWeight.w500, color: white),
            ),
          ),
          icon,
        ],
      ),
    );
  }
}*/

/*class QuestionTileList extends StatefulWidget {
  @override
  _QuestionTileListState createState() => _QuestionTileListState();
}

class _QuestionTileListState extends State<QuestionTileList> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<QuerySnapshot>(
        stream: DatabaseService(uid: user.uid).getForums.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            QuerySnapshot forumQuestion = snapshot.data;
            List initialForumEvents = forumQuestion.documents
                .where((forumQ) => forumQ['votes'] > 4)
                .toList();
            List userSelectedForumEvents = forumQuestion.documents
                .where((forumQ) => (forumQ['subject'] == selectedSubject))
                .toList();
            List userTypedForumEvents = forumQuestion.documents
                .where((forumQ) => (forumQ['title'] == userInput))
                .toList();
            return StreamProvider<List<ForumQuestion>>.value(
                value: DatabaseService().forums,
                child: userTypedInput ? Column(
                        children: [
                          for (var forumQ in userTypedForumEvents)
                            (() {
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

                              return buildQuestionTile(
                                  iconChooser(forumQ['subject']),
                                  forumQ['title'],
                                  forumQ['content'],
                                  forumQ['votes'],
                                  '3 mins',
                                  forumQ['isVoted']);
                            }())
                        ],
                      )
                : userSelectedSubject
                    ? Column(
                        children: [
                          for (var forumQ in userSelectedForumEvents)
                            (() {
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

                              return buildQuestionTile(
                                  iconChooser(forumQ['subject']),
                                  forumQ['title'],
                                  forumQ['content'],
                                  forumQ['votes'],
                                  '3 mins',
                                  forumQ['isVoted']);
                            }())
                        ],
                      )
                    : Column(
                        children: [
                          for (var forumQ in initialForumEvents)
                            (() {
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

                              return buildQuestionTile(
                                iconChooser(forumQ['subject']),
                                forumQ['title'],
                                forumQ['content'],
                                forumQ['votes'],
                                '3 mins',
                                forumQ['isVoted'],
                              );
                            }())
                        ],
                      ));
          } else {
            return Loading();
          }
        });
  }

  Widget buildQuestionTile(Widget icon, String title, String desc, int votes,
      String time, bool isVoted) {
    int displayedVotes = votes;

    return Container(
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: elementColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      margin: EdgeInsets.only(bottom: 15.0),
      child: Column(
        children: [
          Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 10, 20, 10),
                  child: icon,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(title,
                          style: GoogleFonts.poppins(
                              color: white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15)),
                      SizedBox(
                        width: 230,
                        child: Text(desc,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            softWrap: true,
                            style: GoogleFonts.poppins(
                                color: whiteOpacity,
                                fontWeight: FontWeight.w400,
                                fontSize: 12)),
                      ),
                    ],
                  ),
                )
              ]),
          Padding(
            padding: const EdgeInsets.fromLTRB(17.5, 5, 17.5, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        color: isVoted ? buttonBlue : Colors.transparent,
                        borderRadius: BorderRadius.circular(6)),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                            child: Icon(Icons.thumb_up,
                                size: 13,
                                color: isVoted
                                    ? isLightTheme
                                        ? canvasColor
                                        : white
                                    : whiteOpacity),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                            child: Text(displayedVotes.toString(),
                                style: GoogleFonts.poppins(
                                    color: isVoted
                                        ? isLightTheme
                                            ? canvasColor
                                            : white
                                        : whiteOpacity,
                                    fontWeight: isVoted
                                        ? FontWeight.w500
                                        : FontWeight.w400,
                                    fontSize: 12)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Text('posted ' + time + ' ago',
                    style: GoogleFonts.poppins(
                        color: whiteOpacity,
                        fontWeight: FontWeight.w400,
                        fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}*/
