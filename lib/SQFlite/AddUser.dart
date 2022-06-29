import 'package:flutter/material.dart';
import 'DatabaseHandler.dart';

class sqflite_AddUser extends StatefulWidget {

  @override
  _sqflite_AddUserState createState() => _sqflite_AddUserState();
}

class _sqflite_AddUserState extends State<sqflite_AddUser> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController user_name = TextEditingController();
  TextEditingController user_contact = TextEditingController();
  TextEditingController user_email = TextEditingController();
  TextEditingController user_password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add User"),),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(5),
          color: Colors.blue.shade50,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 5,),
                TextFormField(
                    controller: user_name,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Name",
                      hintText: "Enter Name",
                    )
                ),
                SizedBox(height: 15,),
                TextFormField(
                    controller: user_contact,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Contact",
                      hintText: "Enter Contact",
                    )
                ),
                SizedBox(height: 15,),
                TextFormField(
                    controller: user_email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "email",
                      hintText: "Enter email",
                    )
                ),
                SizedBox(height: 15,),
                TextFormField(
                    controller: user_password,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Password",
                      hintText: "Enter Password",
                    )
                ),

                SizedBox(height: 15,),
                RaisedButton(
                  onPressed: () async{
                    var user_name1 = user_name.text.toString();
                    var user_contact1 = user_contact.text.toString();
                    var user_email1 = user_email.text.toString(); // Retail Price (Mrp)
                    var user_password1 = user_password.text.toString(); // Selling Price (Discount Price)

                    DatabaseHandler obj = new DatabaseHandler();
                    var id  = await obj.sqflite_AddUser(user_name1,user_contact1,user_email1,user_password1);
                    print("User Record Inserted at : "+id.toString());

                    user_name.text = "";
                    user_contact.text = "";
                    user_email.text = "";
                    user_password.text = "";

                  },
                  color: Colors.blue,
                  child: Text("Submit"),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
