import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/add_item.dart';
import 'item_list.dart';
import 'database_helper.dart';
import 'item.dart';
import 'add_item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        minimum: EdgeInsets.only(top: 30.0),
        child: MyHome(),
      ),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  DatabaseHelper db = DatabaseHelper();
  ItemList listPage = ItemList();

  //Item testItem = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        iconTheme: IconThemeData(color: Colors.blueAccent[700]),
        shape: RoundedRectangleBorder(
            //side: BorderSide(style: BorderStyle., color: Colors.blueAccent[200]),
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(20.0), bottom: Radius.circular(20.0))),
        toolbarHeight: 50.0,
        leading: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {}, //TODO: open up search
        ),
        leadingWidth: 100.0,
        title: FlatButton(
          onPressed: (){},
          child: Text(
            //Todo: replace with GestureDetector or InkWell to route to search
            'Search here',
            style: TextStyle(color: Colors.black),
          ),
        ),
        centerTitle: true,
        elevation: 5,
        shadowColor: Colors.grey,
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {}, //TODO: open up menu
            padding: EdgeInsetsDirectional.only(end: 20.0),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Text(
                              'Income: 0.00',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                  Expanded(
                      flex: 1,

                            child: Text(
                              'Expenses: 0.00',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                ],
              ),
            ),
            //Expanded(flex: 8, child: ItemList())
            Expanded(flex: 8, child: listPage)
          ],
        ),
      ),
      bottomNavigationBar: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              flex: 1,
              child: FlatButton(onPressed: () {}, child: Text('Statistics'))),
          // Expanded(
          //     flex: 1,
          //     child: FlatButton(onPressed: () {}, child: Text('Expenses')))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white54,
        elevation: 1,
        //foregroundColor: Colors.white70,
        child: Icon(Icons.add),
        onPressed: () {
          return Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddItem();
          }));
        },
      ),
    );
  }
}
