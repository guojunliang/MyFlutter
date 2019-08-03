import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

String tableName = "user";
String columnId = "id";
String columdName = "name";
String columnAge = "age";

class User {
  int _id;
  String _name;
  int _age;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columdName: _name,
      columnAge: _age,
    };
    if (_id != null) {
      map[columnId] = _id;
    }
    return map;
  }

  User();

  User.fromMap(Map<String, dynamic> map){
    _id = map[columnId];
    _name = map[columdName];
    _age = map[columnAge];
  }

  @override
  String toString() {
    return 'User{_id: $_id, _name: $_name, _age: $_age}';
  }

}

class SqfLiteHelper {
  Database _db;
  final _lock = Lock();

  Future openDataBase(String path) async {
    String sqlCreate = "create table $tableName ($columnId integer primary key autoincrement,"
        " $columdName text not null, $columnAge integer not null)";
    if (_db == null) {
      await _lock.synchronized(() async {
        if (_db == null) {
          _db = await openDatabase(path, version: 1,
              onCreate: (Database db, int version) async {
                await db.execute(sqlCreate);
              },
              onUpgrade: (Database db, int oldVersion, int newVersion) {

              });
        }
      });
    }
  }

  Future<User> insert(User user) async {
    var id = await _db.insert(tableName, user.toMap());
    user._id = id;
    return user;
  }

  Future<List<User>> queryUser(int id) async {
    var list = await _db.query(
        tableName, where: "$columnId = ?", whereArgs: [id]);
    var users = <User>[];
    if (list != null && list.length > 0) {
      list.forEach((map) {
        users.add(User.fromMap(map));
      });
      return users;
    }
  }

  Future<int> deleteUser(User user) async {
    var i = await _db.delete(
        tableName, where: "$columnId = ?", whereArgs: [user._id]);
    return i;
  }

  Future<int> updateUser(User user) async {
    var i = await _db.update(
        tableName, user.toMap(), where: '$columnId = ?', whereArgs: [user._id]);
    return i;
  }

}
