// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'father.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Father _$FatherFromJson(Map<String, dynamic> json) => Father(
      json['name'] as String,
      Child.fromJson(json['child'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FatherToJson(Father instance) => <String, dynamic>{
      'name': instance.name,
      'child': instance.child.toJson(),
    };
