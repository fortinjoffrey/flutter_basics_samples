import 'package:uuid/uuid.dart';

enum Platform {
  internal,
  other,
}

class Order {
  final String id;
  final Platform platform;
  final List<String> linkedOrdersIds;
  final String riderName;
  final DateTime readyAt;
  final bool isDisabled;

  Order({
    String? id,
    required this.platform,
    List<String>? linkedOrdersIds,
    required this.riderName,
    required this.readyAt,
    this.isDisabled = false,
  })  : id = id ?? const Uuid().v4(),
        linkedOrdersIds = linkedOrdersIds ?? [];

} 