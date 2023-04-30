import 'package:flutter/material.dart';

@immutable
class ShiftModel {
  final int status;
  final String remark;
  final DateTime time;

  const ShiftModel({
    required this.status,
    required this.remark,
    required this.time,
  });
}
