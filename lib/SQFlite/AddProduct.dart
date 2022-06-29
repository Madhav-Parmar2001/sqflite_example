import 'package:flutter/material.dart';
import 'DatabaseHandler.dart';

class AddProduct extends StatefulWidget
{
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct>
{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController product_name = TextEditingController();
  TextEditingController product_descrption = TextEditingController();
  TextEditingController product_rprice = TextEditingController();
  TextEditingController product_sprice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Product"),),
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
                    var id  = await obj.addproduct(name,description,rprice,sprice);
                    print("Product Record Inserted at : "+id.toString());
                    product_name.text = "";
                    product_descrption.text = "";
                    product_rprice.text = "";
                    product_sprice.text = "";

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
