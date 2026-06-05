import 'package:json_annotation/json_annotation.dart';

import '../../products/data/models/product.dart';

part 'cart_item.g.dart';

@JsonSerializable()
class CartItem {
  final Product product;
  final int quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });

  CartItem copyWith({
    Product? product,
    int? quantity,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  factory CartItem.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$CartItemFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CartItemToJson(this);
}

