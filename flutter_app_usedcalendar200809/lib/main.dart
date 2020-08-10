import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

Map<DateTime, List> _holidays;
Map<DateTime,List> _calendar;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CalendarController _calendarController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final _selectedDay = DateTime.now();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width : 50,
              height : 50,
              child : TableCalendar(
                  calendarController: _calendarController,
                  builders:CalendarBuilders(
                    markersBuilder:(context, date, events, holidays){
                      final children = <Widget>[];

                   if (events.isNotEmpty){
                     children.add(
                       Positioned(
                         right:1,
                         bottom:1,

                       ),
                     );//if_events
                   }

                   if(holidays.isNotEmpty){
                     children.add(
                       Positioned(
                         right:-2,
                         top:-2,

                       ),
                     );//if_holidays
                   }

                   return children;
                 },
               )

           ),
            )
          ],
        ),
      ),
    );
  }
}
