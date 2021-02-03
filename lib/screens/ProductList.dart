import 'package:flutter/material.dart';
import 'package:sqflite_app/data/SqlDatabase.dart';
import 'package:sqflite_app/models/Product.dart';
import 'package:sqflite_app/screens/ProductAdd.dart';
import 'package:sqflite_app/screens/ProductDetail.dart';

class ProductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State<ProductList> {
  var db = SqlDatabase();
  List<Product> products;
  int productCount = 0;

  @override
  void initState() {
    getProducts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
      ),
      body: buildProductListView(),
      floatingActionButton: buildProductAddScreen(),
    );
  }

  ListView buildProductListView() {
    return ListView.builder(
      itemCount: productCount,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.amber[400],
          child: ListTile(
            leading:
                CircleAvatar(backgroundColor: Colors.black12, child: Text("P")),
            title: Text(products[index].name),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(products[index].description),
                Text(products[index].unitPrice.toString() + " TL"),
              ],
            ),
            onTap: () {
              gotoProductDetail(products[index]);
            },
          ),
        );
      },
    );
  }

  void getProducts() {
    db.getProducts().then((data) {
      setState(() {
        products = data;
        productCount = data.length;
      });
    });
  }

  Widget buildProductAddScreen() {
    return FloatingActionButton(
      onPressed: () {
        gotoProductAdd();
      },
      child: Icon(Icons.add),
      backgroundColor: Colors.greenAccent,
    );
  }

  void gotoProductAdd() async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProductAdd()));

    if (result != null) {
      getProducts();
    }
  }

  void gotoProductDetail(Product product) async {
    bool result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProductDetail(product)));

    if (result != null) {
      getProducts();
    }
  }
}
