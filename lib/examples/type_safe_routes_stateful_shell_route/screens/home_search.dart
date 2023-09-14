import 'package:flutter/material.dart';

class HomeSearchScreen extends StatelessWidget {
  const HomeSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Search Screen'),
      ),
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // TextButton(
            //   onPressed: () {
            //     GoRouter.of(context).go(detailsPath, extra: DetailsModel('XGS'));
            //   },
            //   child: const Text('View details'),
            // ),
            // const Padding(padding: EdgeInsets.all(4)),
            // if (secondDetailsPath != null)
            //   TextButton(
            //     onPressed: () {
            //       GoRouter.of(context).go(secondDetailsPath!);
            //     },
            //     child: const Text('View more details'),
            //   ),
          ],
        ),
      ),
    );
  }
}