// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
//   Color color = Colors.black;

//   late TabController _tabController;
//   List<String> tabTitles = ["Fonts", "Colors", "ShadowPPP"];

//   int indicatorPosition = 0; // Position de l'indicateur

//   late double fontsTabWidth;
//   late double colorsTabWidth;
//   late double shadowTabWidth;

//   late List<double> tabWidths;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: tabTitles.length, vsync: this);
//     _tabController.addListener(_handleTabChange);

//     fontsTabWidth = tabWidthForText('Fonts') + 3*8+4;
//     colorsTabWidth = tabWidthForText('Colors')  + 3*8+4;
//     shadowTabWidth = tabWidthForText('ShadowPPP')  + 3*8+4;

//     tabWidths = [fontsTabWidth, colorsTabWidth, shadowTabWidth];
//   }

//   double tabWidthForText(String tabTitle) {
//     final textPainter = TextPainter(
//       text: TextSpan(
//         text: tabTitle,
//         style: const TextStyle(fontSize: 16.0),
//       ),
//       textDirection: TextDirection.ltr,
//     )
//       ..layout()
//       ..size.width;
//     return textPainter.size.width;
//   }

//   void _handleTabChange() {
//     setState(() {
//       indicatorPosition = _tabController.index;
//     });
//   }

//   @override
//   void dispose() {
//     _tabController.removeListener(_handleTabChange);
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         // crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//           Expanded(
//             child: Center(
//               child: Text(
//                 'I love you',
//                 // font family poppins
//                 style: TextStyle(
//                   color: color,
//                   fontFamily: 'Anton',
//                   // fontFamily: 'Poppins',
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Container(
//               color: Colors.green,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TabBar(
//                       controller: _tabController,
//                       dividerColor: Colors.red,
//                       // color: Colors.blue,
//                       isScrollable: true,
//                       tabs: const [
//                         Tab(text: 'Fonts'),
//                         Tab(text: 'Colors'),
//                         Tab(text: 'Shaokokdow'),
//                       ],
//                       indicatorColor: Colors.red, // Couleur de l'indicateur
//                       indicatorWeight: 2.0, // Largeur de l'indicateur
//                     ),
//                   ),
//                   Container(
//                     height: 48.0, // Hauteur des onglets
//                     child: ListView.builder(
//                       itemCount: tabTitles.length,
//                       scrollDirection: Axis.horizontal,
//                       itemBuilder: (context, index) {
//                         return GestureDetector(
//                           onTap: () {
//                             _tabController.animateTo(index);
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                             alignment: Alignment.center,
//                             child: Text(
//                               tabTitles[index],
//                               style: const TextStyle(fontSize: 16.0), // Taille de la police
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   Container(
//                     // width: 5,
//                     height: 5,
//                     color: Colors.red,
//                     alignment: Alignment(indicatorPosition.toDouble(), 1.0),
//                     width: MediaQuery.of(context).size.width / tabTitles.length,
//                   ),
//                   SizedBox(
//                     height: 5,
//                     child: Stack(
//                       children: [
//                         Builder(builder: (context) {
//                           double sommeJusquaIndex(int index, List<double> liste) {
//                             return liste.sublist(0, index).fold(0, (a, b) => a + b);
//                           }

//                           final offset = sommeJusquaIndex(indicatorPosition, tabWidths);

//                           return AnimatedPositioned(
//                             child: Container(
//                               color: Colors.blue,
//                               width: tabWidths[_tabController.index],
//                               height: 5,
//                             ),
//                             left: offset,
//                             duration: const Duration(milliseconds: 300),
//                           );
//                         }),
//                       ],
//                     ),
//                   ),
//                   AnimatedContainer(
//                     duration: const Duration(milliseconds: 300), // Durée de l'animation
//                     child: Padding(
//                       padding: EdgeInsets.only(left: indicatorPosition * 8.0),
//                       child: Container(
//                         // padding: const EdgeInsets.only(top: 60),
//                         width: tabWidths[_tabController.index],
//                         // width: MediaQuery.of(context).size.width / tabTitles.length,
//                         height: 3.0, // Hauteur de l'indicateur
//                         color: Colors.white, // Couleur de l'indicateur
//                       ),
//                     ),
//                   ),
//                   // AnimatedContainer(
//                   //   duration: const Duration(milliseconds: 300), // Durée de l'animation
//                   //   alignment: Alignment(indicatorPosition, 1.0),
//                   //   child: Container(
//                   //     width: MediaQuery.of(context).size.width / tabTitles.length,
//                   //     height: 3.0, // Hauteur de l'indicateur
//                   //     color: Colors.white, // Couleur de l'indicateur
//                   //   ),
//                   // ),
//                   // TabBar(
//                   //   controller: _tabController,
//                   //   tabs: const [
//                   //     Tab(text: 'Fonts'),
//                   //     Tab(text: 'Colors'),
//                   //     Tab(text: 'Shadow'),
//                   //   ],
//                   //   indicatorColor: Colors.white, // Couleur de l'indicateur
//                   //   indicatorWeight: 3.0, // Largeur de l'indicateur
//                   // ),
//                   Expanded(
//                     child: TabBarView(
//                       controller: _tabController,
//                       children: const [
//                         Center(
//                           child: Text('Content for Fonts tab'),
//                         ),
//                         Center(
//                           child: Text('Content for Colors tab'),
//                         ),
//                         Center(
//                           child: Text('Content for Shadow tab'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
