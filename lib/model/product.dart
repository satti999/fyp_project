import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Product extends Equatable {
  final String image, title, description, size;
  final int price, id;
   Color color;
  final String colors;

  Product({
    this.id,
    this.image,
    this.title,
    this.price,
    this.description,
    this.size,
    this.color,
    this.colors,
  });

  @override
  List<Object> get props => [id, image, title, price, description, size, color];

  // static Product fromSnapshot(DocumentSnapshot snap) {
  //   Product products = Product();
  // }
  Product.fromMap(data)
      : id = data['id'],
        description = data['description'],
        title = data['title'],
        price = data['price'],
        size = data['size'],
        colors = data['colors'],
        image = data['image'];

}

class Category extends Equatable {
  final String name;
  final String imageUrl;

  Category({this.name, this.imageUrl});

  @override
  List<Object> get props => [name, imageUrl];
// static Category fromSnapshot(DocumentSnapshot snap) {
//   Category category = Category();
// }
}

List<Product> products = [
  Product(
      id: 1,
      title: "Dressing blue shirt",
      price: 234,
      size: "Small",
      description: dummyText,
      image: "assets/images/shirt_1.png",
      color: Color(0xFFDBDEE4)),
  Product(
      id: 2,
      title: "FE/NOM black shirt",
      price: 190,
      size: "Medium",
      description: dummyText,
      image: "assets/images/shirt_2.png",
      color: Color(0xFFDBDEE4)),
  Product(
      id: 3,
      title: "FE/NOM black shirt",
      price: 140,
      size: "Small",
      description: dummyText,
      image: "assets/images/shirt_3.png",
      color: Color(0xFFDBDEE4)),
  Product(
      id: 4,
      title: "FE/NOM Gray shirt",
      price: 170,
      size: "Medium",
      description: dummyText,
      image: "assets/images/shirt_4.png",
      color: Color(0xFFDBDEE4)),
  Product(
      id: 5,
      title: "Adidas Orange shirt",
      price: 280,
      size: "Medium",
      description: dummyText,
      image: "assets/images/shirt_5.png",
      color: Color(0xFFDBDEE4)),
  Product(
    id: 6,
    title: "FE/NOM white shirt",
    price: 114,
    size: "Small",
    description: dummyText,
    image: "assets/images/shirt_6.png",
    color: Color(0xFFDBDEE4),
  ),
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
