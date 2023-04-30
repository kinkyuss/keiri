import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keiri/model/shift.dart';

final shiftProvider =
    StateNotifierProvider<shiftViewModel, List<ShiftModel>>((ref) {
  return shiftViewModel(
    ref.read,
  );
});

class shiftViewModel extends StateNotifier<List<ShiftModel>> {
  final _read;

  shiftViewModel(this._read) : super([]);

  Map<String, Map> getShifts() {
    List<ShiftModel> shifts = [
      ShiftModel(status: 1, remark: '', time: DateTime.now()),
      ShiftModel(
        status: 1,
        remark: '',
        time: DateTime.now().add(Duration(days: 3)),
      ),
      ShiftModel(
          status: 2, remark: '', time: DateTime.now().add(Duration(hours: 130))),
      ShiftModel(
          status: 0, remark: '', time: DateTime.now().add(Duration(hours: 125)))
    ];
    Map<DateTime, List<DateTime>> re = {};
    Map<DateTime, List<ShiftModel>> shiftModel = {};
    for (var shift in shifts) {
      DateTime day = DateTime(shift.time.year, shift.time.month, shift.time.day);
      if (re.containsKey(day)) {
        List<DateTime> times = re[day]!;
        times.add(shift.time);
        re[day] = times;
        List<ShiftModel> models = shiftModel[day]!;
        models.add(shift);
        shiftModel[day] = models;
      } else {
        re[day] = [shift.time];
        shiftModel[day] = [shift];
      }
    }
    print(re);
    return {'model':shiftModel,'time':re};
  }
}

addChat(String content, bool me, int chatsID) async {
  //   int now = DateTime.now().millisecondsSinceEpoch;
  //   ChatModel model = ChatModel(id: now, content: content, me: me);
  //   await _read(chatModelRepositoryProvider).saveChats(model.toMapBoolToInt(),chatsID);
  //   state = [... state ,model ];
  // }
}
