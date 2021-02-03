class Product {
  int id;
  String name;
  String description;
  int unitPrice;

  Product({this.name, this.description, this.unitPrice});
  Product.withId({this.id, this.name, this.description, this.unitPrice});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["name"] = name;
    map["description"] = description;
    map["unitPrice"] = unitPrice;

    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  Product.fromObject(dynamic d) {
    this.id = d["id"];
    this.name = d["name"];
    this.description = d["description"];
    this.unitPrice = d["unitPrice"];
  }
}
