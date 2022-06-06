import 'package:flutter/material.dart';
import 'package:sqflitetestingapp/dbhelper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbHelper = Databasehelper.instance;

  void insertData() async {
    Map<String, dynamic> row = {
      Databasehelper.columnname: "Nilu",
      Databasehelper.columnage: 16,
    };
    final id = await dbHelper.insert(row);
    print(id);
  }

  void queryall() async {
    var allrows = await dbHelper.queryall();
    allrows.forEach((row) {
      print(row);
    });
  }

  void queryspecific() async {
    var allrows = await dbHelper.queryspecific(18);
    print(allrows);
  }

  void update() async {
    var row = await dbHelper.update(4);
    print(row);
  }

  void delete() async {
    var id = await dbHelper.delete(7);
    print(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sqflite Database Example"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: insertData,
              child: const Text("Insert"),
              style: ElevatedButton.styleFrom(primary: Colors.pink),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              onPressed: queryall,
              child: const Text("Query"),
              style: ElevatedButton.styleFrom(primary: Colors.blueAccent),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              onPressed: queryspecific,
              child: const Text("Query Specific"),
              style: ElevatedButton.styleFrom(primary: Colors.green),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              onPressed: update,
              child: const Text("Update"),
              style: ElevatedButton.styleFrom(primary: Colors.green),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              onPressed: delete,
              child: const Text("Delete"),
              style: ElevatedButton.styleFrom(primary: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
