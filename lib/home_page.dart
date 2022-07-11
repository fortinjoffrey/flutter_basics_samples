import 'package:basics_samples/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'settings_page.dart';
import 'widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _key1 = GlobalKey();
  final _key2 = GlobalKey();
  final _key3 = GlobalKey();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShowCaseWidget.of(context).startShowCase([_key1, _key2, _key3]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            ShowCaseWidget.of(context).startShowCase([_key1, _key2, _key3]);
          },
          icon: const Icon(
            Icons.help_rounded,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SettingsPage(),
                ),
              );
            },
            icon: Showcase(
              key: _key1,
              description: 'Change your water intake goal settings',
              onTargetClick: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ))
                    .then((_) {
                  Future.delayed(const Duration(milliseconds: 300), () {
                    ShowCaseWidget.of(context).startShowCase([_key2, _key3]);
                  });
                });
              },
              disposeOnTap: true,
              shapeBorder: const CircleBorder(),
              showcaseBackgroundColor: Colors.indigo,
              descTextStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16,
              ),
              overlayPadding: const EdgeInsets.all(8.0),
              contentPadding: const EdgeInsets.all(16.0),
              child: const Icon(Icons.settings),
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.indigo[400],
        title: const AppBarTitle(),
      ),
      floatingActionButton: Showcase.withWidget(
        key: _key3,
        height: 100,
        width: 100,
        contentPadding: const EdgeInsets.all(16),
        container: CustomContainer(),
        // container: Icon(
        //   Icons.local_drink,
        //   size: 50,
        //   color: Colors.blue,
        // ),
        shapeBorder: CircleBorder(),
        overlayPadding: const EdgeInsets.all(8),
        child: FloatingActionButton(
          onPressed: () {
            
          },
          backgroundColor: Colors.indigo[900],
          child: const Icon(Icons.add),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Showcase(
            key: _key2,
            title: 'Total & Goal Water Intake',
            description: 'Track your total and goal water intake',
            showArrow: false,
            overlayPadding: const EdgeInsets.all(8.0),
            showcaseBackgroundColor: Colors.indigo,
            textColor: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupsNumberDisplay(size: 200),
                const SizedBox(height: 60),
                CupsGoal(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
