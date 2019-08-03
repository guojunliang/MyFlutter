import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_flutter/SqfLiteHelper.dart';
import 'package:path_provider/path_provider.dart';
TextEditingController _controller= TextEditingController();
class SqfliteWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SqflistState();
  }

}

class SqflistState extends State<SqfliteWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("sqfLite测试"),),
      body: Center(child: MyWidget(),),);
  }
}

class MyWidget extends StatelessWidget {
  SqfLiteHelper _helper;


  @override
  Widget build(BuildContext context) {
    _helper = SqfLiteHelper();
    // ignore: expected_token
    var path = _getDataBasePath();
    path.then((value) {
      print("db path:$value");
      String dbpath = (value + "/user.db");
      _helper.openDataBase(dbpath);
    });
//    path=join(path,"user.db");

    return Column(
      mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      TextField(controller: _controller, keyboardType: TextInputType.number),
      RaisedButton(onPressed: () {
        _saveUser(context);
      }, child: Text("保存用户信息"),),
      RaisedButton(onPressed: () {
        _updateUser(context);
      }, child: Text("修改用户信息"),),
      RaisedButton(onPressed: () {
        _deleteUser(context);
      }, child: Text("删除用户信息"),),
      RaisedButton(onPressed: () {
        _queryUser(context);
      }, child: Text("查询用户信息"),),
    ],);
  }

  _saveUser(BuildContext context) async {
    User user = User.fromMap(<String, dynamic>{
      "name": "zhangsan",
      "age": 20,
    });
    if (_helper != null) {
      User user2 = await _helper.insert(user);
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("${user2.toString()}")));
    }
  }

  _updateUser(BuildContext context) async {
    var text = _controller.value.text;
    if (text != null) {
      User user = User.fromMap(<String, dynamic>{
        "id": int.parse(text),
        "name": "hehe$text",
        "age": 13
      });
      var i = await _helper.updateUser(user);
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("i:$i")));
    }
  }

  _queryUser(BuildContext context) async {
    var text = _controller.value.text;
    if (text != null) {
      User user = User.fromMap(<String, dynamic>{
        "id": int.parse(text),
        "name": "hehe$text",
        "age": 13
      });
      var user1 = await _helper.queryUser(int.parse(text));
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("user:${user1.toString()}")));
    }
  }

  _deleteUser(BuildContext context) async {
    var text = _controller.value.text;
    if (text != null) {
      User user = User.fromMap(<String, dynamic>{
        "id": int.parse(text),
        "name": "hehe$text",
        "age": 13
      });
      var i = await _helper.deleteUser(user);
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("i:$i")));
    }
  }

  Future<String> _getDataBasePath() async {
    Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}