import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keiri/screen/employee/shift_request.dart';
import 'package:keiri/screen/store/money_manage.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'screen/manage/money_manage_decision.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
        designSize: const Size(360, 640),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale("en"),
              const Locale('ja'),
            ],
            // locale: const Locale('ja'),
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: MoneyManageDecision(),
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    print(
      DateTime.now(),
    );
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.grey, title: Text('カレンダー')),
      body: Localizations.override(
        context: context,
        locale: Locale('ja'),
        child: SfCalendar(
          backgroundColor: Colors.white,
          view: CalendarView.week,
          firstDayOfWeek: 6,
          initialDisplayDate: DateTime.now(),
          //initialSelectedDate: DateTime(2021, 03, 01, 08, 30),
          dataSource: MeetingDataSource(getAppointments()),
        ),
      ),
    );
  }
}

List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  print(today.day);

  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0).toLocal();
  final DateTime endTime = startTime.add(const Duration(hours: 2)).toLocal();

  meetings.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: '松村',
      color: Colors.blue,
      // recurrenceRule: 'FREQ=DAILY;COUNT=10',
      isAllDay: false));

  meetings.add(Appointment(
      startTime: startTime.add(Duration(hours: 1)),
      endTime: endTime.add(Duration(hours: 1)),
      subject: '自分',
      color: Colors.red,
      // recurrenceRule: 'FREQ=DAILY;COUNT=10',
      isAllDay: false));
  meetings.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: '長野',
      color: Colors.blue,
      // recurrenceRule: 'FREQ=DAILY;COUNT=10',
      isAllDay: false));
  meetings.add(Appointment(
      startTime: startTime.add(Duration(hours: 32)),
      endTime: endTime.add(Duration(hours: 35)),
      subject: '田中',
      color: Colors.blue,
      // recurrenceRule: 'FREQ=DAILY;COUNT=10',
      isAllDay: false));

  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
