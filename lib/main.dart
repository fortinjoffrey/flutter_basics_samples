import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

enum _PhoneNumberContainerState {
  enabled,
  focused,
  error,
  focusedError,
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FocusNode _focus = FocusNode();

  final TextEditingController controller = TextEditingController();
  PhoneNumber number = PhoneNumber(isoCode: 'FR');
  _PhoneNumberContainerState containerState = _PhoneNumberContainerState.enabled;

  final _phoneTextFieldKey = GlobalKey<FormFieldState<String>>();
  final _nameTextFieldKey = GlobalKey<FormFieldState<String>>();
  bool phoneNumberValid = false;

  @override
  void initState() {
    super.initState();
    _focus.addListener(() {
      if (_focus.hasFocus) {
        setState(() {
          containerState = _PhoneNumberContainerState.focused;
        });
      } else {
        setState(() {
          containerState = _PhoneNumberContainerState.enabled;
        });
      }
    });
  }

  @override
  void dispose() {
    _focus.dispose();
    controller.dispose();
    super.dispose();
  }

  BoxDecoration get boxDecorationFromState {
    switch (containerState) {
      case _PhoneNumberContainerState.focused:
        return BoxDecoration(
          border: Border.all(
            width: 1,
            style: BorderStyle.solid,
            color: Colors.yellow,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        );
      case _PhoneNumberContainerState.enabled:
        return BoxDecoration(
          border: Border.all(
            width: 1,
            style: BorderStyle.solid,
            color: Theme.of(context).colorScheme.primary,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        );
      case _PhoneNumberContainerState.focusedError:
      case _PhoneNumberContainerState.error:
        return BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(
            width: 1,
            style: BorderStyle.solid,
            color: Theme.of(context).colorScheme.error,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Form(
        // key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextFormField(
                
                key: _nameTextFieldKey,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                  
                  labelStyle: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                ),
                validator: (value) => 'error',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Container(
                    decoration: boxDecorationFromState,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: InternationalPhoneNumberInput(
                        fieldKey: _phoneTextFieldKey,
                        focusNode: _focus,
                        spaceBetweenSelectorAndTextField: 0,
                        // locale: 'FR',
                        onInputChanged: (PhoneNumber number) {
                          print(number.phoneNumber);
                        },
                        onInputValidated: (bool value) {
                          setState(() => phoneNumberValid = value);
                          print(value);
                        },
                        selectorTextStyle: const TextStyle(color: Colors.black),
                        inputDecoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(32)),
                              borderSide: BorderSide(style: BorderStyle.none)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(2)),
                              borderSide: BorderSide(style: BorderStyle.none)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(32)),
                              borderSide: BorderSide(style: BorderStyle.none)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(32)),
                              borderSide: BorderSide(style: BorderStyle.none)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(32)),
                              borderSide: BorderSide(color: Colors.green, style: BorderStyle.none)),
                          labelText: null,
                          prefixIcon: null,
                          hintText: 'Enter',
                        ),

                        searchBoxDecoration: const InputDecoration(
                          hintText: 'Toti',
                          // border: OutlineInputBorder(),
                        ),
                        selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        ),
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.disabled,
                        initialValue: number,
                        textFieldController: controller,
                        formatInput: true,
                        keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                        inputBorder: const OutlineInputBorder(),
                        onSaved: (PhoneNumber number) {
                          print('On Saved: $number');
                        },
                      ),
                    ),
                  ),
                  if (!phoneNumberValid) const Text('Phone number invalid'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _nameTextFieldKey.currentState?.validate();
                // formKey.currentState?.validate();
                // if (_phoneTextFieldKey.currentState?.validate() == true) {
                //   print('valide');
                // } else {
                //   print('non valide');
                // }
              },
              child: const Text('Validate'),
            ),
            ElevatedButton(
              onPressed: () {
                getPhoneNumber('+15417543010');
              },
              child: const Text('Update'),
            ),
            ElevatedButton(
              onPressed: () {
                formKey.currentState?.save();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number = await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

    setState(() {
      this.number = number;
    });
  }
}
