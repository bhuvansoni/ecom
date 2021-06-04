import 'package:ecommerce/database/local_db.dart';
import 'package:ecommerce/utils/cart_product_model.dart';
import 'package:ecommerce/utils/shop_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final products = <CartProductModel>[].obs;
  final database = LocalDatabase();
  final totalPrice = 0.obs;
  final totalMrp = 0.obs;
  final loading = false.obs;

  void onInit() {
    fetchCart();
    super.onInit();
  }

  Future<void> fetchCart() async {
    loading.value = true;
    products.value = await database.getProduct();
    int tempPrice = 0;
    int tempSp = 0;
    for (int i = 0; i < products.length; i++) {
      tempPrice += int.parse(products[i].sp) * products[i].qty;
      tempSp += int.parse(products[i].mrp) * products[i].qty;
    }
    totalPrice.value = tempSp;
    totalMrp.value = tempPrice;
    loading.value = false;
  }

  Future<void> deleteProd(int index) async {
    await database.removeProduct(products[index]);
    fetchCart();
  }

  Future<void> updateCart(int index) async {}

  Future<void> increaseCount(int index) async {
    final prod = products[index];
    prod.qty = prod.qty + 1;
    int id = await database.updateProduct(prod);
    fetchCart();
  }

  Future<void> decreaseCount(int index) async {
    final prod = products[index];
    if (prod.qty == 1) {
      await database.removeProduct(prod);
    } else {
      prod.qty = prod.qty - 1;
      await database.updateProduct(prod);
    }
    fetchCart();
  }

  Future<void> insertCart(List<Product> prods, List<int> qty) async {
    print('length of pords ${prods.length}');
    for (int i = 0; i < prods.length; i++) {
      final prod = CartProductModel.fromProduct(prods[i], qty[i], 'Cart');

      for (int j = 0; j < this.products.length; j++) {
        if (this.products[j].title == prod.title) {
          print('m yaha aaya');
          prods.removeAt(i);
          qty.removeAt(i);
        }
      }
    }
    print(prods.length);
    print("length of prod");
    for (int i = 0; i < prods.length; i++) {
      final prod = CartProductModel.fromProduct(prods[i], qty[i], 'Cart');

      await database.addProduct(prod);
    }

    fetchCart();
  }
}
