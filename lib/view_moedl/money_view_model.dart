import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../repository/money_repository.dart';


final moneyProvider =
StateNotifierProvider<moneyViewModel, Object?>((ref) {
  return moneyViewModel(
    ref.read,
  );
});

class moneyViewModel extends StateNotifier<Object?> {
  final _read;

  moneyViewModel(this._read) : super([]);


  dynamic getValue(Map<String, dynamic> map) {
    if (!map.containsKey('optionTitle') ||
        !map.containsKey('optionValue') ||
        map['optionTitle'] == '') {
      return map['n'];
    }
  }

  bool isAllNull(List list) {
    return list.every((element) => element == null);
  }

  Future<List> addRequest(List<Map<String, dynamic>> money) async {
    List<dynamic> results = money.map((map) => getValue(map)).toList();
    print(results);
    money.sort((a, b) => a['n'].compareTo(b['n']));
    print(money);
    if (isAllNull(results)) {
      Map<String, int> result = {};

      for (Map<String, dynamic> entry in money) {
        String title = entry['optionTitle'];
        int value = entry['optionValue'];

        result.putIfAbsent(title, () => value);
      }
      print(result);
      await _read(moneyRepositoryProvider).addMoney(money);
    }

    return results;
  }

  Future<void> getDay(DateTime now) async {
    state= await _read(moneyRepositoryProvider)
        .getDay(now.microsecondsSinceEpoch);
  }
}

