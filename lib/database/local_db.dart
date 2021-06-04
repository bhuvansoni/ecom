import 'package:ecommerce/utils/cart_product_model.dart';
import 'package:ecommerce/utils/shop_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  Database _database;

  Future<void> openDb() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'local_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE localDb(id INTEGER PRIMARY KEY AUTOINCREMENT, qty INTEGER,discount TEXT, type TEXT, brand TEXT, category TEXT, img TEXT, mrp TEXT, sp TEXT, title TEXT, packingSize TEXT, weight TEXT, flavour TEXT, color TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<int> addProduct(CartProductModel product) async {
    await openDb();

    _database.insert('localDb', product.toMap());

    return 0;
  }

  Future<int> removeProduct(CartProductModel product) async {
    await openDb();
    return _database.delete('localDb', where: 'id=?', whereArgs: [product.id]);
  }

  Future<int> updateProduct(CartProductModel model) async {
    await openDb();
    return _database
        .update('localDb', model.toMap(), where: 'id=?', whereArgs: [model.id]);
  }

  Future<List<CartProductModel>> getProduct() async {
    await openDb();
    final res = await _database.query('localDb');
    return List.generate(
      res.length,
      (index) {
        return CartProductModel.fromMap(res[index]);
      },
    );
  }
}
