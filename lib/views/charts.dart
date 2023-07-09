/*
Author: Randy Zhu
Date: 09/07/2023
Project: Expense Tracker Demo
Description: Charts UI Widget. Sum up respective tag expenses and display in pie chart
*/

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import '../firebase_options.dart';
import '../models/expense.dart';
import '../services/database.dart';

// Screens for the different bottom navigation items
class Charts extends StatefulWidget {
  const Charts({Key? key}) : super(key: key);
  @override
  State<Charts> createState() => _Charts();
}

class _Charts extends State<Charts> {
  List<Expense> myList = [];
  List<double> totalTag = [0.0, 0.0, 0.0, 0.0, 0.0];
  List<String> Tags = [
    'Food',
    'Transport',
    'Shopping',
    'Insurance',
    'Utilities',
  ];

  List<Color> colorList = [
    Colors.amber,
    Colors.blue,
    Colors.orange,
    Colors.teal,
    Colors.blueGrey
  ];

  double totalSpending = 0.0;

  bool listReady = false;

  List<ChartData> chartData = [];

  @override
  void initState() {
    getDBList();
    super.initState();
  }

  void getDBList() {
    DatabaseService().getAllExpense().then((value) {
      myList = value;
      for (var exp in myList) {
        switch (exp.tag) {
          case "Food":
            totalTag[0] += exp.amount;
            break;
          case "Transport":
            totalTag[1] += exp.amount;
            break;
          case "Shopping":
            totalTag[2] += exp.amount;
            break;
          case "Insurance":
            totalTag[3] += exp.amount;
            break;
          case "Utilities":
            totalTag[4] += exp.amount;
            break;
        }
        totalSpending += exp.amount;
      }
      Tags.asMap().forEach((index, value) {
        ChartData cd = ChartData(value, totalTag[index], colorList[index]);
        chartData.add(cd);
      });

      if (this.mounted) {
        setState(() {
          listReady = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        toolbarHeight: 20,
      ),
      body: listReady
          ? Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                            height: 70,
                            child: Expanded(
                                child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: <Widget>[
                                  SizedBox(
                                    width: 130,
                                    height: 30,
                                    child: Card(
                                      margin: EdgeInsets.all(0),
                                      color: colorList[0],
                                      shadowColor: Colors.blueGrey,
                                      elevation: 10,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                          ),
                                          Icon(Icons.restaurant, size: 20),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                          ),
                                          Text(
                                            "\$" +
                                                totalTag[0].toStringAsFixed(2),
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                  ),
                                  SizedBox(
                                    width: 130,
                                    height: 30,
                                    child: Card(
                                      margin: EdgeInsets.all(0),
                                      color: colorList[1],
                                      shadowColor: Colors.blueGrey,
                                      elevation: 10,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                          ),
                                          Icon(Icons.car_crash_rounded,
                                              size: 20),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                          ),
                                          Text(
                                            "\$" +
                                                totalTag[1].toStringAsFixed(2),
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                  ),
                                  SizedBox(
                                    width: 130,
                                    height: 30,
                                    child: Card(
                                      margin: EdgeInsets.all(0),
                                      color: colorList[2],
                                      shadowColor: Colors.blueGrey,
                                      elevation: 10,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                          ),
                                          Icon(CupertinoIcons.shopping_cart,
                                              size: 20),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                          ),
                                          Text(
                                            "\$" +
                                                totalTag[2].toStringAsFixed(2),
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                  ),
                                  SizedBox(
                                    width: 130,
                                    height: 30,
                                    child: Card(
                                      margin: EdgeInsets.all(0),
                                      color: colorList[3],
                                      shadowColor: Colors.blueGrey,
                                      elevation: 10,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                          ),
                                          Icon(Icons.safety_check, size: 20),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                          ),
                                          Text(
                                            "\$" +
                                                totalTag[3].toStringAsFixed(2),
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                  ),
                                  SizedBox(
                                    width: 130,
                                    height: 30,
                                    child: Card(
                                      margin: EdgeInsets.all(0),
                                      color: colorList[4],
                                      shadowColor: Colors.blueGrey,
                                      elevation: 10,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                          ),
                                          Icon(CupertinoIcons.archivebox_fill,
                                              size: 20),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                          ),
                                          Text(
                                            "\$" +
                                                totalTag[4].toStringAsFixed(2),
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                  ),
                                ]))),
                        const SizedBox(height: 46),
                        Container(
                            child: Text(
                          "Total Spending",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                          ),
                        )),
                        const SizedBox(height: 16),
                        Container(
                            child: Text(
                          "\$" + totalSpending.toStringAsFixed(2),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                          ),
                        )),
                        const SizedBox(height: 36),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .35,
                            child: SfCircularChart(series: <CircularSeries>[
                              // Render pie chart
                              PieSeries<ChartData, String>(
                                  dataSource: chartData,
                                  pointColorMapper: (ChartData data, _) =>
                                      data.color,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y)
                            ])),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Text("No Data"),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
