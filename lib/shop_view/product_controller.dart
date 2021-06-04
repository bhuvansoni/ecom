import 'package:ecommerce/cart/cart_controller.dart';
import 'package:ecommerce/cart/cart_view.dart';
import 'package:ecommerce/utils/cart_product_model.dart';
import 'package:ecommerce/utils/shop_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final products = <Product>[].obs;
  final qty = <int>[].obs;
  final totalPrice = 0.obs;

  CartController controller;
  ProductController() {
    controller = Get.find<CartController>();
  }

  void addProducts(Product product) {
    int index = products.indexOf(product);
    if (index == -1) {
      products.add(product);
      int idx = products.indexOf(product);
      totalPrice.value += int.parse(products[idx].sp);
      this.qty.add(1);
    } else {
      totalPrice.value += int.parse(products[index].sp);
      this.qty[index] = this.qty[index] + 1;
    }
  }

  void decreaseQty(Product product) {
    int index = products.indexOf(product);
    if (index != -1) {
      if (qty[index] == 1) {
        totalPrice.value -= int.parse(products[index].sp);
        products.removeAt(index);
        qty.removeAt(index);
      } else {
        this.qty[index] = this.qty[index] - 1;

        totalPrice.value -= int.parse(products[index].sp);
      }
    }
  }

  Future<void> addToCart() async {
    List<Product> tempProd = products.toList();
    List<int> tempQty = qty.toList();
    totalPrice.value = 0;

    for (int i = 0; i < products.length; i++) {
      products.removeAt(i);
      qty.removeAt(i);
    }
    Get.to(CartView());
    await controller.insertCart(tempProd, tempQty);
  }
}
