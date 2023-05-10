import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keiri/view_moedl/money_view_model.dart';
import 'package:keiri/widgets/drawer.dart';

class MoneyManageDecision extends ConsumerStatefulWidget {
  const MoneyManageDecision({Key? key}) : super(key: key);

  @override
  ConsumerState<MoneyManageDecision> createState() =>
      _MoneyManageDecisionState();
}

class _MoneyManageDecisionState extends ConsumerState<MoneyManageDecision> {
  int choiceIndex = 0;
  int sum = 1484;
  int rieki = 1000;
  int rieki2 = -1;
  FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    Map? data = ref.watch(moneyProvider)as Map?;
    List<DataRow>? rows;
    print(data);
    if (data != null) {
      List<dynamic> dataList = data ['data'] as List<dynamic>;
      int sum=0;
      rows = dataList.map((d) {
        String title = d['optionTitle'];
        print(d['optionValue'].runtimeType);
        int nun= d['optionValue'];

        sum=(title == '券売機' || title == 'レジ' )?sum+nun:sum-nun;

        String value =nun.toString();


        return DataRow(
          cells: [
            DataCell(Align(alignment: Alignment.centerRight,child: Text(title == '券売機' || title == 'レジ' ? title : ''))),
            DataCell(Align(alignment: Alignment.centerRight,child: Text(title == '券売機' || title == 'レジ' ? '' : title))),
            DataCell(
              TextFormField(
                textAlign: TextAlign.right,
                decoration: InputDecoration(hintText: "Some Hint"),
                initialValue: value,
                onChanged: (String value) {
                },
                onFieldSubmitted: (val) {
                  print('onSubmited $val');
                },
              ),
            ),
            DataCell(
                Text((title == '券売機' || title == 'レジ' ? '+' : '-') + value)),
          ],
        );
      }).toList();
      rows.add(
          DataRow(
            cells: [
              DataCell(Text('')),
              DataCell(Text('')),
              DataCell(
                  Align(alignment: Alignment.centerRight,child: Text('合計'))
              ),
              DataCell(
                Text(sum.toString())
                ),
            ],
          )

      );
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('売上・仕入申請確認')),
      drawer: CustomDrawer(),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              choiceIndex == 0
                  ? Text(
                      '5月1日',
                      style: TextStyle(fontSize: 30.sp),
                    )
                  : Text('5月1日～5月31日', style: TextStyle(fontSize: 30.sp)),
              IconButton(
                icon: Icon(Icons.arrow_right, size: 30.sp),
                onPressed: () {},
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(child: Text('元に戻す'), onPressed: () {}),
              TextButton(
                  child: Text(
                    '変更する',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    setState(() {
                      _focusNode.unfocus();
                      rieki = 700;
                      rieki2 = -10;
                      sum = 1175;
                    });
                  }),
            ],
          ),
          data == null
              ? Text('この日のデータはありません。')
              : DataTable(
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
                    ))),
                    DataColumn(
                        label: Expanded(
                            child: Text(
                      '金額',
                      textAlign: TextAlign.right,
                    ))),
                    DataColumn(
                        label: Expanded(
                            child: Text(
                      '利益',
                      textAlign: TextAlign.right,
                    ))),
                  ],
                  rows: rows!,
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
