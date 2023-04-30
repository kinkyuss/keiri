import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InOutRest extends StatefulWidget {
  const InOutRest({Key? key}) : super(key: key);

  @override
  State<InOutRest> createState() => _InOutRestState();
}

class _InOutRestState extends State<InOutRest> {
  List<DateTime> timeInfo = [];
  List<String> strInfo = [];
  bool rest=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('出勤・退勤・休憩')),
      body: Center(
        child: Column(
          children: [
            Text(
              '今日の記録',
              style: TextStyle(fontSize: 30.sp),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: 230.h,
              child: ListView.builder(
                itemCount: timeInfo.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [

                      SizedBox(
                        height: 50.h,
                        child: ListTile(
                          tileColor: Colors.grey,
                          title: Text(
                              '${strInfo[index]}:${timeInfo[index].hour}時${timeInfo[index].minute}分'),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height:15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 80.h,
                      width: 80.w,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: CircleBorder(),
                        ),
                        onPressed: () {
                          setState(() {
                            strInfo.add('出勤');
                            timeInfo.add(DateTime.now());
                          });
                        },
                        child: Icon(Icons.input, size: 50.sp),
                      ),
                    ),
                    Text(
                      '出勤',
                      style: TextStyle(fontSize: 25.sp),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 80.h,
                      width: 80.w,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: EdgeInsets.zero,
                          shape: CircleBorder(),
                        ),
                        onPressed: () {
                          setState(() {
                            strInfo.add('退勤');
                            timeInfo.add(DateTime.now());

                          });

                        },
                        child: Icon(Icons.input, size: 50.sp),
                      ),
                    ),
                    Text(
                      '退勤',
                      style: TextStyle(fontSize: 25.sp),
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 40.h),
            Column(
              children: [
                SizedBox(
                  height: 80.h,
                  width: 80.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: CircleBorder(),
                        backgroundColor: Colors.green),
                    onPressed: () {
                      setState(() {
                        strInfo.add('休憩${rest?'終了':'開始'}');
                        timeInfo.add(DateTime.now());
                        rest=!rest;
                      });

                    },
                    child: Icon(Icons.input, size: 50.sp),
                  ),
                ),
                Text(
                    '休憩${rest?'終了':'開始'}',
                  style: TextStyle(fontSize: 25.sp),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
