import 'package:ecommerce/utils/shop_model.dart';

class CartProductModel extends Product {
  int qty;
  int id;
  String type;
  CartProductModel({
    this.qty,
    this.id,
    this.type,
    String brand,
    String category,
    String discount,
    String img,
    String mrp,
    String sp,
    String title,
    String packagingSize,
    String weight,
    String flavour,
    String color,
  }) {
    super.brand = brand;
    super.discount = discount;
    super.img = img;
    super.mrp = mrp;
    super.sp = sp;
    super.title = title;
    super.packingSize = packagingSize;
    super.weight = weight;
    super.flavour = flavour;
    super.category = category;
    super.color = color;
  }

  factory CartProductModel.fromMap(Map<String, dynamic> data) {
    return CartProductModel(
      qty: data['qty'],
      id: data['id'],
      type: data['type'],
      brand: data['brand'],
      category: data['category'],
      discount: data['discount'],
      img: data['img'],
      mrp: data['mrp'],
      sp: data['sp'],
      title: data['title'],
      packagingSize: data['packagingSize'],
      weight: data['weight'],
      flavour: data['flavour'],
      color: data['color'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'qty': qty,
      'id': id,
      'type': type,
      'brand': brand,
      'category': category,
      'discount': discount,
      'img': img,
      'mrp': mrp,
      'sp': sp,
      'title': title,
      'packingSize': packingSize,
      'weight': weight,
      'flavour': flavour,
      'color': color,
    };
  }

  factory CartProductModel.fromProduct(Product data, int qty, String from) {
    return CartProductModel(
      qty: qty,
      type: from,
      brand: data.brand,
      category: data.category,
      discount: data.discount,
      img: data.img,
      mrp: data.mrp,
      sp: data.sp,
      title: data.title,
      packagingSize: data.packingSize,
      weight: data.weight,
      flavour: data.flavour,
      color: data.color,
    );
  }
}
