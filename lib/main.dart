import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
      home: const TextEditorScreen(
        text: 'Hello world',
        textColor: Colors.blueAccent,
        shadowPercentage: .5,
        shadowColor: Colors.red,
        textFontFamily: 'Roboto',
        textFontWeight: FontWeight.normal,
        textFontSize: 16,
      ),
    );
  }
}

class TextEditorScreen extends StatefulWidget {
  const TextEditorScreen({
    super.key,
    required this.text,
    this.textColor,
    this.shadowColor,
    this.textFontFamily,
    this.textFontWeight,
    this.textFontSize,
    this.shadowPercentage,
  });

  final String text;
  final Color? textColor;
  final Color? shadowColor;
  final String? textFontFamily;
  final FontWeight? textFontWeight;
  final double? textFontSize;
  final double? shadowPercentage;

  @override
  State<TextEditorScreen> createState() => _TextEditorScreenState();
}

class _TextEditorScreenState extends State<TextEditorScreen> with SingleTickerProviderStateMixin {
  static const defaultFontSize = 16.0;
  static const defaultTextColor = Colors.black;
  static const defaultFontFamily = 'Roboto';
  static const defaultFontWeight = FontWeight.normal;

  late Color textColor = widget.textColor ?? defaultTextColor;
  late Color selectedPickerColor = widget.textColor ?? defaultTextColor;
  late Color shadowColor = widget.shadowColor ?? defaultTextColor;
  late double shadowPercentage = widget.shadowPercentage ?? 0;
  late double shadowValue = getShadowValue(shadowPercentage, widget.textFontSize ?? defaultFontSize);

  late String textFontFamily = widget.textFontFamily ?? defaultFontFamily;
  late FontWeight textFontWeight = widget.textFontWeight ?? defaultFontWeight;
  late double textFontSize = widget.textFontSize ?? defaultFontSize;

