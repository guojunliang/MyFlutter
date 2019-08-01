import 'package:flutter/material.dart';

class SharedPreferenceTest extends StatefulWidget {
  var _data;

  SharedPreferenceTest(this._data);

  @override
  State<StatefulWidget> createState() {
//    return SharedPreferenceState(_data);
    return TestState();
  }

}

class TestState extends State<SharedPreferenceTest> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(appBar: AppBar(centerTitle: true,),
      body: Center(child: Text("ceshiyixiaxia"),),);
  }
}

class SharedPreferenceState extends State<SharedPreferenceTest> {

  SharedPreferenceState(this._result);

  String _result = "unknow";

  _add() {

  }

  _delete() {

  }

  _update() {

  }

  _query() {

  }

  _pop() {
    Navigator.pop(context, "hello");
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Center(
      child: Column(children: <Widget>[
        Padding(padding: EdgeInsets.all(10),
          child: Text("sharedPreference测试", style: TextStyle(fontSize: 20),),),
        RaisedButton(onPressed: _add, child: Text("保存"),),
        RaisedButton(onPressed: _query, child: Text("查询"),),
        RaisedButton(onPressed: _update(), child: Text("修改"),),
        RaisedButton(onPressed: _delete, child: Text("删除"),),
        RaisedButton(onPressed: _pop, child: Text("返回"),),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            _result, style: TextStyle(fontSize: 16, color: Colors.blue),),)
      ],),),);
  }
}