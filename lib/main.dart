import 'dart:convert';

import 'package:basics_samples/components/reconstruct_widget/reconstruct_widget.dart';
import 'package:basics_samples/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/reconstruct_widget/reconstruct_widget_cubit.dart';

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey textKey = GlobalKey();
  final GlobalKey containerKey = GlobalKey();
  Map<String, dynamic>? _positionInfoJson;
  double _currentSliderTextFieldLeftValue = 20;
  double _currentSliderTextFieldTopValue = 20;
  double _currentSliderTextLeftValue = 20;
  double _currentSliderTextTopValue = 20;
  static const String textLabel = "My text";
  static const double textFontSize = 18;
  bool configureTextPosition = true;
  bool configureTextFieldPosition = false;

  @override
  Widget build(BuildContext context) {
    final aspectRatio = 4 / 3;
    final containerWidthProportion = .8;
    final containerWidth = MediaQuery.of(context).size.width * containerWidthProportion;
    final containerHeight = containerWidth / aspectRatio;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Widgets to JSON to widgets'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: MediaQuery(
                  data: const MediaQueryData(textScaleFactor: 1.0),
                  child: Builder(builder: (context) {
                    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
                    print(textScaleFactor);
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          key: containerKey,
                          color: Colors.red,
                          height: containerHeight,
                          width: containerWidth,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: _currentSliderTextFieldTopValue,
                              left: _currentSliderTextFieldLeftValue,
                            ),
                            // child: const TextField(
                            // ),
                          ),
                        ),
                        // Container(
                        //   width: 1,
                        //   height: containerHeight,
                        //   color: Colors.green,
                        // ),
                        // Container(
                        //   width: containerWidth,
                        //   height: 1,
                        //   color: Colors.green,
                        // ),
                        Positioned(
                          top: _currentSliderTextTopValue,
                          left: _currentSliderTextLeftValue,
                          child: Text(
                            textLabel,
                            key: textKey,
                            style: TextStyle(
                              fontSize: textFontSize / MediaQuery.of(context).textScaleFactor,
                            ),
                          ),
                        ),
                        // Positioned(
                        //   top: _currentSliderTextFieldTopValue,
                        //   left: _currentSliderTextFieldLeftValue,
                        //   child: SizedBox(
                        //     height: 40,
                        //     width: 40,
                        //     child: TextFormField(
                        //       initialValue: 'TTOO',
                        //     ),
                        //   ),
                        // ),
                        // Positioned(
                        //   top: _currentSliderTextFieldTopValue,
                        //   left: _currentSliderTextFieldLeftValue,
                        //   child: SizedBox(
                        //     height: 40,
                        //     width: 40,
                        //     child: TextFormField(
                        //       initialValue: 'TTOO',
                        //     ),
                        //   ),
                        // ),
                        // Align(
                        //   alignment: Alignment.center,
                        //   child: Text(
                        //     textLabel,
                        //     key: textKey,
                        //     style: TextStyle(
                        //       fontSize: textFontSize / MediaQuery.of(context).textScaleFactor,
                        //     ),
                        //   ),
                        // ),
                        // Align(
                        //   alignment: Alignment.center,
                        //   child: TextFormField(),
                        // ),
                      ],
                    );
                  }),
                ),
              ),
              // TextFormField(),
              // if (configureTextFieldPosition) ...[
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       const Text('Configure TextField position'),
              //     ],
              //   ),
              //   Row(
              //     children: [
              //       Expanded(child: Text('Left value: ${_currentSliderTextFieldLeftValue.round()}')),
              //       Expanded(
              //         flex: 3,
              //         child: Slider(
              //           value: _currentSliderTextFieldLeftValue,
              //           max: containerWidth,
              //           divisions: containerWidth.toInt(),
              //           label: 'left: ${_currentSliderTextFieldLeftValue.round().toString()}',
              //           onChanged: (double value) {
              //             setState(() {
              //               _currentSliderTextFieldLeftValue = value;
              //             });
              //             WidgetsBinding.instance.addPostFrameCallback((_) {
              //               setState(() {
              //                 _positionInfoJson = getWidgetsInformationMap(
              //                   containerAspectRatio: aspectRatio,
              //                   containerKey: containerKey,
              //                   containerWidthProportion: containerWidthProportion,
              //                   textKey: textKey,
              //                 );
              //               });
              //             });
              //           },
              //         ),
              //       ),
              //     ],
              //   ),
              //   Row(
              //     children: [
              //       Expanded(child: Text('Top value: ${_currentSliderTextFieldTopValue.round()}')),
              //       Expanded(
              //         flex: 3,
              //         child: Slider(
              //           value: _currentSliderTextFieldTopValue,
              //           max: containerHeight,
              //           divisions: containerHeight.toInt(),
              //           label: 'top: ${_currentSliderTextFieldTopValue.round().toString()}',
              //           onChanged: (double value) {
              //             setState(() {
              //               _currentSliderTextFieldTopValue = value;
              //             });
              //             WidgetsBinding.instance.addPostFrameCallback((_) {
              //               setState(() {
              //                 _positionInfoJson = getWidgetsInformationMap(
              //                   containerAspectRatio: aspectRatio,
              //                   containerKey: containerKey,
              //                   containerWidthProportion: containerWidthProportion,
              //                   textKey: textKey,
              //                 );
              //               });
              //             });
              //           },
              //         ),
              //       ),
              //     ],
              //   ),
              // ],
              if (configureTextPosition) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Configure MyText position',
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: Text('Left value: ${_currentSliderTextLeftValue.round()}')),
                    Expanded(
                      flex: 3,
                      child: Slider(
                        value: _currentSliderTextLeftValue,
                        max: containerWidth,
                        divisions: containerWidth.toInt(),
                        label: 'left: ${_currentSliderTextLeftValue.round().toString()}',
                        onChanged: (double value) {
                          setState(() {
                            _currentSliderTextLeftValue = value;
                          });
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            setState(() {
                              _positionInfoJson = getWidgetsInformationMap(
                                containerAspectRatio: aspectRatio,
                                containerKey: containerKey,
                                containerWidthProportion: containerWidthProportion,
                                textKey: textKey,
                              );
                            });
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: Text('Top value: ${_currentSliderTextTopValue.round()}')),
                    Expanded(
                      flex: 3,
                      child: Slider(
                        value: _currentSliderTextTopValue,
                        max: containerHeight,
                        divisions: containerHeight.toInt(),
                        label: 'top: ${_currentSliderTextTopValue.round().toString()}',
                        onChanged: (double value) {
                          setState(() {
                            _currentSliderTextTopValue = value;
                          });
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            setState(() {
                              _positionInfoJson = getWidgetsInformationMap(
                                containerAspectRatio: aspectRatio,
                                containerKey: containerKey,
                                containerWidthProportion: containerWidthProportion,
                                textKey: textKey,
                              );
                            });
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
              const Divider(),
              if (_positionInfoJson != null) Text(jsonEncode(_positionInfoJson!)),
              const Divider(),
              if (_positionInfoJson != null) ...[
                const SizedBox(height: 8),
                BlocProvider<ReconstructWidgetCubit>(
                  create: (context) => ReconstructWidgetCubit(_positionInfoJson!)..init(),
                  child: ReconstructWidget(
                    json: _positionInfoJson!,
                  ),
                )
              ]
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _positionInfoJson = getWidgetsInformationMap(
              containerAspectRatio: aspectRatio,
              containerKey: containerKey,
              containerWidthProportion: containerWidthProportion,
              textKey: textKey,
            );
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Map<String, dynamic> getWidgetsInformationMap({
    required GlobalKey containerKey,
    required double containerAspectRatio,
    required double containerWidthProportion,
    required GlobalKey textKey,
  }) {
    final Offset containerPosition = _getWidgetPosition(containerKey);
    final Size containerSize = _getWidgetSize(containerKey);
    final Offset textPosition = _getWidgetPosition(textKey);
    final Size textSize = _getWidgetSize(textKey);

    final textXStartInContainer = textPosition.dx - containerPosition.dx;
    final textXEndInContainer = textXStartInContainer + textSize.width;
    final textXCenter = (textXStartInContainer + textXEndInContainer) / 2;
    final containerXend = containerSize.width;
    final textXProportion = (textXCenter / containerXend);

    final textYStartInContainer = textPosition.dy - containerPosition.dy;
    final textYEndInContainer = textYStartInContainer + textSize.height;
    final textYCenter = (textYStartInContainer + textYEndInContainer) / 2;
    final containerYend = containerSize.height;
    final textYProportion = (textYCenter / containerYend);
    // convert information from keys to dart object
    // then create a toJson in this object to convert to JSON
    final textProportion = OffsetProportion(x: textXProportion, y: textYProportion);
    final textInformation = TextInformation(
      text: textLabel,
      proportion: textProportion,
      fontSize: textFontSize,
    );

    final positionInfo = PositionInformation(
      textInformation: textInformation,
      containerInformation: ContainerInformation(
        aspectRatio: containerAspectRatio,
        widthProportion: containerWidthProportion,
      ),
    );

    return positionInfo.toMap();
  }

  Offset _getWidgetPosition(GlobalKey key) {
    final RenderBox renderBox = key.currentContext?.findRenderObject() as RenderBox;
    return renderBox.localToGlobal(Offset.zero);
  }

  Size _getWidgetSize(GlobalKey key) {
    final RenderBox renderBox = key.currentContext?.findRenderObject() as RenderBox;
    return renderBox.size;
  }
}