  late TabController _tabController;
  final List<String> tabTitles = ["Fonts", "Colors", "ShadowPPP"];
  final List<String> fontFamilies = ['Poppins', 'Anton', 'Roboto', 'Lato', 'Raleway'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabTitles.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Text Editor'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Center(
              child: Transform.scale(
                scale: 2,
                child: Text(
                  widget.text,
                  style: TextStyle(
                    color: textColor,
                    fontFamily: textFontFamily,
                    fontWeight: textFontWeight,
                    fontSize: textFontSize,
                    shadows: shadowValue != 0
                        ? [
                            Shadow(
                                // bottomLeft
                                offset: Offset(-shadowValue, -shadowValue),
                                color: shadowColor),
                            Shadow(
                                // bottomRight
                                offset: Offset(shadowValue, -shadowValue),
                                color: shadowColor),
                            Shadow(
                                // topRight
                                offset: Offset(shadowValue, shadowValue),
                                color: shadowColor),
                            Shadow(
                                // topLeft
                                offset: Offset(-shadowValue, shadowValue),
                                color: shadowColor),
                          ]
                        : null,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: TabBar(
                      controller: _tabController,
                      dividerColor: Colors.white,
                      tabs: const [
                        Tab(text: 'Fonts'),
                        Tab(text: 'Colors'),
                        Tab(text: 'Shadow'),
                      ],
                      labelColor: Colors.white,
                      indicatorColor: Colors.white,
                      indicatorWeight: 4.0,
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: [
                        FontTabView(
                          fontFamilies: fontFamilies,
                          family: textFontFamily,
                          onFamilyTap: (String value) {
                            setState(() => textFontFamily = value);
                          },
                          fontSizeMax: 64,
                          fontSizeMin: 12,
                          fontSizeValue: textFontSize,
                          onFontSizeChanged: (double value) {
                            setState(() {
                              textFontSize = value;
                              shadowValue = getShadowValue(shadowPercentage, textFontSize);
                            });
                          },
                        ),
                        ColorsTabView(
                          color: textColor,
                          onColorChanged: (Color value) {
                            setState(() => textColor = value);
                          },
                        ),
                        ShadowTabView(
                          color: shadowColor,
                          shadowPercentageValue: shadowPercentage,
                          onShadowColorChanged: (color) {
                            setState(() => shadowColor = color);
                          },
                          onShadowValueChanged: (double p) {
                            setState(() {
                              shadowPercentage = p;
                              shadowValue = getShadowValue(shadowPercentage, textFontSize);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

double getShadowValue(double p, double textFontSize) {
  return p * textFontSize * .04;
}

class FontTabView extends StatelessWidget {
  const FontTabView({
    super.key,
    required this.fontFamilies,
    required this.family,
    required this.onFamilyTap,
    required this.onFontSizeChanged,
    required this.fontSizeValue,
    required this.fontSizeMax,
    required this.fontSizeMin,
  });

  final List<String> fontFamilies;
  final String family;
  final ValueChanged<String> onFamilyTap;
  final ValueChanged<double> onFontSizeChanged;
  final double fontSizeValue;
  final double fontSizeMax;
  final double fontSizeMin;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: CustomScrollView(
              scrollDirection: Axis.horizontal,
              slivers: [
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final family = fontFamilies[index];
                      return InkWell(
                        onTap: () => onFamilyTap(family),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: this.family == family ? 2 : 1,
                              color: this.family == family ? Colors.blue : Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                Text(
                                  family,
                                  style: TextStyle(
                                    fontFamily: family,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: fontFamilies.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 4,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('Font size', style: TextStyle(color: Colors.white)),
          Row(
            children: [
              Expanded(
                child: Slider(
                  onChanged: onFontSizeChanged,
                  value: fontSizeValue,
                  max: fontSizeMax,
                  min: fontSizeMin,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                fontSizeValue.round().toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ColorsTabView extends StatelessWidget {
  const ColorsTabView({
    super.key,
    required this.color,
    required this.onColorChanged,
  });

  final Color color;
  final ValueChanged<Color> onColorChanged;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ColorPickerRow(
          color: color,
          onColorChanged: onColorChanged,
        ),
      ),
    );
  }
}

class ShadowTabView extends StatelessWidget {
  const ShadowTabView({
    super.key,
    required this.color,
    required this.onShadowColorChanged,
    required this.onShadowValueChanged,
    required this.shadowPercentageValue,
  });

  final Color color;
  final ValueChanged<Color> onShadowColorChanged;
  final ValueChanged<double> onShadowValueChanged;
  final double shadowPercentageValue;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ColorPickerRow(
              color: color,
              onColorChanged: onShadowColorChanged,
            ),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    onChanged: onShadowValueChanged,
                    value: shadowPercentageValue,
                    max: 1,
                    min: 0,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  shadowPercentageValue.toStringAsFixed(1),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ColorPickerRow extends StatefulWidget {
  const ColorPickerRow({
    super.key,
    required this.color,
    required this.onColorChanged,
  });

  final Color color;
  final ValueChanged<Color> onColorChanged;

  @override
  State<ColorPickerRow> createState() => _ColorPickerRowState();
}

class _ColorPickerRowState extends State<ColorPickerRow> {
  late Color selectedPickerColor = widget.color;

  @override
  Widget build(BuildContext context) {
    final color = widget.color;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Builder(
          builder: (context) {
            final r16 = color.red.toRadixString(16).padLeft(2, '0');
            final g16 = color.green.toRadixString(16).padLeft(2, '0');
            final b16 = color.blue.toRadixString(16).padLeft(2, '0');
            return Text(
              '#$r16$g16$b16',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            );
          },
        ),
        const SizedBox(width: 16),
        const Icon(Icons.palette_outlined, color: Colors.white),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Pick a color!'),
                  content: SingleChildScrollView(
                    child: ColorPicker(
                      pickerColor: color,
                      onColorChanged: (color) {
                        selectedPickerColor = color;
                      },
                    ),
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      child: const Text('Valider'),
                      onPressed: () {
                        widget.onColorChanged(selectedPickerColor);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Container(
            width: 90,
            height: 30,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }
}


// picker alternatives
//  child: ColorPicker(
//                       pickerColor: color,
//                       onColorChanged: (color) {
//                         selectedPickerColor = color;
//                       },
//                     ),
// Use Material color picker:
//
// child: MaterialPicker(
//   pickerColor: color,
//   onColorChanged: (color) {
//     selectedPickerColor = color;
//   },
// ),
//
// Use Block color picker:
//
// child: BlockPicker(
//    pickerColor: color,
//   onColorChanged: (color) {
//     selectedPickerColor = color;
//   },
// ),
//