import 'dart:math';

import '../constants.dart';
import 'images/indexes.dart';
import 'package:flutter/material.dart';

import 'onboarding_page.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late List<OnboardingPage> _pages;
  final _pageController = PageController();
  int _currentPage = 0;
  late int _nbPages;

  @override
  void initState() {
    super.initState();
    const textAlign = TextAlign.center;

    _pages = const [
      OnboardingPage(
        imageBytes: slide1,
        title: 'Aute irure ad laborum reprehenderit',
        descriptionWidget: Text(
          'Id ullamco id minim id velit nulla aliqua anim sint do nulla cupidatat ea adipisicing. Culpa eu eu reprehenderit consequat ad magna. Proident mollit culpa velit non. Nulla exercitation labore laborum commodo Lorem ut sit esse officia.',
          textAlign: textAlign,
        ),
      ),
      OnboardingPage(
        imageBytes: slide2,
        title: 'Laboris est veniam enim tempor ex',
        descriptionWidget: Text(
          'Ea qui sunt duis est pariatur sunt magna. Irure duis exercitation cupidatat reprehenderit occaecat consectetur laboris non minim esse eu anim. Officia consectetur velit quis incididunt qui incididunt nulla consequat labore. Ut labore anim mollit ipsum do sit qui consequat ut veniam. Nostrud eu amet nostrud sint commodo dolore anim dolore Lorem. Elit aliquip tempor ut ipsum nisi eu id.',
          textAlign: textAlign,
        ),
      ),
      OnboardingPage(
        imageBytes: slide3,
        title: 'Nisi enim ex excepteur nulla',
        descriptionWidget: Text(
          'Cupidatat aute nisi cupidatat voluptate pariatur adipisicing nulla labore velit. Officia enim commodo dolore aute mollit Lorem consectetur. Irure velit do eu adipisicing Lorem irure commodo in.',
          textAlign: textAlign,
        ),
      ),
    ];
    _nbPages = _pages.length;
  }

  Widget _buildIndicators() {
    final List<Widget> list = [];
    for (int i = 0; i < _nbPages; i++) {
      list.add(i == _currentPage ? _buildIndicator(true) : _buildIndicator(false));
    }
    return Wrap(children: list);
  }

  Widget _buildIndicator(bool isActive) {
    const width = 8.0;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: width,
      width: isActive ? 24.0 : width,
      decoration: BoxDecoration(
        color: isActive ? Theme.of(context).primaryColor : Theme.of(context).primaryColor.withAlpha(80),
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // forbid android back button and ios back swipe gesture
      onWillPop: () async => false,
      child: Container(
        padding: EdgeInsets.only(
          top: MediaQueryData.fromWindow(WidgetsBinding.instance!.window).padding.top,
        ),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const ClampingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (_, index) => _pages[index],
                itemCount: _pages.length,
              ),
            ),
            _buildBottomControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomControls() {
    final rightControlsStyle = Theme.of(context).textTheme.bodyText2?.copyWith(
          color: Theme.of(context).primaryColor,
          fontSize: 18.0,
        );
    final isLastPage = _currentPage == (_nbPages - 1);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        width: min(MediaQuery.of(context).size.width, Constants.onboardingMaxWidth),
        child: Row(
          children: [
            Expanded(
              child: !isLastPage ? _buildSkipButton() : const SizedBox.shrink(),
            ),
            _buildIndicators(),
            Expanded(
              child:
                  !isLastPage ? _buildNextPageButton(rightControlsStyle) : _buildGetStartedButton(rightControlsStyle),
            ),
          ],
        ),
      ),
    );
  }

  Align _buildNextPageButton(TextStyle? style) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        },
        child: Text('Next', style: style),
      ),
    );
  }

  Align _buildGetStartedButton(TextStyle? style) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(
          'Get started',
          style: style,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Align _buildSkipButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(
          'Skip',
          style: Theme.of(context).textTheme.bodyText2,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

// import 'dart:math';

// import 'package:basics_samples/onboarding_page.dart';
// import 'package:basics_samples/styled_placeholder_rich_text.dart';
// import 'package:flutter/material.dart';

// import 'constants.dart';

// class OnboardingView extends StatefulWidget {
//   const OnboardingView({Key? key}) : super(key: key);

//   @override
//   State<OnboardingView> createState() => _OnboardingViewState();
// }

// class _OnboardingViewState extends State<OnboardingView> {
//   late List<OnboardingPage> _pages;
//   late int _nbPages;
//   int _currentPage = 0;
//   final _pageController = PageController();
//   static const _mainColor = Color(0xFFF65B0C);
//   static const _secondaryColor = Color(0xFF7F8B8C);
//   static final _lightMainColor = _mainColor.withAlpha(80);
//   static final _boldPlaceholder = StyledPlaceholder(
//     'bold',
//     (text, defaultStyle) => TextSpan(
//       text: text,
//       style: defaultStyle.copyWith(fontWeight: FontWeight.w600),
//     ),
//   );

//   @override
//   void initState() {
//     super.initState();
//     _pages = [
//       OnboardingPage(
//         imagePath: 'assets/images/onboarding-slides_1.svg',
//         title: 'Bienvenue sur Coffreo',
//         descriptionWidget: StyledPlaceholderRichText(
//           text: 'Votre application {bold:privilégiée} pour interagir {bold:avec votre employeur}.',
//           placeholders: [_boldPlaceholder],
//           textAlign: TextAlign.center,
//         ),
//       ),
//       OnboardingPage(
//         imagePath: 'assets/images/onboarding-slides_2.svg',
//         title: 'Signez vos contrats',
//         descriptionWidget: StyledPlaceholderRichText(
//           text: 'Retrouvez tous vos contrats en attente de signature et {bold:signez-les en toute sécurité}.',
//           placeholders: [_boldPlaceholder],
//           textAlign: TextAlign.center,
//         ),
//       ),
//       OnboardingPage(
//         imagePath: 'assets/images/onboarding-slides_3.svg',
//         title: 'Visualisez vos missions',
//         descriptionWidget: StyledPlaceholderRichText(
//           text:
//               'En un coup d’oeil, consultez les {bold:informations essentielles} de vos missions sans ouvrir vos contrats.',
//           placeholders: [_boldPlaceholder],
//           textAlign: TextAlign.center,
//         ),
//       ),
//       OnboardingPage(
//         imagePath: 'assets/images/onboarding-slides_4.svg',
//         title: 'Accédez à vos documents',
//         descriptionWidget: StyledPlaceholderRichText(
//           text:
//               'Vos documents restent classés et facilement accessibles. {bold:Visualisez, imprimez} et {bold:partagez} vos documents.',
//           placeholders: [_boldPlaceholder],
//           textAlign: TextAlign.center,
//         ),
//       ),
//     ];
//     _nbPages = _pages.length;
//   }

//   Widget _buildIndicators() {
//     final List<Widget> list = [];
//     for (int i = 0; i < _nbPages; i++) {
//       list.add(i == _currentPage ? _buildIndicator(true) : _buildIndicator(false));
//     }
//     return Wrap(children: list);
//   }

//   Widget _buildIndicator(bool isActive) {
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 150),
//       margin: const EdgeInsets.symmetric(horizontal: 8.0),
//       height: 8.0,
//       width: isActive ? 24.0 : 8.0,
//       decoration: BoxDecoration(
//         color: isActive ? _mainColor : _lightMainColor,
//         borderRadius: BorderRadius.all(Radius.circular(12.0)),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       // forbid android back button and ios back swipe gesture
//       onWillPop: () async => false,
//       child: Container(
//         padding: EdgeInsets.only(
//           top: MediaQueryData.fromWindow(WidgetsBinding.instance!.window).padding.top,
//         ),
//         color: Colors.white, // TODO: check for dark mode
//         child: Column(
//           children: [
//             Expanded(
//               child: PageView.builder(
//                 physics: ClampingScrollPhysics(),
//                 controller: _pageController,
//                 onPageChanged: (int page) {
//                   setState(() {
//                     _currentPage = page;
//                   });
//                 },
//                 itemBuilder: (_, index) => _pages[index],
//                 itemCount: _pages.length,
//               ),
//             ),
//             _buildBottomControls(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBottomControls() {
//     final bool isLastPage = _currentPage == _nbPages - 1;

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: SizedBox(
//         width: min(MediaQuery.of(context).size.width, Constants.onboardingMaxWidth),
//         child: Row(
//           children: [
//             Expanded(
//               child: !isLastPage ? _buildSkipButton() : const SizedBox.shrink(),
//             ),
//             _buildIndicators(),
//             Expanded(
//               child: !isLastPage ? _buildNextPageButton() : _buildLoginButton(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildNextPageButton() {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: TextButton(
//         onPressed: () {
//           _pageController.nextPage(
//             duration: Duration(milliseconds: 500),
//             curve: Curves.ease,
//           );
//         },
//         child: Text(
//           'Next',
//           style: TextStyle(color: _mainColor, fontSize: 18.0),
//         ),
//       ),
//     );
//   }

//   Widget _buildLoginButton() {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: TextButton(
//         onPressed: () => Navigator.of(context).pop(),
//         child: Text(
//           'Login',
//           style: TextStyle(color: _mainColor, fontSize: 18.0),
//         ),
//       ),
//     );
//   }

//   Align _buildSkipButton() {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: TextButton(
//         onPressed: () => Navigator.of(context).pop(),
//         child: Text(
//           'Skip',
//           style: TextStyle(color: _secondaryColor, fontSize: 18.0),
//         ),
//       ),
//     );
//   }
// }
