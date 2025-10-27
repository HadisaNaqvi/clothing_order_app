import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Product {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final double price;

  @HiveField(4)
  final List<String> sizes;

  @HiveField(5)
  final List<String> images; // local images from assets folder

  @HiveField(6)
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.sizes,
    required this.images,
    required this.category,
  });
}

// 👇 MANUAL ADAPTER (no generator needed)
class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 0;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{};
    for (int i = 0; i < numOfFields; i++) {
      fields[reader.readByte()] = reader.read();
    }
    return Product(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      price: fields[3] as double,
      sizes: (fields[4] as List).cast<String>(),
      images: (fields[5] as List).cast<String>(),
      category: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(7) // total number of fields
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.sizes)
      ..writeByte(5)
      ..write(obj.images)
      ..writeByte(6)
      ..write(obj.category);
  }
}
