class Product {
  final String title, image;
 Product({this.title, this.image});
}

List<Product> demo_products = [
  Product(title: "Cabbage", image: "assets/images/img_1.png"),
  Product(title: "Broccoli", image: "assets/images/img_2.png"),
  Product(title: "Carrot", image: "assets/images/img_3.png"),
  Product(title: "Pakcoy", image: "assets/images/img_4.png"),
  Product(title: "Cucumber", image: "assets/images/img_1.png"),
];

class ProductData {
  String name;
  String price;
  List<String> images;
  ProductData({this.name,this.price,this.images});
}

class DataList {
  String name;
  int value;

  DataList({this.name, this.value});
}