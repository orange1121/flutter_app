class Item {
  int id;
  String item;
  String category;
  double amount;
  String date;

  Item({this.item, this.category, this.amount, this.date});
  Item.id({this.id, this.item, this.category, this.amount, this.date});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['id'] = id;
    map['item'] = item;
    map['category'] = category;
    map['amount'] = amount;
    map['date'] = date;//transactionDate.toIso8601String();
    return map;
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item.id(
      id: map['id'], //this is the column name from the database
      item: map['item'],
      category: map['category'],
      amount: map['amount'],
      date: map['date'],//DateTime.parse(map['transactionDate']),
    );
  }
}

