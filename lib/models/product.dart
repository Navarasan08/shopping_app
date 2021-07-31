

import 'dart:convert';

import 'package:equatable/equatable.dart';

List<Product> productFromJson(List str) => List<Product>.from(str.map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product extends Equatable {
    Product({
        this.categoryName,
        this.discountedPrice,
        this.categoryId,
        this.color,
        this.mdate,
        this.price,
        this.imageUrl,
        this.name,
        this.status,
        this.description,
        this.timestamp,
    });

    final String categoryName;
    final dynamic discountedPrice;
    final String categoryId;
    final String description;
    final String color;
    final String mdate;
    final double price;
    final String imageUrl;
    final String name;
    final String status;
    final int timestamp;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        categoryName: json["category_name"] == null ? null : json["category_name"],
        discountedPrice: json["discountedPrice"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        color: json["color"] == null ? null : json["color"],
        mdate: json["mdate"] == null ? null : json["mdate"],
        price: json["price"] == null ? null : json["price"].toDouble(),
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        name: json["name"] == null ? null : json["name"],
        status: json["status"] == null ? null : json["status"],
        description: json["description"] == null ? null : json["description"],
        timestamp: json["timestamp"] == null ? null : json["timestamp"],
    );

    Map<String, dynamic> toJson() => {
        "category_name": categoryName == null ? null : categoryName,
        "discountedPrice": discountedPrice,
        "category_id": categoryId == null ? null : categoryId,
        "color": color == null ? null : color,
        "mdate": mdate == null ? null : mdate,
        "price": price == null ? null : price,
        "imageUrl": imageUrl == null ? null : imageUrl,
        "name": name == null ? null : name,
        "status": status == null ? null : status,
        "description": description == null ? null : description,
        "timestamp": timestamp == null ? null : timestamp,
    };

    @override
  List<Object> get props => [name];
}
