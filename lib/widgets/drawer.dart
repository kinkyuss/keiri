import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keiri/main.dart';
import 'package:keiri/screen/auth/login_view.dart';
import 'package:keiri/screen/employee/shift_request.dart';
import 'package:keiri/screen/employee/shift_view.dart';
import 'package:keiri/screen/manage/money_manage_decision.dart';
import 'package:keiri/screen/manage/shift_manage.dart';
import 'package:keiri/screen/manage/staff_kintai.dart';
import 'package:keiri/screen/store/in_out_rest.dart';
import 'package:keiri/screen/store/money_manage.dart';
import 'package:keiri/view_moedl/auth_view_model.dart';
import 'package:keiri/view_moedl/money_view_model.dart';
import 'package:keiri/view_moedl/shit_view_model.dart';

class CustomDrawer extends ConsumerWidget {
  CustomDrawer({Key? key}) : super(key: key);
  String? photoURLSend;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authViewModelProvider);
    final colorIndex = ref.watch(drawerIndexProvider);

    return Drawer(
      width: 250.w,
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              user?.displayName ?? '名称未設定',
              style: TextStyle(color: Colors.white, fontSize: 15.sp),
            ),
            accountEmail: Text(
              user?.email ?? 'メールアドレス未設定',
              style: TextStyle(color: Colors.white, fontSize: 10.sp),
            ),
            otherAccountsPictures: [],
          ),
          SizedBox(
            height: 420.h,
            child: ListView(children: [
              drawerTile(0, 'シフト確認', ref, colorIndex, context),
              drawerTile(1, 'シフト申請', ref, colorIndex, context),
              user!.uid == 'q8FdKn3hVaTYkud5SgNF9uyHLrX2' ||
                      user.uid == 'yXfnZ9fbVnNRumVDdSoBQhRDtDs2'
                  ? drawerTile(2, '出勤退勤休息', ref, colorIndex, context)
                  : SizedBox(),
              user.uid == 'q8FdKn3hVaTYkud5SgNF9uyHLrX2' ||
                      user.uid == 'yXfnZ9fbVnNRumVDdSoBQhRDtDs2'
                  ? drawerTile(3, '売上仕入申請', ref, colorIndex, context)
                  : SizedBox(),
              user.uid == 'yXfnZ9fbVnNRumVDdSoBQhRDtDs2'
                  ? drawerTile(4, 'シフト申請状況', ref, colorIndex, context)
                  : SizedBox(),
              user.uid == 'yXfnZ9fbVnNRumVDdSoBQhRDtDs2'
                  ? drawerTile(5, '売上仕入申請確認', ref, colorIndex, context)
                  : SizedBox(),

              user.uid == 'yXfnZ9fbVnNRumVDdSoBQhRDtDs2'
                  ? drawerTile(6, 'スタッフ出勤状況', ref, colorIndex, context)
                  : SizedBox(),
            ]),
          ),
          SizedBox(height: 5.h),
          TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              minimumSize: MaterialStateProperty.all(Size.zero),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {},
            child: Text('プライバシーポリシー',
                style: TextStyle(color: Colors.grey, fontSize: 15.sp)),
          ),
          TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                minimumSize: MaterialStateProperty.all(Size.zero),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text('ログアウト',
                  style: TextStyle(color: Colors.grey, fontSize: 15.sp)),
              onPressed: () async {
                await ref.read(authViewModelProvider.notifier).signOut();
                Navigator.pushAndRemoveUntil<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => LoginView(),
                  ),
                      (route) => false,//if you want to disable back feature set to false
                );
              }),
        ],
      ),
    );
  }

  SizedBox drawerTile(int index, String title, WidgetRef ref, int colorIndex,
      BuildContext context) {
    return SizedBox(
      height: 65.h,
      child: InkWell(
        onTap: ()async {

          late var seni;
          ref.read(drawerIndexProvider.notifier).state = index;
          switch (title) {
            case 'シフト確認':
              DateTime now = DateTime.now();

// 現在の曜日を取得
              int weekday = now.weekday;

// 直近の日曜日を計算
              DateTime lastSunday = now.subtract(Duration(days: weekday)).subtract(Duration(days: -7));
             await ref.read(shiftProvider.notifier).shiftView(lastSunday.year,lastSunday.month,lastSunday.day);
              seni = const ShiftView();
              break;
            case 'シフト申請':
              seni =const  ShiftRequest();
              break;
            case '出勤退勤休息':
              seni = const InOutRest();
              break;
            case '売上仕入申請':
              seni = const MoneyManage();
              break;
            case 'シフト申請状況':
              DateTime now =DateTime.now();
             await  ref.read(shiftProvider.notifier).shiftManage(now.year,now.month);
              seni = const ShiftManage();
              break;
            case '売上仕入申請確認':
              DateTime now = DateTime.now();
              DateTime zeroed = DateTime(now.year, now.month, now.day);
              ref.read(moneyProvider.notifier).getDay(zeroed);
              seni = const MoneyManageDecision();
              break;
            case 'スタッフ出勤状況':
              seni=const StaffKintai();
          }
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => seni));
        },
        child: Container(
          width: double.infinity,
          color: index == colorIndex ? Colors.red : Colors.transparent,
          alignment: Alignment.center,
          child: Text(title, style: TextStyle(fontSize: 30.sp)),
        ),
      ),
    );
  }
}
