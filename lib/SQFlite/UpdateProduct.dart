import 'package:flutter/material.dart';
import 'DatabaseHandler.dart';
import 'ViewProduct.dart';

class UpdateProduct extends StatefulWidget {

  var pid="";
  UpdateProduct({this.pid});

  @override
  _UpdateProductState createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController product_name = TextEditingController();
  TextEditingController product_descrption = TextEditingController();
  TextEditingController product_rprice = TextEditingController();
  TextEditingController product_sprice = TextEditingController();

  getsinglerecord() async
  {
    DatabaseHandler obj = new DatabaseHandler();
    var data = await obj.getsingleproduct(widget.pid);

    product_name.text = data[0]["pname"].toString();
    product_descrption.text = data[0]["description"].toString();
    product_rprice.text = data[0]["rprice"].toString();
    product_sprice.text = data[0]["sprice"].toString();
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
      appBar: AppBar(title: Text("Update Product"),),
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
                    controller: product_name,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Name",
                      hintText: "Enter Name",
                    )
                ),
                SizedBox(height: 15,),
                TextFormField(
                    controller: product_descrption,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Description",
                      hintText: "Enter Description",
                    )
                ),
                SizedBox(height: 15,),
                TextFormField(
                    controller: product_rprice,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "R Price",
                      hintText: "Enter R Price",
                    )
                ),
                SizedBox(height: 15,),
                TextFormField(
                    controller: product_sprice,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "S Price",
                      hintText: "Enter S Price",
                    )
                ),
                SizedBox(height: 15,),
                RaisedButton(
                  onPressed: () async{
                    var name = product_name.text.toString();
                    var description = product_descrption.text.toString();
                    var rprice = product_rprice.text.toString(); // Retail Price (Mrp)
                    var sprice = product_sprice.text.toString(); // Selling Price (Discount Price)


                    DatabaseHandler obj = new DatabaseHandler();
                    var status = obj.updateproduct(name,description,rprice,sprice,widget.pid);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context)=>ViewProductScreen())
                    );

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
