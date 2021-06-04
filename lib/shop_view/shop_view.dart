import 'package:ecommerce/shop_view/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/shop_model.dart';

class ShopView extends StatelessWidget {
  final Result data;
  ShopView({Key key, this.data}) : super(key: key);

  final controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.name ?? ''),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildShopDetail(),
            generateListing(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => controller.products.isEmpty
            ? Container(height: 0, width: 0)
            : Container(
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
                            // '${cartController.totalPrice}',
                            '${controller.products.length} Items',
                            style: Get.textTheme.bodyText1,
                          ),
                          Text(
                            '₹${controller.totalPrice}',
                            style: Get.textTheme.bodyText1.copyWith(
                              color: Get.theme.primaryColor,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          controller.addToCart();
                        },
                        child: Container(
                          height: 48,
                          color: Colors.yellow[900],
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'Add to Cart',
                              style: Get.textTheme.button.copyWith(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget generateListing() {
    return Obx(
      () => Column(
        children: List.generate(
          data.product.length,
          (index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.network(
                    data.product[index].img ?? '',
                    width: 100,
                    height: 100,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.product[index].brand ?? '',
                          style: Get.theme.textTheme.subtitle2,
                          overflow: TextOverflow.clip,
                        ),
                        Text(
                          data.product[index].title ?? '',
                          style: Get.theme.textTheme.bodyText2,
                          overflow: TextOverflow.clip,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                '₹' + data.product[index].sp ?? '',
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Text(
                                '₹' + data.product[index].mrp ?? '',
                              ),
                            ),
                            Text(
                              '${data.product[index].discount}%' ?? '',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.add,
                            size: 15,
                          ),
                          onPressed: () {
                            controller.addProducts(
                              data.product[index],
                            );
                          },
                        ),
                        Text(controller.products.indexOf(data.product[index]) ==
                                -1
                            ? '0'
                            : controller.qty[controller.products
                                    .indexOf(data.product[index])]
                                .toString()),
                        IconButton(
                          icon: Icon(
                            Icons.remove,
                            size: 15,
                          ),
                          onPressed: () {
                            controller.decreaseQty(data.product[index]);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildShopDetail() {
    return Container(
      height: Get.mediaQuery.size.height * 0.2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name ?? '',
                  style: Get.textTheme.headline6,
                ),
                Text(data.category ?? ''),
                Text('Open, Closes at 9:00 PM'),
                Row(
                  children: List.generate(
                    6,
                    (index) {
                      if (index == 5) {
                        return Text('(365 ratings)');
                      }
                      return Icon(
                        Icons.star,
                        color: Get.theme.primaryColor,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Image.network(data.img ?? '', height: 150, width: 150),
        ],
      ),
    );
  }
}
