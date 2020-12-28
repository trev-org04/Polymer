import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

class Analytics extends StatefulWidget {
  @override
  _AnalyticsState createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {

  var data = [100.0, 80.0, 30.0, 40.0, 60.0, 95.0];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xff181818),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text('Battery',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xffEDF7F6), fontFamily: 'Nunito')),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Sparkline(
                      data: data,
                      lineColor: Color(0xffEDF7F6),
                      pointsMode: PointsMode.all,
                      pointSize: 8.0,
                      pointColor: Color(0xffbdbbb0),
                    ),
                  )
                ],
              )),
        ),
        Expanded(
          child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xff181818),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text('Mileage',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xffEDF7F6), fontFamily: 'Nunito')),
                                        Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Sparkline(
                      data: data,
                      lineColor: Color(0xffEDF7F6),
                      pointsMode: PointsMode.all,
                      pointSize: 8.0,
                      pointColor: Color(0xffbdbbb0),
                    ),
                  )
                ]
              )
        )
        )],
    );
  }
}
