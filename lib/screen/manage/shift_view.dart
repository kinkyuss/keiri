import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keiri/main.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ShiftView extends StatefulWidget {
  const ShiftView({Key? key}) : super(key: key);

  @override
  State<ShiftView> createState() => _ShiftViewState();
}

class _ShiftViewState extends State<ShiftView> {
  bool onTap = false;
  bool di = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('シフト管理画面')),
      body: Column(
        children: [
          SizedBox(
            height: onTap ? 400.h : 570.h,
            child: SfCalendar(
              onTap: (s) {
                setState(() {
                  onTap = true;
                });
                print(s.date);
              },
              dataSource: MeetingDataSource([
                Appointment(
                  subject: '田 11:00～12:00',
                  startTime: DateTime.now(),
                  endTime: DateTime.now(),
                ),
                Appointment(
                  subject: '佐 12:00～13:00',
                  startTime: DateTime.now(),
                  endTime: DateTime.now(),
                ),
                Appointment(
                  subject: '田 11:00',
                  startTime: DateTime.now(),
                  endTime: DateTime.now(),
                ),
                Appointment(
                  subject: '田 11:00',
                  startTime: DateTime.now(),
                  endTime: DateTime.now(),
                ),
                Appointment(
                  subject: '佐 11:00',
                  startTime: DateTime.now(),
                  endTime: DateTime.now(),
                )
              ]),
              monthViewSettings: MonthViewSettings(
                  appointmentDisplayMode:
                      MonthAppointmentDisplayMode.appointment),

              // monthViewSettings : MonthViewSettings ( showAgenda : true ),
              // dataSource:[Appointment(startTime: DateTime.now(), endTime: DateTime.niw)],
              backgroundColor: Colors.white,
              view: CalendarView.month,
            ),
          ),
          onTap
              ? Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            onTap = false;
                          });
                        },
                        child: Text(
                          'カレンダーの拡大',
                          style: TextStyle(fontSize: 15.sp),
                        )),
                    ListTile(
                        trailing: IconButton(
                          icon: Icon(Icons.more_vert),
                          onPressed: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) {
                                return AlertDialog(
                                  title: Text('承認or非承認'),
                                  actions: [
                                    TextButton(
                                      child: Text(
                                        "非承認",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                    TextButton(
                                      child: Text("承認"),
                                      onPressed: () => print('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        tileColor: Colors.grey,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('田中豊'), Text('11:00～12:00')],
                        )),
                    SizedBox(
                      height: 5.h,
                    ),
                    ListTile(
                        trailing: IconButton(
                            icon: Icon(Icons.more_vert),
                            onPressed: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) {
                                  return AlertDialog(
                                    title: Text('承認or非承認'),
                                    actions: [
                                      TextButton(
                                        child: Text(
                                          "非承認",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                      TextButton(
                                        child: Text("承認"),
                                        onPressed: () => print('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }),
                        tileColor: Colors.grey,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('佐藤花子'), Text('12:00～13:00')],
                        )),
                  ],
                )
              : SizedBox(
                  height: 0.h,
                ),
        ],
      ),
    );
  }
}
