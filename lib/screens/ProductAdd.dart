import 'package:flutter/material.dart';
import 'package:sqflite_app/data/SqlDatabase.dart';
import 'package:sqflite_app/models/Product.dart';

class ProductAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductAddState();
  }
}

class _ProductAddState extends State {
  var db = SqlDatabase();

  var _productNameController = TextEditingController();
  var _productDescriptionController = TextEditingController();
  var _productUnitPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            buildProductName(),
            buildProductDescription(),
            buildProductUnitPrice(),
            buildProductSave(),
          ],
        ),
      ),
    );
  }

  TextField buildProductName() {
    return TextField(
      controller: _productNameController,
      decoration: InputDecoration(
        labelText: "Name",
      ),
    );
  }

  TextField buildProductDescription() {
    return TextField(
      controller: _productDescriptionController,
      decoration: InputDecoration(
        labelText: "Description",
      ),
    );
  }

  TextField buildProductUnitPrice() {
    return TextField(
      controller: _productUnitPriceController,
      decoration: InputDecoration(
        labelText: "Price",
      ),
    );
  }

  FlatButton buildProductSave() {
    return FlatButton(
      onPressed: () {
        addProduct();
      },
      child: Text("Save"),
    );
  }

  addProduct() async {
    await db.insert(Product(
      name: _productNameController.text,
      description: _productDescriptionController.text,
      unitPrice: int.parse(_productUnitPriceController.text),
    ));

    Navigator.pop(context, true);
  }
}
