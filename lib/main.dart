import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/my_dropdown_menu.dart';

// Flutter code sample for [DropdownMenu]s. The first dropdown menu
// has the default outlined border and demos using the
// [MyDropdownMenuEntry] style parameter to customize its appearance.
// The second dropdown menu customizes the appearance of the dropdown
// menu's text field with its [InputDecorationTheme] parameter.

void main() {
  runApp(const DropdownMenuExample());
}

// MyDropdownMenuEntry labels and values for the first dropdown menu.
enum ColorLabel {
  blue('Blue', Colors.blue),
  pink('Pink', Colors.pink),
  green('Green', Colors.green),
  yellow('Orange', Colors.orange),
  grey('Grey', Colors.grey);

  const ColorLabel(this.label, this.color);
  final String label;
  final Color color;
}

// MyDropdownMenuEntry labels and values for the second dropdown menu.
enum IconLabel {
  smile('Smile', Icons.sentiment_satisfied_outlined),
  cloud(
    'Cloud',
    Icons.cloud_outlined,
  ),
  brush('Brush', Icons.brush_outlined),
  heart('Heart', Icons.favorite);

  const IconLabel(this.label, this.icon);
  final String label;
  final IconData icon;
}

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  final TextEditingController colorController = TextEditingController();
  final TextEditingController iconController = TextEditingController();
  ColorLabel? selectedColor;
  IconLabel? selectedIcon;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
      ),
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Dummy'),
                    MyDropdownMenu<ColorLabel>(
                      // width: 30
                      enableSearch: false,
                      initialSelection: ColorLabel.green,
                      controller: colorController,
                      // requestFocusOnTap is enabled/disabled by platforms when it is null.
                      // On mobile platforms, this is false by default. Setting this to true will
                      // trigger focus request on the text field and virtual keyboard will appear
                      // afterward. On desktop platforms however, this defaults to true.
                      requestFocusOnTap: false,
                      label: const Text('Color'),
                      onSelected: (ColorLabel? color) {
                        setState(() {
                          selectedColor = color;
                        });
                      },
                      dropdownMenuEntries: ColorLabel.values
                          .map<MyDropdownMenuEntry<ColorLabel>>(
                              (ColorLabel color) {
                        return MyDropdownMenuEntry<ColorLabel>(
                          value: color,
                          label: color.label,
                          enabled: color.label != 'Grey',
                          style: MenuItemButton.styleFrom(
                            foregroundColor: color.color,
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(width: 24),
                    MyDropdownMenu<IconLabel>(
                      controller: iconController,
                      enableFilter: true,
                      requestFocusOnTap: true,
                      leadingIcon: const Icon(Icons.search),
                      label: const Text('Icon'),
                      inputDecorationTheme: const InputDecorationTheme(
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                      ),
                      onSelected: (IconLabel? icon) {
                        setState(() {
                          selectedIcon = icon;
                        });
                      },
                      dropdownMenuEntries:
                          IconLabel.values.map<MyDropdownMenuEntry<IconLabel>>(
                        (IconLabel icon) {
                          return MyDropdownMenuEntry<IconLabel>(
                            value: icon,
                            label: icon.label,
                            leadingIcon: Icon(icon.icon),
                          );
                        },
                      ).toList(),
                    ),
                  ],
                ),
              ),
              if (selectedColor != null && selectedIcon != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        'You selected a ${selectedColor?.label} ${selectedIcon?.label}'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Icon(
                        selectedIcon?.icon,
                        color: selectedColor?.color,
                      ),
                    )
                  ],
                )
              else
                const Text('Please select a color and an icon.')
            ],
          ),
        ),
      ),
    );
  }
}
