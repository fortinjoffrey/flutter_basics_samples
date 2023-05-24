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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  final int _field1CharactersLimit = 20;
  final int _field2CharactersLimit = 50;
  String _field1Description = '';
  String _field2Description = '';
  bool _isField2Valid = true;
  final GlobalKey<FormFieldState> _formFieldkey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text('Field with maxLength that block typing'),
                  const SizedBox(height: 8),
                  TextFormField(
                    maxLength: _field1CharactersLimit,
                    onChanged: (text) {
                      setState(() {
                        _field1Description = text;
                      });
                    },
                    decoration: InputDecoration(
                      counter: Text(
                        '${_field1Description.characters.length} / $_field1CharactersLimit',
                      ),
                      hintText: 'Description',
                      fillColor: Colors.grey[300],
                      filled: true,
                      focusedBorder: FocusedOutlineInputBorder(),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(width: 0, style: BorderStyle.none),
                        gapPadding: 0,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text('Field with limit that invalidates field'),
                  const SizedBox(height: 8),
                  TextFormField(
                    key: _formFieldkey,
                    validator: (text) {
                      if (text == null || text.isEmpty) return null;

                      if (text.characters.length > _field2CharactersLimit) {
                        return 'Characters limit exceeded';
                      }
                      return null;
                    },
                    onChanged: (text) {
                      if (_formFieldkey.currentState == null) return;
                      final isValid = _formFieldkey.currentState!.validate();

                      setState(() {
                        _isField2Valid = isValid;
                        _field2Description = text;
                      });
                    },
                    maxLines: 3,
                    decoration: InputDecoration(
                      counter: Text(
                        '${_field2Description.characters.length} / $_field2CharactersLimit',
                        style: TextStyle(color: !_isField2Valid ? Colors.red : null),
                      ),
                      hintText: 'Description',
                      fillColor: Colors.grey[300],
                      filled: true,
                      focusedErrorBorder: ErrorOutlineInputBorder(),
                      errorBorder: ErrorOutlineInputBorder(),
                      focusedBorder: FocusedOutlineInputBorder(),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(width: 0, style: BorderStyle.none),
                        gapPadding: 0,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ErrorOutlineInputBorder extends OutlineInputBorder {
  ErrorOutlineInputBorder()
      : super(
          borderSide: BorderSide(width: 1, style: BorderStyle.solid, color: Colors.red),
          gapPadding: 0,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        );
}

class FocusedOutlineInputBorder extends OutlineInputBorder {
  FocusedOutlineInputBorder()
      : super(
          borderSide: BorderSide(width: 1, style: BorderStyle.solid, color: Colors.blue),
          gapPadding: 0,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        );
}
