import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'item.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  DatabaseHelper db = DatabaseHelper();

  Item item = Item();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
              Text('New Entry', style: TextStyle(fontSize: 30),),
              SizedBox(height: 20,),
              TextFormField(

                onChanged: (newValue) {
                  if (newValue.length > 0) {
                    item.amount = double.parse(newValue);
                  }
                },
                textAlign: TextAlign.center,
                keyboardType: TextInputType.numberWithOptions(decimal: true),

                decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),),
              SizedBox(height: 20,),
              TextFormField(

                onChanged: (newValue) {
                  if (newValue.length > 0) {
                    item.item = newValue;
                  }
                },
                //controller: TextEditingController(),
                textAlign: TextAlign.center,
                //keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                ),),

            ],
        ),
        bottomNavigationBar: Row(
          children: [
            Expanded(flex: 1, child: FlatButton(
              onPressed: (){
                return Navigator.pop(context);
                }
              ,
              child: Text('Cancel', style: TextStyle(fontSize: 20),),)),
            Expanded(flex: 1, child: FlatButton(
              onPressed: (){
                return _saveItem();
              },
              child: Text('Save',style: TextStyle(fontSize: 20),),)),
          ],
        ),
      ),
    );
  }

  _saveItem() {
    db.insertItem(item);
    Navigator.pop(context);
  }
}
