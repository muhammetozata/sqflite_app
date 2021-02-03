import 'package:flutter/material.dart';
import 'package:sqflite_app/data/SqlDatabase.dart';
import 'package:sqflite_app/models/Product.dart';

enum Options { delete, update }

class ProductDetail extends StatefulWidget {
  Product product;

  ProductDetail(this.product);

  @override
  State<StatefulWidget> createState() {
    return _ProductDetailState();
  }
}

class _ProductDetailState extends State<ProductDetail> {
  var db = SqlDatabase();

  var _productNameController = TextEditingController();
  var _productDescriptionController = TextEditingController();
  var _productUnitPriceController = TextEditingController();

  @override
  void initState() {
    _productNameController.text = widget.product.name;
    _productDescriptionController.text = widget.product.description;
    _productUnitPriceController.text = widget.product.unitPrice.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Detail ${widget.product.name}"),
        actions: [
          buildAppBarPopupMenu(),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: [
            buildProductName(),
            buildProductDescription(),
            buildProductUnitPrice(),
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

  Widget buildAppBarPopupMenu() {
    return PopupMenuButton<Options>(
      onSelected: selectMenuButton,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
        PopupMenuItem(
          value: Options.delete,
          child: Text("Sil"),
        ),
        PopupMenuItem(
          value: Options.update,
          child: Text("Güncelle"),
        ),
      ],
    );
  }

  void selectMenuButton(Options options) async {
    switch (options) {
      case Options.delete:
        await db.delete(widget.product.id);
        Navigator.pop(context, true);
        break;
      case Options.update:
        await db.update(Product.withId(
          id: widget.product.id,
          name: _productNameController.text,
          description: _productDescriptionController.text,
          unitPrice: int.tryParse(_productUnitPriceController.text),
        ));
        Navigator.pop(context, true);
        break;
    }
  }
}
