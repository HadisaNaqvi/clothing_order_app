import 'package:hive/hive.dart';
import 'product.dart';

@HiveType(typeId: 2)
class Cart {
  @HiveField(0)
  final Product product;

  @HiveField(1)
  int quantity;

  Cart({required this.product, required this.quantity});

  double get totalPrice => product.price * quantity;
}

// MANUAL ADAPTER
class CartAdapter extends TypeAdapter<Cart> {
  @override
  final int typeId = 2;

  @override
  Cart read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{};
    for (int i = 0; i < numOfFields; i++) {
      fields[reader.readByte()] = reader.read();
    }
    return Cart(product: fields[0] as Product, quantity: fields[1] as int);
  }

  @override
  void write(BinaryWriter writer, Cart obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.product)
      ..writeByte(1)
      ..write(obj.quantity);
  }
}
