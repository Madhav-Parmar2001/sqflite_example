import 'package:flutter/material.dart';
import 'AddProduct.dart';
import 'AddUser.dart';
import 'ViewProduct.dart';
import 'ViewUser.dart';

class HomePage extends StatefulWidget
{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("SQFlite Home"),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.arrow_forward_ios),
            title: Text("Add Product"),
            onTap: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddProduct(),)
              );
            },
          ),
          Divider(),

          ListTile(
            leading: Icon(Icons.arrow_forward_ios),
            title: Text("View Product"),
            onTap: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ViewProductScreen())
              );
            },
          ),
          Divider(),

          ListTile(
            leading: Icon(Icons.arrow_forward_ios),
            title: Text("Add User"),
            onTap: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => sqflite_AddUser(),)
              );
            },
          ),
          Divider(),

          ListTile(
            leading: Icon(Icons.arrow_forward_ios),
            title: Text("View User"),
            onTap: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ViewUserScreen())
              );
            },
          ),
          Divider(),


        ],
      ),
    );
  }
}
