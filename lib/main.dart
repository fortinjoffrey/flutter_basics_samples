import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'models/order.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kitchen Orders',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const OrderListPage(),
    );
  }
}

class OrderListPage extends StatefulWidget {
  const OrderListPage({super.key});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  late final List<Order> orders;

  @override
  void initState() {
    super.initState();
    _initializeOrders();
  }

  void _initializeOrders() {
    // Commandes Internal
    final order3 = Order(
      platform: Platform.internal,
      riderName: "Mike",
      readyAt: DateTime.now().add(const Duration(minutes: 15)),
    );
    final order8 = Order(
      platform: Platform.internal,
      riderName: "Lisa",
      readyAt: DateTime.now().add(const Duration(minutes: 18)),
    );
    final order9 = Order(
      platform: Platform.internal,
      riderName: "David",
      readyAt: DateTime.now().add(const Duration(minutes: 20)),
    );

    // Commandes Other
    final order4 = Order(
      platform: Platform.other,
      riderName: "Alex",
      readyAt: DateTime.now().add(const Duration(minutes: 5)),
    );
    final order6 = Order(
      platform: Platform.other,
      riderName: "James",
      readyAt: DateTime.now().add(const Duration(minutes: 16)),
    );
    final order7 = Order(
      platform: Platform.other,
      riderName: "Tom",
      readyAt: DateTime.now().add(const Duration(minutes: 22)),
    );

    final order11 = Order(
      platform: Platform.other,
      riderName: "Peter",
      readyAt: DateTime.now().add(const Duration(minutes: 14)),
    );
    final order12 = Order(
      platform: Platform.other,
      riderName: "Mary",
      readyAt: DateTime.now().add(const Duration(minutes: 17)),
    );

    // Mise à jour des linkedOrdersIds
    order3.linkedOrdersIds.addAll([order8.id, order9.id]);
    order8.linkedOrdersIds.addAll([order3.id, order9.id]);
    order9.linkedOrdersIds.addAll([order3.id, order8.id]);

    order4.linkedOrdersIds.addAll([order6.id, order7.id]);
    order6.linkedOrdersIds.addAll([order4.id, order7.id]);
    order7.linkedOrdersIds.addAll([order4.id, order6.id]);

    order11.linkedOrdersIds.add(order12.id);
    order12.linkedOrdersIds.add(order11.id);

    orders = [
      Order(
        platform: Platform.internal,
        riderName: "John",
        readyAt: DateTime.now().add(const Duration(minutes: 8)),
      ),
      Order(
        platform: Platform.internal,
        riderName: "Sarah",
        readyAt: DateTime.now().add(const Duration(minutes: 12)),
      ),
      order3,
      order8,
      order9,
      Order(
        platform: Platform.internal,
        riderName: "Sophie",
        readyAt: DateTime.now().add(const Duration(minutes: 25)),
      ),
      order4,
      Order(
        platform: Platform.other,
        riderName: "Emma",
        readyAt: DateTime.now().add(const Duration(minutes: 10)),
      ),
      order6,
      order7,
      order11,
      order12,
      Order(
        platform: Platform.other,
        riderName: "Chris",
        readyAt: DateTime.now().add(const Duration(minutes: 28)),
      ),
      Order(
        platform: Platform.other,
        riderName: "Kate",
        readyAt: DateTime.now().add(const Duration(minutes: 30)),
      ),
    ];
  }

  List<Order> getOrdersByReadyAtForInternalThenByReadyAtWithLinkedOrders() {
    final ordersByReadyAtWithLinkedOrders = getOrdersByReadyAtWithLinkedOrders();
    final internal = ordersByReadyAtWithLinkedOrders.where((element) => element.platform == Platform.internal);
    final other = ordersByReadyAtWithLinkedOrders.where((element) => element.platform != Platform.internal);
    return [...internal, ...other];
  }

