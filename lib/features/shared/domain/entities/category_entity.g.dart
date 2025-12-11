// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryEntityAdapter extends TypeAdapter<CategoryEntity> {
  @override
  final int typeId = 1;

  @override
  CategoryEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryEntity(
      id: fields[0] as int,
      parentId: fields[6] as int?,
      name: fields[1] as String,
      img: fields[2] as String,
      count: fields[3] as int,
      bookIds: (fields[4] as List).cast<int>(),
      subCategoryIds: (fields[5] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, CategoryEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(6)
      ..write(obj.parentId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.img)
      ..writeByte(3)
      ..write(obj.count)
      ..writeByte(4)
      ..write(obj.bookIds)
      ..writeByte(5)
      ..write(obj.subCategoryIds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
