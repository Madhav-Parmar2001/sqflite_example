import 'package:flutter/material.dart';
import 'DatabaseHandler.dart';
import 'UpdateUser.dart';


class ViewUserScreen extends StatefulWidget {

  @override
  _ViewUserScreenState createState() => _ViewUserScreenState();
}

class _ViewUserScreenState extends State<ViewUserScreen> {

  Future<List> alldata;

  Future<List> getalldata() async
  {
    DatabaseHandler obj = DatabaseHandler();
    var data  = obj.viewuser();
    return data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      alldata = getalldata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View User"),
      ),
      body: FutureBuilder(
        future: alldata,
        builder: (context,snapshots)
        {
          if(snapshots.hasData)
          {
            if(snapshots.data.length<=0)
            {
              return Center(child: Text("No Data"));
            }
            else
            {
              return ListView.builder(
                itemCount: snapshots.data.length,
                itemBuilder: (context,index)
                {
                  return ListTile(
                    leading: Text(snapshots.data[index]["pid"].toString()),
                    title: Text(snapshots.data[index]["name"].toString()),
                    subtitle: Text(snapshots.data[index]["email"].toString()),
                    trailing: Text(snapshots.data[index]["password"].toString()),
                    onTap: (){
                      AlertDialog alert = AlertDialog(
                        title: Text("Select Option"),
                        actions: [
                          RaisedButton(
                            child: Text("Edit"),
                            onPressed: (){
                              var id = snapshots.data[index]["pid"].toString();
                              print("pid edit :"+id);
                              Navigator.of(context).pop();
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context)=>UpdateUser(pid: id,))
                              );
                            },
                          ),

                          RaisedButton(
                            child: Text("Delete"),
                            onPressed: () async{
                              var id = snapshots.data[index]["pid"].toString();
                              print("pid delete :"+id);
                              DatabaseHandler obj = DatabaseHandler();
                              int status =await obj.deleteUser(id);
                              print("Status : "+status.toString());
                              Navigator.of(context).pop();
                              setState(() {
                                alldata = getalldata();
                              });
                            },
                          ),

                          RaisedButton(
                            child: Text("Cancel"),
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                      showDialog(context: context, builder: (context){
                        return alert;
                      });
                    },
                  );
                },
              );
            }
          }
          else
          {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
