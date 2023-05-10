import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keiri/view_moedl/auth_view_model.dart';
import 'package:keiri/widgets/alert_message.dart';
import 'package:keiri/widgets/drawer.dart';
import 'package:keiri/widgets/my_text_field.dart';

class InOutRest extends ConsumerStatefulWidget {
  const InOutRest({Key? key}) : super(key: key);

  @override
  ConsumerState<InOutRest> createState() => _InOutRestState();
}

class _InOutRestState extends ConsumerState<InOutRest> {
  List<DateTime> timeInfo = [];
  List<String> strInfo = [];
  bool rest = false;
  String? name;
  late String uid;
  bool process = false;
  bool nameSuccess = false;
  String? password;
  bool passwordSuccess = false;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: CustomDrawer(),
      appBar: AppBar(title: Text('出勤・退勤・休憩')),
      body: Center(
        child: Column(
          children: [
            Text(
              '今日(${now.month}月${now.day}日)の記録',
              style: TextStyle(fontSize: 25.sp),
            ),
            SizedBox(height: 5.h),
            passwordSuccess
                ? Column(
                    children: [
                      Text('$nameさんの記録', style: TextStyle(fontSize: 15.sp)),
                      SizedBox(
                        height: 10.h,
                      )
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                          height: 55.h,
                          width: 380.w,
                          child: MyTextField(

                              hintText: 'お名前を入力してください。',
                              onChanged: (value) {

                                name = value;
                              })),
                      SizedBox(height: 15.h),
                      nameSuccess
                          ? SizedBox(
                              height: 55.h,
                              width: 380.w,
                              child: MyTextField(
                                number: true,
                                  hintText: '第二のパスワードを入力してください。',
                                  onChanged: (value) {
                                    password = value;
                                  }))
                          : SizedBox(),
                      process
                          ? Container(
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator(
                                color: Colors.green,
                              ))
                          : ElevatedButton(
                              onPressed: () async {
                                if (!nameSuccess) {
                                  if (name == null) return;
                                  setState(() {
                                    process = true;
                                  });
                                  uid = await ref
                                      .read(authViewModelProvider.notifier)
                                      .nameSearch(name!);
                                  setState(() {
                                    process = false;
                                  });
                                  if (uid == 'Data does not exist.') {
                                    AlertMessageDialog.show(
                                        context, 'あなたの名前は登録されていません。', '');
                                  } else {
                                    setState(() {
                                      nameSuccess = true;
                                    });
                                  }
                                } else {
                                  if (password == null) return;
                                  setState(() {
                                    process = true;
                                  });
                                  bool check = await ref
                                      .read(authViewModelProvider.notifier)
                                      .passwordCheck(uid, password!);
                                  setState(() {
                                    process = false;
                                  });

                                  if (check) {
                                    setState(() {
                                      passwordSuccess = true;
                                    });
                                  } else {
                                    AlertMessageDialog.show(
                                        context,
                                        '第二のパスワードが間違っています。',
                                        '第二のパスワードは数字のみのものです。');
                                  }
                                }
                              },
                              child: Text(nameSuccess ? '決定' : '検索'),
                            )
                    ],
                  ),
            passwordSuccess
                ? Column(
                    children: [
                      SizedBox(
                        height: 240.h,
                        child: ListView.builder(
                          physics: null,
                          itemCount: timeInfo.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(children: [
                              SizedBox(
                                height: 30.h,
                                width: double.infinity,
                                child: Container(
                                  color: Colors.grey,
                                  child: Text(
                                    '${strInfo[index]}:${timeInfo[index].hour}時${timeInfo[index].minute}分',
                                    style: TextStyle(fontSize: 20.sp),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                            ]);
                          },
                        ),
                      ),
                      SizedBox(height: 5.h),
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
                      SizedBox(height: 20.h),
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
                                      backgroundColor: Colors.green),
                                  onPressed: () {
                                    setState(() {
                                      strInfo.add('休憩${rest ? '終了' : '開始'}');
                                      timeInfo.add(DateTime.now());
                                      rest = !rest;
                                    });
                                  },
                                  child: Icon(Icons.input, size: 50.sp),
                                ),
                              ),
                              Text(
                                '休憩${rest ? '終了' : '開始'}',
                                style: TextStyle(fontSize: 25.sp),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 80.h,
                                width: 80.w,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                    padding: EdgeInsets.zero,
                                    shape: CircleBorder(),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        String inputText = '';

                                        return AlertDialog(
                                          title: Text('何円分のまかないですか？'),
                                          content: TextField(
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            onChanged: (text) {
                                              inputText = text;
                                            },
                                          ),
                                          actions: [
                                            TextButton(
                                              child: Text('キャンセル',
                                                  style: TextStyle(
                                                      color: Colors.red)),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: Text('OK'),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(inputText);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    ).then((result) {
                                      if (result != null) {
                                        setState(() {
                                          strInfo.add('$result円分のまかない');
                                          timeInfo.add(DateTime.now());
                                        });


                                      }
                                    });
                                  },
                                  child: Icon(Icons.food_bank, size: 50.sp),
                                ),
                              ),
                              Text(
                                'まかない',
                                style: TextStyle(fontSize: 25.sp),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
