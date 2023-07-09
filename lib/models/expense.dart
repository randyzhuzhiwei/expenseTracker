/*
Author: Randy Zhu
Date: 09/07/2023
Project: Expense Tracker Demo
Description: Model of the main object -> expense. Cloud Firestore model
*/

import 'package:cloud_firestore/cloud_firestore.dart';

class Expense {
  String id;
  Timestamp dateTime;
  String tag;
  String description;
  double amount;

  Expense({
    required this.id,
    required this.dateTime,
    required this.tag,
    required this.description,
    required this.amount,
  });
}
