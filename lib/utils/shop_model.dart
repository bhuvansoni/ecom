class Result {
  String category;
  String img;
  String latitude;
  String longitude;
  String name;
  List<Product> product;

  Result(
      {this.category,
      this.img,
      this.latitude,
      this.longitude,
      this.name,
      this.product});

  Result.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    img = json['img'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    name = json['name'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['img'] = this.img;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['name'] = this.name;
    if (this.product != null) {
      data['product'] = this.product.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String brand;
  String category;
  String discount;
  String img;
  String mrp;
  String quantity;
  String sp;
  String title;
  String weight;
  String flavour;
  String minimumOrder;
  String packingSize;
  String color;

  Product({
    this.brand,
    this.category,
    this.discount,
    this.img,
    this.mrp,
    this.quantity,
    this.sp,
    this.title,
    this.packingSize,
    this.weight,
    this.flavour,
    this.minimumOrder,
    this.color,
  });

  Product.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return;
    }
    brand = json['brand'];
    category = json['category'];
    discount = json['discount'].toString();
    img = json['img'];
    mrp = json['mrp'].toString();
    quantity = json['quantity'].toString();
    sp = json['sp'].toString();
    title = json['title'];
    packingSize = json['packing size'].toString();
    weight = json['weight'].toString();
    flavour = json['flavour'];
    minimumOrder = json['minimum order'].toString();
    packingSize = json['packing size '].toString();
    weight = json['weight'].toString();
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand'] = this.brand;
    data['category'] = this.category;
    data['discount'] = this.discount;
    data['img'] = this.img;
    data['mrp'] = this.mrp;
    data['quantity'] = this.quantity;
    data['sp'] = this.sp;
    data['title'] = this.title;
    data['brand '] = this.brand;
    data['packing size'] = this.packingSize;
    data['title '] = this.title;
    data['weight '] = this.weight;
    data['flavour'] = this.flavour;
    data['minimum order'] = this.minimumOrder;
    data['packing size '] = this.packingSize;
    data['weight'] = this.weight;
    data['color '] = this.color;
    data['mrp '] = this.mrp;
    data['quantity '] = this.quantity;
    return data;
  }
}
