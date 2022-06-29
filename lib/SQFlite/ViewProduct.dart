import 'package:flutter/material.dart';
import 'DatabaseHandler.dart';
import 'UpdateProduct.dart';

class ViewProductScreen extends StatefulWidget {

  @override
  _ViewProductScreenState createState() => _ViewProductScreenState();
}

class _ViewProductScreenState extends State<ViewProductScreen> {

  Future<List> alldata;

  Future<List> getalldata() async
  {
    DatabaseHandler obj = DatabaseHandler();
    var data  = obj.viewproduct();
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
        title: Text("View Products"),
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
                        title: Text(snapshots.data[index]["pname"].toString()),
                        subtitle: Text(snapshots.data[index]["description"].toString()),
                        trailing: Text(snapshots.data[index]["sprice"].toString()),
                        onTap: (){
                          AlertDialog alert = AlertDialog(
                            title: Text("Are You Sure Delete"),
                            actions: [
                              RaisedButton(
                                child: Text("Edit"),
                                onPressed: (){
                                  var id = snapshots.data[index]["pid"].toString();
                                  print("id"+id);
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context)=>UpdateProduct(pid: id,))
                                  );
                                },
                              ),

                              RaisedButton(
                                child: Text("Delete"),
                                onPressed: () async{
                                  var id = snapshots.data[index]["pid"].toString();
                                  DatabaseHandler obj = DatabaseHandler();
                                  int status =await obj.deleteProduct(id);
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
