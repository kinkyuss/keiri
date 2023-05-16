import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keiri/view_moedl/auth_view_model.dart';
import 'package:keiri/view_moedl/kintai_view_model.dart';
import 'package:keiri/widgets/alert_message.dart';
import 'package:keiri/widgets/drawer.dart';
import 'package:keiri/widgets/my_text_field.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class StaffKintai extends ConsumerStatefulWidget {
  const StaffKintai({Key? key}) : super(key: key);

  @override
  ConsumerState<StaffKintai> createState() => _StaffKintaiState();
}

class _StaffKintaiState extends ConsumerState<StaffKintai> {
  String? name;
  late String uid;
  bool nameSuccess = false;
  bool search = false;
  DateTime now = DateTime.now();
  late Map information;
  late Map dayInfo;
  DateTime? selectedMonth;
  int choiceIndex = 0;


  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();

    return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(title: Text('スタッフ出勤状況')),
        body: search
            ? Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  color: Colors.green,
                ))
            : Column(children: [
                Text('名前で検索', style: TextStyle(fontSize: 20.sp)),
                MyTextField(
                  controller: TextEditingController()..text = name ?? '',
                  onChanged: (String value) {
                    name = value;
                  },
                  hintText: '',
                ),
                SizedBox(height: 10.h),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      search = true;
                    });

                    uid = await ref
                        .read(authViewModelProvider.notifier)
                        .nameSearch(name!);
                    setState(() {
                      search = false;
                    });
                    if (uid == 'Data does not exist.') {
                      AlertMessageDialog.show(context, 'あなたの名前は登録されていません。', '');
                    } else {
                      DateTime month = DateTime(now.year, now.month, 1);
                      information = await ref
                          .read(kintaiProvider.notifier)
                          .getMonth(uid, month);
                      //
                      // setState(() {
                      //   nameSuccess = true;
                      // });
                    }
                  },
                  child: Text('決定'),
                ),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    choiceContainer(0),
                    choiceContainer(1),
                  ],
                ),
                nameSuccess
                    ? choiceIndex == 1
                        ? information == {}
                            ? Text('この月のデータはまだありません。')
                            : Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          selectedMonth == null
                                              ? '${now.year}年${now.month}月'
                                              : '${selectedMonth!.year}年${selectedMonth!.month}月',
                                          style: TextStyle(fontSize: 30.sp)),
                                      SizedBox(width: 5.w),
                                      IconButton(
                                          icon: Icon(Icons.change_circle,
                                              color: Colors.blue, size: 20.sp),
                                          onPressed: () async {
                                            selectedMonth =
                                                await showMonthPicker(
                                              locale: const Locale("ja", "JP"),
                                              // 追加
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(
                                                  DateTime.now().year - 1),
                                              lastDate: DateTime(
                                                  DateTime.now().year + 1),
                                            );
                                            if (selectedMonth == null) return;
                                            information = await ref
                                                .read(kintaiProvider.notifier)
                                                .getMonth(uid, selectedMonth!);
                                            setState(() {});
                                          })
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Expanded(
                                      child: DataTable(
                                        headingRowHeight: 0,
                                        columns: const [
                                          DataColumn(
                                            label: Text(''),
                                          ),
                                          DataColumn(label: Text('')),
                                        ],
                                        rows: [
                                          DataRow(
                                            cells: [
                                              DataCell(Text('合計出勤時間:')),
                                              DataCell(Text(
                                                  information['totalWork'])),
                                            ],
                                          ),
                                          DataRow(
                                            cells: [
                                              DataCell(Text('合計休憩時間')),
                                              DataCell(Text(
                                                  information['totalBreak'])),
                                            ],
                                          ),
                                          DataRow(
                                            cells: [
                                              DataCell(Text('まかない合計金額')),
                                              DataCell(Text(
                                                  information['totalMeal'])),
                                            ],
                                          ),
                                          DataRow(
                                            cells: [
                                              DataCell(Text('時給')),
                                              DataCell(Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(information[
                                                      'hourlyWage']),
                                                  TextButton(
                                                      style: ButtonStyle(
                                                        padding:
                                                            MaterialStateProperty
                                                                .all(EdgeInsets
                                                                    .zero),
                                                        minimumSize:
                                                            MaterialStateProperty
                                                                .all(Size.zero),
                                                        tapTargetSize:
                                                            MaterialTapTargetSize
                                                                .shrinkWrap,
                                                      ),
                                                      child: Text(
                                                        '編集',
                                                        style: TextStyle(
                                                            fontSize: 10.sp),
                                                      ),
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            String inputText =
                                                                '';

                                                            return AlertDialog(
                                                              title: Text('時給'),
                                                              content:
                                                                  TextField(
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                inputFormatters: [
                                                                  FilteringTextInputFormatter
                                                                      .digitsOnly
                                                                ],
                                                                onChanged:
                                                                    (text) {
                                                                  inputText =
                                                                      text;
                                                                },
                                                              ),
                                                              actions: [
                                                                TextButton(
                                                                  child: Text(
                                                                      'キャンセル',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.red)),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                                TextButton(
                                                                  child: Text(
                                                                      'OK'),
                                                                  onPressed:
                                                                      () async {
                                                                    await ref
                                                                        .read(authViewModelProvider
                                                                            .notifier)
                                                                        .upDateHourlyWage(
                                                                            uid,
                                                                            int.parse(inputText));
                                                                    information = await ref
                                                                        .read(kintaiProvider
                                                                            .notifier)
                                                                        .getMonth(
                                                                            uid,
                                                                            selectedMonth ??
                                                                                DateTime(now.year, now.month, 1));

                                                                    setState(
                                                                        () {});

                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(
                                                                            inputText);
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      }),
                                                ],
                                              )),
                                            ],
                                          ),
                                          DataRow(
                                            cells: [
                                              DataCell(Text('出勤-休憩 時間')),
                                              DataCell(Text(
                                                  information['zissitsu'])),
                                            ],
                                          ),
                                          DataRow(
                                            cells: [
                                              DataCell(
                                                  Text('給料-まかない　(15分単位で切り捨て)')),
                                              DataCell(
                                                  Text(information['salary'])),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    '退勤が押されていない日(カウントしていません)',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  SizedBox(
                                    height: 50.h,
                                    child: ListView.builder(
                                      itemCount: information['waste'].length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Center(
                                            child: Column(
                                          children: [
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Text(information['waste'][index]),
                                          ],
                                        ));
                                      },
                                    ),
                                  )
                                ],
                              )
                        : SizedBox()
                    : SizedBox(),
              ]));
  }

  InkWell choiceContainer(int index) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () async {
        if (index == 0) {
        } else {}
        setState(() {
          choiceIndex = index;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: 10.w, vertical: index == choiceIndex ? 7.h : 15.h),
        width: index == choiceIndex ? 100.w : 80.w,
        decoration: BoxDecoration(
          color: index == choiceIndex ? Colors.blueGrey : Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            child: Text(
          index == 0 ? '日' : '月',
          style: TextStyle(fontSize: index == choiceIndex ? 15.sp : 10.sp),
        )),
      ),
    );
  }
}

data() {}

//秋山春子
