import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoneyManageDecision extends StatefulWidget {
  const MoneyManageDecision({Key? key}) : super(key: key);

  @override
  State<MoneyManageDecision> createState() => _MoneyManageDecisionState();
}

class _MoneyManageDecisionState extends State<MoneyManageDecision> {
  int choiceIndex = 0;
  int sum=1484;
  int rieki=1000;
  int rieki2=-1;
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('売上・仕入申請確認')),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              choiceContainer(0),
              choiceContainer(1),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(child: Text('元に戻す'),onPressed: (){}),
              TextButton(child: Text('変更する',style: TextStyle(color: Colors.red),),onPressed: (){
                setState(() {
                  rieki=700;
                  rieki2=-10;
                  sum=1175;

                });
              }),
            ],
          ),
          DataTable(
            columns: [
              DataColumn(
                  label: Expanded(
                      child: Text(
                '売上',
                textAlign: TextAlign.right,
              ))),
              DataColumn(
                  label: Expanded(
                      child: Text(
                        '仕入',
                        textAlign: TextAlign.right,
                      ))),        DataColumn(
                  label: Expanded(
                      child: Text(
                        '金額',
                        textAlign: TextAlign.right,
                      ))),        DataColumn(
                  label: Expanded(
                      child: Text(
                        '利益',
                        textAlign: TextAlign.right,
                      ))),
            ],
            rows: [
              DataRow(
                cells: [
                  DataCell(Align(
                      alignment: Alignment.centerRight, child: Text('券売機'))),
                  DataCell(Text('')),
                  DataCell(
                      TextFormField(
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(hintText: "1000"),
                        initialValue: '1000',
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                        onChanged: (String value) {},
                        onFieldSubmitted: (val) {
                          print('onSubmited $val');
                        },
                      ),
                    ),
                  DataCell(Text('+${rieki.toString()}')),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Align(
                      alignment: Alignment.centerRight, child: Text('レジ'))),
                  DataCell(Text('')),
                  DataCell(
                      TextFormField(
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(hintText: "Some Hint"),
                        initialValue: '500',
                        onChanged: (String value) {},
                        onFieldSubmitted: (val) {
                          print('onSubmited $val');
                        },
                      ),
                    ),
                  DataCell(Text('  +500')),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text('')),
                  DataCell(Text('八百屋')),
                  DataCell(
                      TextFormField(
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(hintText: "Some Hint"),
                        initialValue: '10',
                        onChanged: (String value) {},
                        onFieldSubmitted: (val) {
                          print('onSubmited $val');
                        },
                      ),
                  ),
                  DataCell(Text('     -10')),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text('')),
                  DataCell(Text('製麺屋')),
                  DataCell(
                      TextFormField(
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(hintText: "Some Hint"),
                        initialValue: '5',
                        onChanged: (String value) {},
                        onFieldSubmitted: (val) {
                          print('onSubmited $val');
                        },
                      ),
                      ),
                  DataCell(Text('       -5')),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text('')),
                  DataCell(Text('接待費')),
                  DataCell(
                      TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(hintText: "1"),
                        initialValue: '1',
                        onChanged: (String value) {},
                        onFieldSubmitted: (val) {
                          print('onSubmited $val');
                        },
                      ),
                      ),
                  DataCell(Align(alignment:Alignment.centerRight,child: Text('-${rieki2.toString()}'))),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text('')),
                  DataCell(Text('')),
                  DataCell(Text(' 合計')),
                  DataCell(Align(alignment:Alignment.centerRight,child: Text(sum.toString()))),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  InkWell choiceContainer(int index) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
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
