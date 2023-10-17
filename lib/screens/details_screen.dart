import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/router.dart';
import 'package:go_router/go_router.dart';

import '../sign_up_dialog.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    super.key,
    required this.itemId,
    required this.itemName,
    required this.isFavorite,
    required this.shoudShowDialog,
    required this.initialSignUpStep,
  });

  final String itemId;
  final String? itemName;
  final bool? isFavorite;
  final bool? shoudShowDialog;
  final SignUpSteps? initialSignUpStep;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.shoudShowDialog == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (context) {
            return SignUpDialog(
              initialStep: widget.initialSignUpStep,
            );
          },
        );
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailsScreen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('itemId: ${widget.itemId}'),
            Text('itemName: ${widget.itemName}'),
            Checkbox(
              value: widget.isFavorite ?? false,
              onChanged: (value) {
                DetailsRoute(
                  itemId: widget.itemId,
                  itemName: widget.itemName,
                  isFavorite: value,
                  shoudShowDialog: widget.shoudShowDialog,
                ).go(context);
              },
            ),
            ElevatedButton(
              onPressed: () {
                // const HomeRoute().go(context);
                GoRouter.of(context).pop();
              },
              child: const Text("pop()"),
            ),
          ],
        ),
      ),
    );
  }
}
