import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final moneyRepositoryProvider =
    Provider<MoneyRepository>((ref) => MoneyRepository());

class MoneyRepository {
  final CollectionReference _requestsRef =
      FirebaseFirestore.instance.collection('money');

  Future<void> addMoney(List<Map<String, dynamic>> money) async {
    DateTime now = DateTime.now();
    int nowInt = DateTime(now.year, now.month, now.day).microsecondsSinceEpoch;
    await _requestsRef.doc(nowInt.toString()).set({'data':money});
  }

  Future<Object?> getDay(int id) async {
    var snapshot = await _requestsRef.doc(id.toString()).get();
    print(snapshot.data());
    return snapshot.data();
  }
}
