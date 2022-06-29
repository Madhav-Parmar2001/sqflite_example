import 'package:flutter/material.dart';

import 'DatabaseHandler.dart';
import 'ViewUser.dart';

class UpdateUser extends StatefulWidget {

  var pid="";
  UpdateUser({this.pid});

  @override
  _UpdateUserState createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController user_name = TextEditingController();
  TextEditingController user_contact = TextEditingController();
  TextEditingController user_email = TextEditingController();
  TextEditingController user_password = TextEditingController();


  getsinglerecord() async
  {
    DatabaseHandler obj = new DatabaseHandler();
    var data = await obj.getsingleuser(widget.pid);
    user_name.text = data[0]["name"].toString();
    user_contact.text = data[0]["contact"].toString();
    user_email.text = data[0]["email"].toString();
    user_password.text = data[0]["password"].toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getsinglerecord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update User"),),
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
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Description",
                      hintText: "Enter Description",
                    )
                ),
                SizedBox(height: 15,),
                TextFormField(
                    controller: user_email,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "R Price",
                      hintText: "Enter R Price",
                    )
                ),
                SizedBox(height: 15,),
                TextFormField(
                    controller: user_password,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "S Price",
                      hintText: "Enter S Price",
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
                    var status = obj.UpdateUser(user_name1, user_contact1, user_email1, user_password1, widget.pid);
                    Navigator.of(context).pop(); // close uodate page
                    Navigator.of(context).pop(); // close view page
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>ViewUserScreen())
                    ); // get new data

                  },
                  color: Colors.blue,
                  child: Text("Update"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
