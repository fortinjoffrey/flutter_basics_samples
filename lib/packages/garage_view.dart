import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/packages_core/core_http_client.dart';

class GaragePage extends StatelessWidget {
  const GaragePage({
    super.key,
    required this.tokenProvider,
    required this.vehicleIds,
  });

  final TokenProvider tokenProvider;
  final List<String> vehicleIds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Garage'),
      ),
      body: Center(child: Text('Garage')),
    );
  }
}
