import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoneyManage extends StatefulWidget {
  const MoneyManage({Key? key}) : super(key: key);

  @override
  State<MoneyManage> createState() => _MoneyManageState();
}

class _MoneyManageState extends State<MoneyManage> {
  @override
  String? isSelectedItem = 'aaa';
  int options = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('売上・仕入申請')),
      body: Column(
        children: [
          Text(
            '券売機での売り上げはいくらですか？',
            style: TextStyle(fontSize: 20.sp),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 200.w,
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                ),
              ),
              Text('円')
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            'レジでの売り上げはいくらですか？',
            style: TextStyle(fontSize: 20.sp),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 200.w,
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                ),
              ),
              Text('円')
            ],
          ),
          SizedBox(height: 25.h),
          Text(
            '仕入はいくらですか？',
            style: TextStyle(fontSize: 20.sp),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 275.h,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                String title;
                switch (index) {
                  case 0:
                    title = '肉';
                    break;
                  case 1:
                    title = '八百';
                    break;
                  case 2:
                    title = '製麺';
                    break;
                  case 3:
                    title = '萬味';
                    break;
                  case 3:
                    title = '酒屋';
                    break;
                  case 3:
                    title = 'ガソリン';
                    break;
                  case 3:
                    title = '駐車場';
                    break;

                  default:
                    title = 'オプション';
                    break;
                }
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        title == 'オプション'
                            ? SizedBox(
                                width: 100.w,
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                                ),
                              )
                            : Text(
                                '$title屋',
                                style: TextStyle(fontSize: 20.sp),
                              ),
                        Spacer(),
                        SizedBox(
                          width: 200.w,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                          ),
                        ),
                        Text('円')
                      ],
                    ),
                    SizedBox(height: 10.h),

                    // SizedBox(
                    //   height: 50.h,
                    //   child: ListTile(
                    //     tileColor: Colors.grey,
                    //     title: Text(
                    //         '${strInfo[index]}:${timeInfo[index].hour}時${timeInfo[index].minute}分'),
                    //   ),
                    // ),
                    SizedBox(
                      height: 5.h,
                    ),
                  ],
                );
              },
            ),
          ),
          Spacer(),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(horizontal: 30)),
              child: const Text("申請", style: TextStyle(color: Colors.white)),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
