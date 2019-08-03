import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpTest extends StatefulWidget {
  SpTest();

  @override
  State<StatefulWidget> createState() {
    return SpTestState();
  }
}

class SpTestState extends State<SpTest> {
  TextEditingController _controller = TextEditingController();
  String _result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("sharedPreference测试"),),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(style: TextStyle(fontSize: 16, color: Colors.blue),
            keyboardType: TextInputType.number,
            controller: _controller,
            decoration: InputDecoration(
                labelText: "数量：", prefixIcon: Icon(Icons.account_box),
                hintText: "输入对应的值",
                errorText: "数据不正确"),
          ),
          MyRaisedWidget(_controller),
//        Text(_result),
        ],),),);
  }


}

class MyRaisedWidget extends StatelessWidget {
  TextEditingController _controller;

  MyRaisedWidget(this._controller);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      RaisedButton(onPressed: () {
        _saveValue();
//            Scaffold.of(context).showSnackBar(SnackBar(content: Text("保存成功")));
        print("保存成功");
        var snackBar = new SnackBar(content: Text("数据存储成功"));
        Scaffold.of(context).showSnackBar(snackBar);
      }, child: Text("保存"),),
      RaisedButton(onPressed: () {
        Future<String> future = _getValue();
        future.then((value) {
          print("读取：$value");
          var snackBar = SnackBar(
            content: Text("取值:$value"),
            duration: Duration(seconds: 3),);
          Scaffold.of(context).showSnackBar(snackBar);
        });
      }, child: Text("读取"),),
      RaisedButton(onPressed: () {
        _clearValue();
        Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("清除成功"), duration: Duration(seconds: 3),));
      }, child: Text("清除"),),
    ],);
  }

  _saveValue() async {
    String value = _controller.value.text;
    print("saveValue111:$value");
    if (value != null) {
      var sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("value", value);
      print("saveValue:$value");
    }
  }

Future<String>  _getValue() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var string = sharedPreferences.getString("value");
    print("getValue:$string");
    return string;
  }

  _clearValue() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("value");
  }
}

