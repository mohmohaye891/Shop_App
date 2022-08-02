import 'package:json_annotation/json_annotation.dart';
part 'product.g.dart';

@JsonSerializable()
class Product {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;

  Product(this.id, this.title, this.price, this.description, this.category,
      this.image);

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
