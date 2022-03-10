// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'father.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Father _$$_FatherFromJson(Map<String, dynamic> json) => _$_Father(
      name: json['name'] as String,
      child: Child.fromJson(json['child'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_FatherToJson(_$_Father instance) => <String, dynamic>{
      'name': instance.name,
      'child': instance.child.toJson(),
    };
