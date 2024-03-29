// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_links_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WebLinksModelAdapter extends TypeAdapter<WebLinksModel> {
  @override
  final int typeId = 1;

  @override
  WebLinksModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WebLinksModel(
      id: fields[0] as int,
      socialMediaType: fields[3] as String,
      urlTitle: fields[2] as String,
      url: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WebLinksModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.urlTitle)
      ..writeByte(3)
      ..write(obj.socialMediaType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WebLinksModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
