import 'dart:io' show Platform;
import 'package:flutter/material.dart';

class TransparentPageRoute<T> extends PageRouteBuilder<T> {
  /// Flutter (as 2.10.3) does not allow to change opaque flag for MaterialPageRoute and CupertinoPageRoute
  ///
  /// For the above routes, the opaque flag defaults to true. The widget returned via builder method could not have a transparent background
  ///
  /// To do so, one solution is to use a [PageRouteBuilder] to be able to change the opaque to false
  ///
  /// To simulate Material and Cupertino transitions, we need to use [FadeUpwardsPageTransitionsBuilder] and [CupertinoPageTransitionsBuilder]
  TransparentPageRoute({
    required RoutePageBuilder builder,
    this.useMaterialTransition,
    this.useCupertinoTransition,
  })  : assert(useMaterialTransition == null || useCupertinoTransition == null),
        super(
          opaque: false,
          pageBuilder: builder,
        );

  final bool? useMaterialTransition;
  final bool? useCupertinoTransition;

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    if (useMaterialTransition == true) {
      const PageTransitionsBuilder matchingBuilder = FadeUpwardsPageTransitionsBuilder();
      return matchingBuilder.buildTransitions<T>(this, context, animation, secondaryAnimation, child);
    }

    if (useCupertinoTransition == true) {
      const PageTransitionsBuilder matchingBuilder = CupertinoPageTransitionsBuilder();
      return matchingBuilder.buildTransitions<T>(this, context, animation, secondaryAnimation, child);
    }

    if (Platform.isIOS) {
      const PageTransitionsBuilder matchingBuilder = CupertinoPageTransitionsBuilder();
      return matchingBuilder.buildTransitions<T>(this, context, animation, secondaryAnimation, child);
    } else {
      const PageTransitionsBuilder matchingBuilder = FadeUpwardsPageTransitionsBuilder();
      return matchingBuilder.buildTransitions<T>(this, context, animation, secondaryAnimation, child);
    }
  }
}