  List<Order> getOrdersByReadyAtWithLinkedOrders() {
    final allOrdersSortedByReadyAt = orders;
    allOrdersSortedByReadyAt.sort(((a, b) => a.readyAt.compareTo(b.readyAt)));

    final processedlinkedIds = [];
    final List<Order> returnedOrders = [];

    for (final order in allOrdersSortedByReadyAt) {
      if (processedlinkedIds.contains(order.id)) continue;

      if (order.linkedOrdersIds.isEmpty) {
        returnedOrders.add(order);
        continue;
      }

      final linkedOrders = [];

      for (final linkedOrderId in order.linkedOrdersIds) {
        final linkedOrder = orders.firstWhere((element) => element.id == linkedOrderId);
        linkedOrders.add(linkedOrder);
        processedlinkedIds.add(linkedOrderId);
      }

      linkedOrders.sort(((a, b) => a.readyAt.compareTo(b.readyAt)));

      returnedOrders.addAll([order, ...linkedOrders]);
    }
    return returnedOrders;
  }

  void _removeOrder(String orderId) {
    setState(() {
      // Mettre à jour les linkedOrdersIds de toutes les commandes
      for (var order in orders) {
        order.linkedOrdersIds.remove(orderId);
      }

      // Supprimer la commande
      orders.removeWhere((order) => order.id == orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final sortedOrders = getOrdersByReadyAtForInternalThenByReadyAtWithLinkedOrders();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kitchen Orders'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: sortedOrders.length,
        itemBuilder: (context, index) {
          final order = sortedOrders[index];
          final hasLinkedOrders = order.linkedOrdersIds.isNotEmpty;

          // Vérifier si cette commande est liée à la précédente
          final isLinkedToPrevious = index > 0 &&
              (order.linkedOrdersIds.contains(sortedOrders[index - 1].id) ||
                  sortedOrders[index - 1].linkedOrdersIds.contains(order.id));

          // Vérifier si cette commande est liée à la suivante
          final isLinkedToNext = index < sortedOrders.length - 1 &&
              (order.linkedOrdersIds.contains(sortedOrders[index + 1].id) ||
                  sortedOrders[index + 1].linkedOrdersIds.contains(order.id));

          return Card(
              margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (isLinkedToPrevious)
                          Expanded(
                            child: Container(
                              color: Colors.red,
                              width: 2,
                            ),
                          ),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            shape: BoxShape.circle,
                            border: hasLinkedOrders ? Border.all(color: Colors.red, width: 2) : null,
                          ),
                          child: Icon(
                            order.platform == Platform.internal ? Icons.home : Icons.delivery_dining,
                            color: order.platform == Platform.internal ? Colors.green : Colors.orange,
                            size: 20,
                          ),
                        ),
                        if (isLinkedToNext)
                          Expanded(
                            child: Container(
                              color: Colors.red,
                              width: 2,
                            ),
                          ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text('Rider: ${order.riderName}'),
                          Text(
                            'Ready at: ${order.readyAt.toString()}\n'
                            'Platform: ${order.platform.name}',
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (hasLinkedOrders) const Icon(Icons.link, color: Colors.blue),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _removeOrder(order.id),
                        ),
                      ],
                    ),
                  ],
                ),
              )
              // child: ListTile(
              //   contentPadding: EdgeInsets.zero,
              //   leading: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       if (isLinkedToPrevious)
              //         Expanded(
              //           child: Container(
              //             color: Colors.red,
              //             width: 2,
              //           ),
              //         ),
              //       Container(
              //         width: 32,
              //         height: 32,
              //         decoration: BoxDecoration(
              //           color: Colors.grey[200],
              //           shape: BoxShape.circle,
              //           border: hasLinkedOrders ?
              //             Border.all(color: Colors.red, width: 2) :
              //             null,
              //         ),
              //         child: Icon(
              //           order.platform == Platform.internal ? Icons.home : Icons.delivery_dining,
              //           color: order.platform == Platform.internal ? Colors.green : Colors.orange,
              //           size: 20,
              //         ),
              //       ),
              //       if (isLinkedToNext)
              //         Expanded(
              //           child: Container(
              //             color: Colors.red,
              //             width: 2,
              //           ),
              //         ),
              //     ],
              //   ),
              //   title: Text('Rider: ${order.riderName}'),
              //   subtitle: Text(
              //     'Ready at: ${order.readyAt.toString()}\n'
              //     'Platform: ${order.platform.name}',
              //   ),
              //   trailing: Row(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       if (hasLinkedOrders)
              //         const Icon(Icons.link, color: Colors.blue),
              //       IconButton(
              //         icon: const Icon(Icons.delete, color: Colors.red),
              //         onPressed: () => _removeOrder(order.id),
              //       ),
              //     ],
              //   ),
              // ),
              );
        },
      ),
    );
  }
}
