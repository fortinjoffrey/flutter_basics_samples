import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  double netImposableApresAbattement(double ca) => ca * 0.66;

  double? netImposable;
  TextEditingController netImposableController = TextEditingController();
  GlobalKey<FormFieldState> caKey = GlobalKey<FormFieldState>();
  (double, List<double>)? impotsResults;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 32),
                  ...[
                    const Text('Montant du CA'),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        key: caKey,
                        validator: (value) {
                          const errMsg = 'Veuillez entrer un nombre valide';
                          if (value == null || value.isEmpty) {
                            return errMsg;
                          }
                          final parsedNumber = int.tryParse(value);

                          if (parsedNumber == null) {
                            return errMsg;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Montant CA',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onChanged: (value) {
                          if (caKey.currentState?.validate() == true) {
                            final parsedNumber = double.tryParse(value);
                            if (parsedNumber == null) return;

                            setState(() {
                              netImposable = netImposableApresAbattement(parsedNumber);

                              final content = netImposable.toString();
                              netImposableController.text = content;
                              netImposableController.selection = TextSelection(
                                baseOffset: content.length,
                                extentOffset: content.length,
                              );
                              impotsResults = calculateNetAPayer(netImposable!);
                            });
                          }
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                  ...[
                    const Text('NET imposable après abattement forfaitaire'),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: netImposableController,
                        decoration: InputDecoration(
                          hintText: 'NET imposable',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onChanged: (value) {
                          if (caKey.currentState?.validate() == true) {
                            final parsedNumber = double.tryParse(value);
                            if (parsedNumber == null) return;

                            setState(() {
                              final netImposable = this.netImposable;
                              if (netImposable == null) return;
                              impotsResults = calculateNetAPayer(netImposable);
                            });
                          }
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.cyan.withOpacity(.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: rates.mapIndexed((index, rate) {
                            final bool firstIndex = index == 0;
                            final bool lastIndex = index == rates.length - 1;

                            final min = rate.incomeRange.$1.toInt();
                            final max = rate.incomeRange.$2.toInt();
                            final percent = rate.percent * 100;

                            final text = firstIndex
                                ? 'Jusqu\'à $max'
                                : lastIndex
                                    ? 'Au delà de $min'
                                    : 'De $min à $max';

                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(text),
                                  ),
                                  Expanded(child: Text('$percent %')),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  if (impotsResults != null) ...[
                    Row(
                      children: [
                        Text(
                          'Net à payer: ${impotsResults?.$1.toStringAsFixed(2)} €',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Détails par tranche:',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    ...impotsResults!.$2.mapIndexed((index, importParTranche) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(rates[index].incomeRange.toString()),
                            ),
                            Expanded(child: Text('${importParTranche.toStringAsFixed(2)} €')),
                          ],
                        ),
                      );
                    }),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

(double, List<double>) calculateNetAPayer(double netImposable) {
  double resteImposable = netImposable;
  List<double> impotsParTranche = [];

  int index = 0;

  for (final rate in rates) {
    double rateMontantImposable;
    if (index == rates.length - 1) {
      rateMontantImposable = resteImposable - rate.incomeRange.$1;
    } else {
      final bool myLastRate = resteImposable <= rate.incomeRange.$2;
      if (myLastRate) {
        rateMontantImposable = resteImposable;
      } else {
        rateMontantImposable = (rate.incomeRange.$2 - rate.incomeRange.$1).toDouble();
      }
    }

    final impotParTranche = rateMontantImposable * rate.percent;
    impotsParTranche.add(impotParTranche);

    resteImposable -= rateMontantImposable;

    if (resteImposable <= 0) {
      return (impotsParTranche.reduce((value, element) => value + element), impotsParTranche);
    }

    index++;
  }
  return (impotsParTranche.reduce((value, element) => value + element), impotsParTranche);
}

class TaxIncomeRate {
  final (int, int) incomeRange;
  final double percent;

  const TaxIncomeRate({required this.incomeRange, required this.percent});
}

const List<TaxIncomeRate> rates = [
  TaxIncomeRate(incomeRange: (0, 10777), percent: .0),
  TaxIncomeRate(incomeRange: (10778, 27478), percent: .11),
  TaxIncomeRate(incomeRange: (27479, 78570), percent: .30),
  TaxIncomeRate(incomeRange: (78571, 168994), percent: .41),
  TaxIncomeRate(incomeRange: (168994, 99999999), percent: .45),
];
