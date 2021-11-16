import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    Key? key,
    required this.imageBytes,
    required this.title,
    required this.descriptionWidget,
    this.bottomWidget,
  }) : super(key: key);

  final String imageBytes;
  final String title;
  final Widget descriptionWidget;
  final Widget? bottomWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: min(MediaQuery.of(context).size.width, Constants.onboardingMaxWidth),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .5,
                    child: Center(
                      child: SvgPicture.string(imageBytes),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style:
                                Theme.of(context).textTheme.headline4?.copyWith(color: Theme.of(context).primaryColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 35.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 43.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: descriptionWidget,
                        ),
                      ],
                    ),
                  ),
                  if (bottomWidget != null) bottomWidget!,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import 'constants.dart';

// class OnboardingPage extends StatelessWidget {
//   const OnboardingPage({
//     Key? key,
//     required this.imagePath,
//     required this.title,
//     required this.descriptionWidget,
//     this.bottomWidget,
//   }) : super(key: key);

//   final String imagePath;
//   final String title;
//   final Widget descriptionWidget;
//   final Widget? bottomWidget;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 16.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: min(MediaQuery.of(context).size.width, Constants.onboardingMaxWidth),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * .5,
//                     child: Center(
//                       child: SvgPicture.asset(imagePath),
//                     ),
//                   ),
//                   SizedBox(height: 30.0),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           child: Text(
//                             title,
//                             style: Theme.of(context).textTheme.headline4,
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 35.0),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 43.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           child: descriptionWidget,
//                         ),
//                       ],
//                     ),
//                   ),
//                   if (bottomWidget != null) bottomWidget!,
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
