import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'item.dart';
import 'package:sqflite/sqflite.dart';

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  DatabaseHelper db = DatabaseHelper();
  Future itemListFuture;
  String testText = 'hello';

  //List<Item> itemList;
  int count = 0;

  //Item testItem = Item(item: 'testItem');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_getItemList();
    itemListFuture = getItemList();
  }

  _getItemList() {
    setState(() {
      itemListFuture = db.getItemList();
    });
  }

  Future<List<Item>> getItemList() async {
    await db.getItemList();
    return db.getItemList();
  }

  void refreshList() {
    setState(() {
      itemListFuture = getItemList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // if (itemList == null) {
    //   itemList = List<Item>();
    //   updateListView();
    // }

    Widget _buildItem(Item item) {
      return Card(
            child:
              ListTile(
                  title: Text(item.item == null ? '' : item.item),
                  trailing: Text(item.amount == null ? '0' : item.amount.toString()),

              ),

              //Divider(thickness: 2, height: 8, color: Colors.grey,),
      );
    }

    return Column(
      children: [SizedBox(
        height: 400,
        child: FutureBuilder(
            future: itemListFuture,
            builder: (context, snapshot) {
              // if (!snapshot.hasData) {
              //   return CircularProgressIndicator();
              // }
              if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  itemCount: snapshot.data == null ? 0 : snapshot.data.length,
                  //scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  // ignore: missing_return
                  itemBuilder: (context, index) {
                    if (snapshot.hasData) {
                        if (snapshot.data != null) {
                          //return Text('${snapshot.data.length} ${snapshot.data[index].item} $index');
                          return _buildItem(snapshot.data[index]);
                        }
                    }
                  });}
              else {
                return CircularProgressIndicator();
              }
                  },
                ),
      ),
        // Center(child: FlatButton(child: Text('click'), onPressed: (){
        //   setState(() {
        //     testText = 'asdfasdfa';
        //     refreshList();
        //   });
        // },),),
        // Center(child: Text(testText),)
      ]
    );
        }
  }

// void updateListView() {
//   final Future<Database> dbFuture = db.initialize();
//   dbFuture.then((database) {
//     Future<List<Item>> itemListFuture = db.getItemList();
//     itemListFuture.then((itemList) {
//       setState(() {
//         this.itemList = itemList;
//       });
//     });
//   });
// }


