/*
Author: Randy Zhu
Date: 09/07/2023
Project: Expense Tracker Demo
Description: Home UI. Connects to Firebase and retieve all expenses (descending order)
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import '../firebase_options.dart';
import '../models/expense.dart';
import '../services/database.dart';

// Screens for the different bottom navigation items
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  List<Expense> myList = [];
  bool listReady = false;

  @override
  void initState() {
    super.initState();
  }

  void getDBList() {
    DatabaseService().getAllExpense().then((value) {
      myList = value;
      if (this.mounted) {
        setState(() {
          listReady = true;
        });
      }
    });
  }

  Icon getIcon(String tag) {
    double size = 30.0;

    switch (tag) {
      case 'Shopping':
        return Icon(
          CupertinoIcons.shopping_cart,
          size: size,
        );
        break;
      case 'Food':
        return Icon(
          Icons.restaurant,
          size: size,
        );
        break;

      case 'Insurance':
        return Icon(
          Icons.safety_check,
          size: size,
        );
        break;

      case 'Utilities':
        return Icon(
          CupertinoIcons.archivebox_fill,
          size: size,
        );
        break;
      default:
        return Icon(
          CupertinoIcons.question,
          size: size,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    getDBList();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          toolbarHeight: 20,
        ),
        body: listReady
            ? ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: myList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          ListTile(
                            leading: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: 44,
                                  minHeight: 44,
                                  maxWidth: 64,
                                  maxHeight: 64,
                                ),
                                child: Column(
                                  children: [
                                    getIcon(myList[index].tag),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                    ),
                                    Text(myList[index].tag)
                                  ],
                                )),
                            title: Text("\$" + myList[index].amount.toString()),
                            subtitle: Text(
                              DateFormat('dd-MM-yyyy')
                                  .format(myList[index].dateTime.toDate()),
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              myList[index].description,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Text(myList[index].description),
                  );
                })
            : Text("Loading..."));
  }
}
