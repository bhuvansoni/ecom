import 'package:ecommerce/cart/cart_controller.dart';
import 'package:ecommerce/cart/cart_view.dart';
import 'package:ecommerce/dashboard/dashboard_controller.dart';
import 'package:ecommerce/profile/profile_view.dart';
import 'package:ecommerce/shop_view/shop_listing.dart';
import 'package:ecommerce/shop_view/shop_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardView extends StatefulWidget {
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final cartController = Get.put(CartController());

  final controller = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Groczz'),
        actions: [
          InkWell(
            onTap: () {
              Get.to(CartView());
            },
            child: Icon(
              Icons.shopping_cart,
              size: 24,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap: () {
                Get.to(ProfileView());
              },
              child: Icon(
                Icons.account_circle,
                size: 24,
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () {
          if (controller.loading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: Colors.pink[100],
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            // mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Shops Nearby',
                                style: Get.theme.textTheme.headline6,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(ShopListing(
                                      shopsNearby: controller.shopsNearby));
                                },
                                child: Container(
                                  color: Colors.pink[900],
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'View All',
                                    style: Get.theme.textTheme.subtitle1
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          children: List.generate(
                            4,
                            (index) {
                              return InkWell(
                                onTap: () {
                                  Get.to(ShopView(
                                    data: controller.shopsNearby[index],
                                  ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  margin: const EdgeInsets.all(8.0),
                                  child: GridTile(
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Image.network(
                                            controller.shopsNearby[index].img,
                                            height: 140,
                                            width: Get.mediaQuery.size.width,
                                            fit: BoxFit.fill,
                                            // 'https://img.etimg.com/thumb/width-1200,height-900,imgsize-339811,resizemode-1,msid-76096517/industry/cons-product/fmcg/over-7-lakh-small-stores-may-have-shut-shop-due-to-lockdown.jpg',
                                          ),
                                          Text(
                                            controller
                                                    .shopsNearby[index].name ??
                                                '',
                                            style: Get.textTheme.subtitle1,
                                          ),
                                          Text(
                                            controller
                                                .shopsNearby[index].category,
                                            style: Get.textTheme.caption,
                                          ),
                                        ],
                                      ),
                                    ),
                                    // header: Image.network(
                                    //   controller.shopsNearby[index].img,
                                    //   // 'https://img.etimg.com/thumb/width-1200,height-900,imgsize-339811,resizemode-1,msid-76096517/industry/cons-product/fmcg/over-7-lakh-small-stores-may-have-shut-shop-due-to-lockdown.jpg',
                                    // ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.yellow[100],
                    margin: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            // mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Top Selling Items ',
                                style: Get.theme.textTheme.headline6,
                              ),
                              // Container(
                              //   color: Colors.yellow[900],
                              //   padding: EdgeInsets.all(8.0),
                              //   child: Text(
                              //     'View All',
                              //     style: Get.theme.textTheme.subtitle1
                              //         .copyWith(color: Colors.white),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        GridView.count(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          children: List.generate(
                            4,
                            (index) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                margin: const EdgeInsets.all(8.0),
                                child: GridTile(
                                  footer: Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          controller.shopsNearby[0]
                                                  .product[index].title ??
                                              '',
                                          style: Get.theme.textTheme.subtitle1,
                                        ),
                                        Container(
                                          color: Colors.white,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                '₹' +
                                                    controller.shopsNearby[0]
                                                        .product[index].sp
                                                        .toString(),
                                              ),
                                              Text(
                                                '₹' +
                                                    controller.shopsNearby[0]
                                                        .product[index].mrp
                                                        .toString(),
                                                style: Get.textTheme.caption
                                                    .copyWith(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                              ),
                                              Text(
                                                controller.shopsNearby[0]
                                                        .product[index].discount
                                                        .toString() +
                                                    '%',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  child: Container(),
                                  header: Image.network(
                                    controller.shopsNearby[0].product[index].img
                                        .toString(),
                                    height: 100,
                                    width: 100,
                                    scale: 0.8,
                                    // color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
