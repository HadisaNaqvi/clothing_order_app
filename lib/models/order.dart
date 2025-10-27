import 'package:hive/hive.dart';
import 'product.dart';

@HiveType(typeId: 1)
class Order {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final List<Product> products;

  @HiveField(2)
  final double totalAmount;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final String status;

  Order({
    required this.id,
    required this.products,
    required this.totalAmount,
    required this.date,
    required this.status,
  });
}

// 👇 MANUAL ADAPTER (no generator needed)
class OrderAdapter extends TypeAdapter<Order> {
  @override
  final int typeId = 1;

  @override
  Order read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{};
    for (int i = 0; i < numOfFields; i++) {
      fields[reader.readByte()] = reader.read();
    }
    return Order(
      id: fields[0] as String,
      products: (fields[1] as List).cast<Product>(),
      totalAmount: fields[2] as double,
      date: fields[3] as DateTime,
      status: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Order obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.products)
      ..writeByte(2)
      ..write(obj.totalAmount)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.status);
  }
}
