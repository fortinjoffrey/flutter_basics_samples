import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Bottom TextField above Keyboard'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final bottomColumnFieldKey = GlobalKey();
  bool resizeImageOnKeyboardAppears = true;
  double? initExpandedHeight;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    print(MediaQuery.of(context).viewInsets.bottom);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Align(child: Text(widget.title)),
        ),
        body: Container(
          color: Colors.black,
          child: Column(
            children: <Widget>[
              if (resizeImageOnKeyboardAppears)
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage('https://pbs.twimg.com/media/FKNlhKZUcAEd7FY?format=jpg&name=4096x4096'),
                        fit: BoxFit.fitHeight),
                    color: Colors.green,
                  ),
                  child: Center(
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 20,
                          left: 20,
                          child: Container(
                            height: 10,
                            width: 10,
                            color: Colors.red,
                          ),
                        ),
                        Positioned(
                          bottom: 30,
                          left: 30,
                          child: Container(
                            height: 10,
                            width: 10,
                            color: Colors.red,
                          ),
                        ),
                        Align(alignment: Alignment.topCenter, child: Text('foo')),
                        Align(
                            alignment: Alignment.center,
                            child: Text(
                              'STACK',
                              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                            )),
                        Align(alignment: Alignment.bottomCenter, child: Text('bar')),
                      ],
                    ),
                  ),
                ))
              else
                Expanded(
                  child: LayoutBuilder(builder: (context, constraints) {
                    initExpandedHeight ??= constraints.maxHeight;
                    return OverflowBox(
                      alignment: Alignment.topCenter,
                      maxHeight: double.infinity,
                      minHeight: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  NetworkImage('https://pbs.twimg.com/media/FKNlhKZUcAEd7FY?format=jpg&name=4096x4096'),
                              fit: BoxFit.fitHeight),
                          color: Colors.green,
                        ),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: initExpandedHeight!),
                          // height: initExpandedHeight,
                          child: Center(
                              child: Text(
                            'OverflowBox',
                            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                          )),
                        ),
                      ),
                    );
                  }),
                ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                padding: const EdgeInsets.all(8.0),
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        scrollPadding: EdgeInsets.only(bottom: 100),
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Your name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        height: MediaQuery.of(context).viewInsets.bottom == 0 ? 50 : 0,
                        color: Colors.yellow,
                        duration: const Duration(milliseconds: 100),
                        child: Center(
                          child: const Text('SECTION TO REMOVE ON KEYBOARD APPEARS'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
