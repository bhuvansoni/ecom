import 'dart:convert';
import 'package:ecommerce/utils/shop_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/shop_model.dart';

class DashboardController extends GetxController {
  final shopsNearby = <Result>[].obs;
  final loading = false.obs;

  void onInit() {
    getShopsNearby();
    super.onInit();
  }

  Future<void> getShopsNearby() async {
    loading(true);
    final res = await http.get(
      Uri.parse('https://ecom-b7cd2.firebaseio.com/Shops.json'),
    );
    final decodedJson = json.decode(res.body);
    shopsNearby.value = List.generate(
      decodedJson.length,
      (index) => Result.fromJson(
        decodedJson[index],
      ),
    );

    print(res.body);
    loading(false);
  }
}
