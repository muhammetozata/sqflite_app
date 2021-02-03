import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_app/models/Product.dart';

class SqlDatabase {
  Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initDatabase();
    }
    return _db;
  }

  Future<Database> initDatabase() async {
    String dbPath = join(await getDatabasesPath(), "sqflite.db");
    var openDB = openDatabase(dbPath, version: 1, onCreate: createDb);
    return openDB;
  }

  FutureOr<void> createDb(Database db, int version) {
    db.execute(
        "CREATE TABLE products (id integer primary key, name text, description text, unitPrice integer) ");
  }

  Future<List<Product>> getProducts() async {
    Database db = await this.db;
    var results = await db.query("products");

    return List.generate(results.length, (index) {
      return Product.fromObject(results[index]);
    });
  }

  Future<int> insert(Product product) async {
    Database db = await this.db;
    var result = await db.insert("products", product.toMap());
    return result;
  }

  Future<int> delete(int id) async {
    Database db = await this.db;
    var result = await db.rawDelete("DELETE FROM products WHERE id=?", [id]);
    return result;
  }

  Future<int> update(Product product) async {
    Database db = await this.db;
    var result = db.update("products", product.toMap(),
        where: "id=?", whereArgs: [product.id]);
    return result;
  }
}
