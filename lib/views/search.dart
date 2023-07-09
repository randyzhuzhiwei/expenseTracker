/*
Author: Randy Zhu
Date: 09/07/2023
Project: Expense Tracker Demo
Description: Search Stateful Widget. Search downloaded list based on user selection
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
class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);
  @override
  State<Search> createState() => _Search();
}

class _Search extends State<Search> {
  List<Expense> myList = [];

  List<Expense> myList2 = [];
  bool listReady = false;

  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    getDBList();
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

  void clearSearch() {
    myList = List.from(myList2);
    if (this.mounted) {
      setState(() {
        listReady = true;
      });
    }
  }

  void quickSearch(String option) {
    //Backup list
    myList2 = List.from(myList);
    List<Expense> searchList = [];
    switch (option) {
      case "today":
        var inputFormat = DateFormat('dd/MM/yyyy');
        for (var exp in myList) {
          if (DateFormat('dd-MM-yyyy').format(exp.dateTime.toDate()) ==
              DateFormat('dd-MM-yyyy').format(DateTime.now())) {
            searchList.add(exp);
          }
        }
        break;
      case "food":
        for (var exp in myList) {
          if (exp.tag == "Food") {
            searchList.add(exp);
          }
        }
        break;
      case "Shopping":
        for (var exp in myList) {
          if (exp.tag == "Shopping") {
            searchList.add(exp);
          }
        }
        break;
      case "Transport":
        for (var exp in myList) {
          if (exp.tag == "Transport") {
            searchList.add(exp);
          }
        }
        break;
    }

    if (this.mounted) {
      setState(() {
        myList = List.from(searchList);
        listReady = true;
      });
    }
  }

  void searchByDesc(String desc) {
    //Backup list
    myList2 = List.from(myList);
    List<Expense> searchList = [];
    for (var exp in myList) {
      if (exp.description.toLowerCase().contains(desc.toLowerCase())) {
        searchList.add(exp);
      }
    }
    if (this.mounted) {
      setState(() {
        myList = List.from(searchList);
        listReady = true;
      });
    }
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          toolbarHeight: 20,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
            ),
            Container(
                height: 40,
                child: Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      //your widget items here
                      ElevatedButton(
                        onPressed: () {
                          quickSearch("today");
                        },
                        child: Text('Today'),
                        style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          quickSearch("7");
                        },
                        child: Text('Last 7 Days'),
                        style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          quickSearch("food");
                        },
                        child: Text('Food'),
                        style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          quickSearch("Shopping");
                        },
                        child: Text('Shopping'),
                        style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          quickSearch("Transport");
                        },
                        child: Text('Transport'),
                        style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          quickSearch("Utilities");
                        },
                        child: Text('Utilities'),
                        style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                      )
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(5.0),
            ),
            Container(
              child: TextFormField(
                controller: descriptionController,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  hintText: 'Description',
                  hintStyle: const TextStyle(fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Container(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                  onPressed: () {
                    descriptionController.text = "";
                    clearSearch();
                  },
                  child: Text('Clear')),
              Padding(
                padding: const EdgeInsets.all(5.0),
              ),
              ElevatedButton(
                  onPressed: () {
                    searchByDesc(descriptionController.text);
                  },
                  child: Text('Search')),
            ])),
            Expanded(
                child: listReady
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
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                            ),
                                            Text(myList[index].tag)
                                          ],
                                        )),
                                    title: Text(
                                        "\$" + myList[index].amount.toString()),
                                    subtitle: Text(
                                      DateFormat('dd-MM-yyyy').format(
                                          myList[index].dateTime.toDate()),
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
                          );
                        })
                    : Text("No Data")),
          ],
        ));
  }
}
