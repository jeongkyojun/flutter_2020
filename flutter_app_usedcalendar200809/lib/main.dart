import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

Map<DateTime, List> _holidays = {
  DateTime(2020, 1, 1): ['New Year\'s Day'],
  DateTime(6): ['Epiphany'],
  DateTime(2020, 2, 14): ['Valentine\'s Day'],
  DateTime(2020, 4, 21): ['New Year\'s Day'],
  DateTime(2020, 4, 22): ['New Year\'s Day'],
};
Map<DateTime, List> _calendar = {
};

void main() {
  //intl 패키지 사용을 위한 runApp 함수 호출
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Table Calendar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Table Calendar Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents,_selectedHolidays;

  // 애니메이션 컨트롤러와 캘린더 컨트롤러 선언
  AnimationController _animationController;
  CalendarController _calendarController;

  AnimationController animationController2;
  Animation<double> animation;

  Map<DateTime, List> input_events()
  {
    Map<DateTime, List> events={
      DateTime(2020, 3, 4): ["신입생 수강신청",],
      DateTime(2020, 3, 5): ["신입생 수강신청",],
      DateTime(2020, 3, 12): ["신입생 추가 수강신청",],
      DateTime(2020, 3, 13): ["신입생 추가 수강신청"],
    };
    for(var i=0;i<10;i++) {
      if (events[DateTime(2020,i+1,i+2)]==null)
        events[DateTime(2020,i+1,i+2)] = [];
      events[DateTime(2020,i+1,i+2)].add('events ${i+1}');
    }
    return events;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final _selectedDay = DateTime.now();
    _calendarController = CalendarController();
    _events = input_events();
    _selectedEvents = _events[_selectedDay] ?? []; //널값인지 아닌지를 확인할 것!
    _selectedHolidays = _holidays[_selectedDay]??[];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animationController.forward();

    animationController2 = AnimationController(vsync:this, duration:Duration(milliseconds: 100));
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController2);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(DateTime fitst, DateTime last,
      CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(DateTime first, DateTime last,
      CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "학사일정",
          style: TextStyle(
            color: const Color(0xff842fb5),
            fontWeight: FontWeight.w300,
            fontFamily: "NotoSansKR",
            fontStyle: FontStyle.normal,
            fontSize: 20.0,
          ),
        ),
        titleSpacing: -15,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.navigate_before),
          color: Color(0xff793cc2),
        ),
      ),


      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          //_buildTableCalendar(),
          _buildTableCalendarWithBuilders(),
          const SizedBox(height: 8.0),
          //_buildButtons(),
          const SizedBox(height: 8.0),
          Expanded(child:
              _buildEventList(),
          ),
          Expanded(child:
              _buildHolidayList(),
          ),
        ],
      ),
    );
  }
    Widget _buildTableCalendarWithBuilders() {
      return TableCalendar(
          locale: 'ko_KR',
          calendarController: _calendarController,
          events: _events,
          holidays: _holidays,
          initialCalendarFormat: CalendarFormat.month,
          formatAnimation: FormatAnimation.slide,
          calendarStyle: CalendarStyle(
            outsideDaysVisible: false,
            weekdayStyle: TextStyle().copyWith(color: Colors.blue[800]),
            holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
          ),

          daysOfWeekStyle: DaysOfWeekStyle(
            weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
          ),

          headerStyle: HeaderStyle(
            centerHeaderTitle: true,
            formatButtonVisible: false,
          ),

          builders: CalendarBuilders(
            selectedDayBuilder: (context, date, _) {
              return FadeTransition(
                opacity: Tween(begin: 0.0, end: 1.0).animate(
                    _animationController),
                child: Container(
                  margin: const EdgeInsets.all(4.0),
                  padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                  color: Colors.deepOrange[300],
                  width: 100,
                  height: 100,
                  child: Text(
                    '${date.day}',
                    style: TextStyle().copyWith(fontSize: 16.0),
                  ),
                ),
              );
            },
            todayDayBuilder:(context,date,_){
              return Container(
                margin:const EdgeInsets.all(4.0),
                padding:const EdgeInsets.only(top:5.0,left:6.0),
                color:Colors.amber[400],
                width:100,
                height:100,
                child:Text(
                  '${date.day}',
                  style:TextStyle().copyWith(fontSize: 16.0),
                )
              );
            },
            markersBuilder: (context,date,events,holidays){
              final children = <Widget>[];

              if (events.isNotEmpty) {
                children.add(
                  Positioned(
                    right: 1,
                    bottom: 1,
                    child:_buildEventsMarker(date, events),
                  ),
                );
              }

              if (holidays.isNotEmpty) {
                children.add(
                  Positioned(
                    right: -2,
                    top: -2,
                    child:_buildHolidaysMarker(),
                  ),
                );
              }

              return children;
            },
          ),
        onDaySelected:(date,events){
            _onDaySelected(date,events);
            _animationController.forward(from:0.0);
        },
        onVisibleDaysChanged: _onVisibleDaysChanged,
        onCalendarCreated: _onCalendarCreated,
      );
    }

    Widget _buildEventsMarker(DateTime date, List events){
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          shape:BoxShape.rectangle,
          color: _calendarController.isSelected(date)?Colors.brown[500]
              :_calendarController.isToday(date)?Colors.brown[300]:Colors.blue[400],

        ),
        width:16.0,
        height:16.0,
        child:Center(
          child:Text(
            '${events.length}',
            style:TextStyle().copyWith(
              color:Colors.white,
              fontSize:12.0,
            ),
          ),
        )
      );
    }
    Widget _buildHolidaysMarker() {
      return Icon(
        Icons.add_box,
        size: 20.0,
        color: Colors.blueGrey[800],
      );
    }
    /*
    Widget _buildButtons() {
      final dateTime = _events.keys.elementAt(_events.length - 1);

      return Column(
        children: <Widget>[
          RaisedButton(
            child: Text('Set day ${dateTime.day}-${dateTime.month}-${dateTime.year}'),
            onPressed: () {
              _calendarController.setSelectedDay(
                DateTime(dateTime.year, dateTime.month, dateTime.day),
                runCallback: true,
              );
            },
          ),
        ],
      );
    }
    */
    Widget _buildEventList() {
      return ListView(
        children: _selectedEvents
            .map((event) => Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.8),
            borderRadius: BorderRadius.circular(12.0),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: ListTile(
            title: Text(event.toString()),
            onTap: () => print('$event tapped!'),
          ),
        ))
            .toList(),
      );
  }

  Widget _buildHolidayList() {
    return ListView(
      children: _selectedHolidays
          .map((event) => Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.8),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: ListTile(
          title: Text(event.toString()),
          onTap: () => print('$event tapped!'),
        ),
      ))
          .toList(),
    );
  }
}
