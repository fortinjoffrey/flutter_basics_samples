import 'dart:convert';

import 'package:flutter/widgets.dart';

class OffsetProportion {
  final double x;
  final double y;

  const OffsetProportion({required this.x, required this.y});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'x': x});
    result.addAll({'y': y});

    return result;
  }

  factory OffsetProportion.fromMap(Map<String, dynamic> map) {
    return OffsetProportion(
      x: map['x']?.toDouble() ?? 0.0,
      y: map['y']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OffsetProportion.fromJson(String source) => OffsetProportion.fromMap(json.decode(source));
}

class MySize {
  final double width;
  final double height;

  const MySize({required this.width, required this.height});

  factory MySize.fromSize(Size size) {
    return MySize(width: size.width, height: size.height);
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'width': width});
    result.addAll({'height': height});

    return result;
  }

  factory MySize.fromMap(Map<String, dynamic> map) {
    return MySize(
      width: map['width']?.toDouble() ?? 0.0,
      height: map['height']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory MySize.fromJson(String source) => MySize.fromMap(json.decode(source));
}

class MyOffset {
  final double x;
  final double y;

  const MyOffset({required this.x, required this.y});

  factory MyOffset.fromOffset(Offset offset) {
    return MyOffset(x: offset.dx, y: offset.dy);
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'x': x});
    result.addAll({'y': y});

    return result;
  }

  factory MyOffset.fromMap(Map<String, dynamic> map) {
    return MyOffset(
      x: map['x']?.toDouble() ?? 0.0,
      y: map['y']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyOffset.fromJson(String source) => MyOffset.fromMap(json.decode(source));
}

class ContainerInformation {
  final double aspectRatio;
  final double widthProportion;

  const ContainerInformation({
    required this.aspectRatio,
    required this.widthProportion,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'aspectRatio': aspectRatio});
    result.addAll({'widthProportion': widthProportion});
  
    return result;
  }

  factory ContainerInformation.fromMap(Map<String, dynamic> map) {
    return ContainerInformation(
      aspectRatio: map['aspectRatio']?.toDouble() ?? 0.0,
      widthProportion: map['widthProportion']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContainerInformation.fromJson(String source) => ContainerInformation.fromMap(json.decode(source));
}

class TextInformation {
  final String text;
  final double fontSize;
  final OffsetProportion proportion;

  const TextInformation({
    required this.text,
    required this.fontSize,
    required this.proportion,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'text': text});
    result.addAll({'fontSize': fontSize});
    result.addAll({'proportion': proportion.toMap()});

    return result;
  }

  factory TextInformation.fromMap(Map<String, dynamic> map) {
    return TextInformation(
      text: map['text'] ?? '',
      fontSize: map['fontSize']?.toDouble() ?? 0.0,
      proportion: OffsetProportion.fromMap(map['proportion']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TextInformation.fromJson(String source) => TextInformation.fromMap(json.decode(source));
}

class PositionInformation {
  final TextInformation textInformation;
  final ContainerInformation containerInformation;

  const PositionInformation({
    required this.textInformation,
    required this.containerInformation,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'textInformation': textInformation.toMap()});
    result.addAll({'containerInformation': containerInformation.toMap()});
  
    return result;
  }

  factory PositionInformation.fromMap(Map<String, dynamic> map) {
    return PositionInformation(
      textInformation: TextInformation.fromMap(map['textInformation']),
      containerInformation: ContainerInformation.fromMap(map['containerInformation']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PositionInformation.fromJson(String source) => PositionInformation.fromMap(json.decode(source));
}
