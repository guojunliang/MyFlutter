import 'package:flutter/material.dart';

class SecondViewWidget extends StatelessWidget {
  SecondViewWidget(this._value);

  String _value;

  @override
  Widget build(BuildContext context) {
    String value = ModalRoute
        .of(context)
        .settings
        .arguments;
    print("value:$value");
    return Scaffold(appBar: AppBar(title: Text("SecondViewWidget"),),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Text(
          "second View", style: TextStyle(fontSize: 20, color: Colors.blue),),
        Text("$_value", style: TextStyle(fontSize: 20, color: Colors.blue),),
        RaisedButton(onPressed: _back(context), child: Text("返回上一页"),),
      ],),),);
  }

  _back(BuildContext context) {
    Navigator.pop(context, "hello");
  }
}