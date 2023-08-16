import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class OffsetProportion {
  final double x;
  final double y;

  const OffsetProportion({
    required this.x,
    required this.y,
  });

  OffsetProportion copyWith({
    double? x,
    double? y,
  }) {
    return OffsetProportion(
      x: x ?? this.x,
      y: y ?? this.y,
    );
  }

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

  @override
  String toString() => 'OffsetProportion(x: $x, y: $y)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OffsetProportion && other.x == x && other.y == y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}

class MySize {
  final double width;
  final double height;

  const MySize({
    required this.width,
    required this.height,
  });

  factory MySize.fromSize(Size size) {
    return MySize(width: size.width, height: size.height);
  }

  MySize copyWith({
    double? width,
    double? height,
  }) {
    return MySize(
      width: width ?? this.width,
      height: height ?? this.height,
    );
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

  @override
  String toString() => 'MySize(width: $width, height: $height)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MySize && other.width == width && other.height == height;
  }

  @override
  int get hashCode => width.hashCode ^ height.hashCode;
}

class MyOffset {
  final double x;
  final double y;

  const MyOffset({
    required this.x,
    required this.y,
  });

  factory MyOffset.fromOffset(Offset offset) {
    return MyOffset(x: offset.dx, y: offset.dy);
  }

  MyOffset copyWith({
    double? x,
    double? y,
  }) {
    return MyOffset(
      x: x ?? this.x,
      y: y ?? this.y,
    );
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

  @override
  String toString() => 'MyOffset(x: $x, y: $y)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MyOffset && other.x == x && other.y == y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}

class ContainerInformation {
  final double aspectRatio;
  final double widthProportion;

  const ContainerInformation({
    required this.aspectRatio,
    required this.widthProportion,
  });

  ContainerInformation copyWith({
    double? aspectRatio,
    double? widthProportion,
  }) {
    return ContainerInformation(
      aspectRatio: aspectRatio ?? this.aspectRatio,
      widthProportion: widthProportion ?? this.widthProportion,
    );
  }

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

  @override
  String toString() => 'ContainerInformation(aspectRatio: $aspectRatio, widthProportion: $widthProportion)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContainerInformation &&
        other.aspectRatio == aspectRatio &&
        other.widthProportion == widthProportion;
  }

  @override
  int get hashCode => aspectRatio.hashCode ^ widthProportion.hashCode;
}

class TextInformation {
  final String text;
  final double fontSize;
  final Color color;
  final OffsetProportion proportion;

  const TextInformation({
    required this.text,
    required this.fontSize,
    required this.color,
    required this.proportion,
  });

  TextInformation copyWith({
    String? text,
    double? fontSize,
    Color? color,
    OffsetProportion? proportion,
  }) {
    return TextInformation(
      text: text ?? this.text,
      fontSize: fontSize ?? this.fontSize,
      color: color ?? this.color,
      proportion: proportion ?? this.proportion,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'text': text});
    result.addAll({'fontSize': fontSize});
    result.addAll({'color': color.value});
    result.addAll({'proportion': proportion.toMap()});

    return result;
  }

  factory TextInformation.fromMap(Map<String, dynamic> map) {
    return TextInformation(
      text: map['text'] ?? '',
      fontSize: map['fontSize']?.toDouble() ?? 0.0,
      color: Color(map['color']),
      proportion: OffsetProportion.fromMap(map['proportion']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TextInformation.fromJson(String source) => TextInformation.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TextInformation(text: $text, fontSize: $fontSize, color: $color, proportion: $proportion)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TextInformation &&
        other.text == text &&
        other.fontSize == fontSize &&
        other.color == color &&
        other.proportion == proportion;
  }

  @override
  int get hashCode {
    return text.hashCode ^ fontSize.hashCode ^ color.hashCode ^ proportion.hashCode;
  }
}

class PositionInformation {
  final List<TextInformation> textInformations;
  final ContainerInformation containerInformation;

  const PositionInformation({
    required this.textInformations,
    required this.containerInformation,
  });

  PositionInformation copyWith({
    List<TextInformation>? textInformations,
    ContainerInformation? containerInformation,
  }) {
    return PositionInformation(
      textInformations: textInformations ?? this.textInformations,
      containerInformation: containerInformation ?? this.containerInformation,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'textInformations': textInformations.map((x) => x.toMap()).toList()});
    result.addAll({'containerInformation': containerInformation.toMap()});

    return result;
  }

  factory PositionInformation.fromMap(Map<String, dynamic> map) {
    return PositionInformation(
      textInformations: List<TextInformation>.from(map['textInformations']?.map((x) => TextInformation.fromMap(x))),
      containerInformation: ContainerInformation.fromMap(map['containerInformation']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PositionInformation.fromJson(String source) => PositionInformation.fromMap(json.decode(source));

  @override
  String toString() =>
      'PositionInformation(textInformations: $textInformations, containerInformation: $containerInformation)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PositionInformation &&
        listEquals(other.textInformations, textInformations) &&
        other.containerInformation == containerInformation;
  }

  @override
  int get hashCode => textInformations.hashCode ^ containerInformation.hashCode;
}
