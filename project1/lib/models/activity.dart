import 'package:flutter/material.dart';

class Activity {
  final String id;
  final String todo;
  final String detail;
  final DateTime date;
  final TimeOfDay time;

  Activity(
      {required this.id,
      required this.todo,
      required this.detail,
      required this.date,
      required this.time});
}
