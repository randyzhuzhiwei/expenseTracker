/*
Author: Randy Zhu
Date: 09/07/2023
Project: Expense Tracker Demo
Description: Database services. DB connection to Cloud Firestore 
*/

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/expense.dart';

class DatabaseService {
  Future<String?> addExpense({
    required DateTime dateTime,
    required String tag,
    required String description,
    required double amount,
  }) async {
    try {
      CollectionReference expense =
          FirebaseFirestore.instance.collection('expense');
      // Call the user's CollectionReference to add a new user
      final data = {
        "Date": dateTime,
        'Tag': tag,
        'Description': description,
        'Amount': amount
      };

      await expense.add(data).then((documentSnapshot) =>
          print("Added Data with ID: ${documentSnapshot.id}"));
      return 'success';
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<Expense>> getAllExpense() async {
    List<Expense> myList = [];
    Expense exp;
    try {
      CollectionReference expense =
          FirebaseFirestore.instance.collection('expense');
      // Call the user's CollectionReference to add a new user
      await expense.orderBy('Date', descending: true).get().then(
        (querySnapshot) {
          print("Successfully completed");
          for (var docSnapshot in querySnapshot.docs) {
            exp = Expense(
                id: docSnapshot.id,
                dateTime: docSnapshot.get('Date'),
                description: docSnapshot.get('Description'),
                tag: docSnapshot.get('Tag'),
                amount: docSnapshot.get('Amount'));

            myList.add(exp);
          }
          return myList;
        },
        onError: (e) => print("Error completing: $e"),
      );
    } catch (e) {
      print(e.toString());
    }

    return myList;
  }
}
