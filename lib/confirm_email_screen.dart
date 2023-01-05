import 'package:basics_samples/confirm_field/confirm_field_form.dart';
import 'package:basics_samples/validators/email_validator.dart';
import 'package:basics_samples/validators/password_validator.dart';
import 'package:basics_samples/validators/username_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfirmEmailScreen extends StatefulWidget {
  const ConfirmEmailScreen({super.key});

  @override
  State<ConfirmEmailScreen> createState() => _ConfirmEmailScreenState();
}

class _ConfirmEmailScreenState extends State<ConfirmEmailScreen> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm email screen'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          // child: Column(
          //   children: [
          //     Provider(
          //       // create: (context) => '1',
          //       // child: Builder(
          //       //   builder: (context) {
          //       //     return Text(context.read<String>());
          //       //   }
          //       // ),
          //       create: (context) => Wrapper('3'),
          //       child: Builder(
          //         builder: (context) {
          //           return Text(context.read<Wrapper<String>>().data);
          //         }
          //       ),
          //     ),
          //     Provider(
          //       // create: (context) => '1',
          //       // child: Builder(
          //       //   builder: (context) {
          //       //     return Text(context.read<String>());
          //       //   }
          //       // ),
          //       create: (context) => Wrapper('2'),
          //       child: Builder(
          //         builder: (context) {
          //           return Text(context.read<Wrapper<String>>().data);
          //         }
          //       ),
          //     ),
          //   ],
          // ),;;
          child: Column(
            children: [
              Text(counter.toString()),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      counter++;
                    });
                  },
                  child: const Text('Increment')),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      counter--;
                    });
                  },
                  child: const Text('Decrement')),

              // ConfirmFieldForm<int>(
              //   label: 'Username',
              //   fieldValidatorExtra: (value, length) => validateUsername(value, length),
              //   extra: counter,
              // ),
              ConfirmFieldFormWrapper<int>(
                label: 'Username',
                fieldValidatorExtra: (value, length) => validateUsername(value, length),
                extra: counter,
              ),
              // ConfirmFieldForm<int>(
              //   label: 'E-mail',
              //   fieldValidatorExtra: (value, length) => validateEmail(value, length),
              //   // fieldValidatorExtra: (value, length) => validateEmail(value, length),
              //   extra: 9,
              // ),
              // ConfirmFieldForm(
              //   label: 'Password',
              //   fieldValidator: (value) => validatePassword(value),
              // ),
              // ConfirmFieldForm<void>(label: 'Passowrd', fieldValidator: validatePassword)
            ],
          ),
        ),
      ),
    );
  }
}
