import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  Database db;

  Future<Database> create_db() async {
    if (db != null) {
      //database already created
      print("database already created");
      return db;
    } else {
      //database create
      Directory dir =
          await getApplicationDocumentsDirectory(); // Directory Syntex
      String path = join(dir.path, "shop_db");
      var db = await openDatabase(path,
          version: 1,
          onCreate: create_table); //Syntex and create database table
      print("database new created");
      return db;
    }
  }

  create_table(Database db, int version) async {
    db.execute(
        "create table products (pid integer primary key autoincrement,pname text,description text,rprice double,sprice double)");
    print("Table Created");

    db.execute(
        "create table user (pid integer primary key autoincrement,name text,contact integer,email text,password text)");
    print("Table Created");
  }

  // Product
  Future<int> addproduct(name, description, rprice, sprice) async {
    var db = await create_db();
    var id = await db.rawInsert(
        "insert into products (pname,description,rprice,sprice) values (?,?,?,?)",
        [name, description, rprice, sprice]);
    return id;
  }

  Future<List> viewproduct() async {
    var db = await create_db();
    var data = await db.rawQuery("select * from products");
    return data.toList();
  }

  Future<List> getsingleproduct(pid) async {
    var db = await create_db();
    var data = await db.rawQuery("select * from products where pid=?", [pid]);
    return data.toList();
  }

  Future<int> updateproduct(name, description, rprice, sprice, pid) async {
    var db = await create_db();
    var status = await db.rawUpdate(
        "update products set pname=?,description=?,rprice=?,sprice=? where pid=?",
        [name, description, rprice, sprice, pid]);
    return status;
  }

  Future<int> deleteProduct(id) async {
    var db = await create_db();
    //1 true 0 false
    var status = await db.rawDelete("delete from products where pid=?", [id]);
    return status;
  }

  // User
  Future<int> sqflite_AddUser(
      user_name1, user_contact1, user_email1, user_password1) async {
    var db = await create_db();

    Map<String, dynamic> data = {
      "name": user_name1,
      "contact": user_contact1,
      "email": user_email1,
      "password": user_password1,
    };
    var id = db.insert("user", data);
    return id;
  }

  Future<List> viewuser() async {
    var db = await create_db();
    var data = await db.rawQuery("select * from user");
    return data.toList();
  }

  Future<List> getsingleuser(pid) async {
    var db = await create_db();
    var data = await db.rawQuery("select * from user where pid=?", [pid]);
    return data.toList();
  }

  // Future<int> UpdateUser(
  //     user_name1, user_contact1, user_email1, user_password1, pid) async {
  //   var db = await create_db();
  //
  //   Map<String, dynamic> status = {
  //     "name": user_name1,
  //     "contact": user_contact1,
  //     "email": user_email1,
  //     "password": user_password1,
  //   };
  //   var status1 = db.update("user", status ,where: "pid = ?", whereArgs: [pid]);
  //   return status1;
  // }


  Future<int> UpdateUser(
      user_name1, user_contact1, user_email1, user_password1, pid) async {
    var db = await create_db();
    var status = await db.rawUpdate(
        "update user set name=?,contact=?,email=?,password=? where pid=?",
        [user_name1, user_contact1, user_email1, user_password1, pid]);
    return status;
  }

  // Future<int> deleteUser(id) async {
  //   var db = await create_db();
  //   //1 true 0 false
  //   var status = await db.delete("user", where: "pid=?", whereArgs: [id]);
  //   return status;
  // }

  Future<int> deleteUser(id) async {
    var db = await create_db();
    //1 true 0 false
    var status = await db.rawDelete("delete from user where pid=?", [id]);
    return status;
  }

}

