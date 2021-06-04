import 'package:ecommerce/shop_view/shop_view.dart';
import 'package:ecommerce/utils/shop_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopListing extends StatelessWidget {
  final List<Result> shopsNearby;

  const ShopListing({Key key, this.shopsNearby}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shops Nearby'),
      ),
      body: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        children: List.generate(
          shopsNearby.length,
          (index) {
            return InkWell(
              onTap: () {
                Get.to(ShopView(
                  data: shopsNearby[index],
                ));
              },
              child: Container(
                color: Colors.white,
                margin: const EdgeInsets.all(8.0),
                child: GridTile(
                  footer: Center(
                    child: Column(
                      children: [
                        Text(
                          shopsNearby[index].name ?? '',
                          style: Get.textTheme.subtitle1,
                        ),
                        Text(
                          shopsNearby[index].category,
                          style: Get.textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  child: Container(),
                  header: Image.network(
                    shopsNearby[index].img,
                    // 'https://img.etimg.com/thumb/width-1200,height-900,imgsize-339811,resizemode-1,msid-76096517/industry/cons-product/fmcg/over-7-lakh-small-stores-may-have-shut-shop-due-to-lockdown.jpg',
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
