import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'cart_controller.dart';

class CartView extends StatelessWidget {
  final cartController = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          height: 56,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '₹${cartController.totalPrice.value}',
                      style: Get.textTheme.bodyText1,
                    ),
                    Text(
                      '${cartController.products.length}ITEMS',
                      style: Get.textTheme.bodyText1.copyWith(
                          color: Get.theme.primaryColor, fontSize: 10),
                    ),
                  ],
                ),
                Container(
                  height: 48,
                  color: Colors.yellow[900],
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Place Order',
                      style: Get.textTheme.button
                          .copyWith(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Obx(
        () => cartController.loading.value
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        cartController.products.length,
                        (index) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              cartItem(
                                index,
                              ),
                              index + 1 == cartController.products.length
                                  ? Container(height: 0, width: 0)
                                  : Divider(thickness: 8),
                            ],
                          );
                        },
                      ),
                    ),
                    Divider(thickness: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('PRICE DETAILS',
                              style: Get.textTheme.caption),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Price(${cartController.products.length} item)',
                                style: Get.textTheme.bodyText2,
                              ),
                              Text(
                                '₹${cartController.totalMrp}',
                                style: Get.textTheme.bodyText2,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Discount',
                                style: Get.textTheme.bodyText2,
                              ),
                              Text(
                                '-₹${cartController.totalMrp.value - cartController.totalPrice.value}',
                                style: Get.textTheme.bodyText2,
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Amount',
                                style: Get.textTheme.bodyText1,
                              ),
                              Text(
                                '₹${cartController.totalPrice}',
                                style: Get.textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget cartItem(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cartController.products[index].title ?? ''),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '4',
                                style: Get.textTheme.caption.copyWith(
                                    color: Colors.white, fontSize: 10),
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text('(13)')
                    ],
                  ),
                ],
              ),
              Image.network(
                cartController.products[index].img,
                height: 100,
                width: 100,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '₹' + cartController.products[index].sp.toString(),
                    style: Get.textTheme.subtitle1
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '₹' + cartController.products[index].mrp.toString(),
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      cartController.products[index].discount.toString() +
                          '% off',
                      style: Get.textTheme.subtitle1
                          .copyWith(color: Colors.green, fontSize: 16),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.add,
                            size: 12,
                          ),
                          onPressed: () {
                            cartController.increaseCount(index);
                          }),
                      Text(cartController.products[index].qty.toString()),
                      IconButton(
                          icon: Icon(
                            Icons.remove,
                            size: 12,
                          ),
                          onPressed: () {
                            cartController.decreaseCount(index);
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Text(
            'Delivery by Thu May 27',
            style: Get.textTheme.bodyText2,
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.save_alt,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Save for later',
                        style: Get.textTheme.button,
                      ),
                    )
                  ],
                ),
                Divider(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    cartController.deleteProd(index);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Remove',
                          style: Get.textTheme.button,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
