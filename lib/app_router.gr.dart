// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import 'main.dart' as _i3;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) => _i1.MaterialPageX<void>(
        routeData: routeData,
        builder: (_) {
          return const _i3.HomeView();
        },
        fullscreenDialog: true),
    Page1Route.name: (routeData) => _i1.MaterialPageX<void>(
        routeData: routeData,
        builder: (_) {
          return const _i3.Page1View();
        },
        fullscreenDialog: true),
    Page2Route.name: (routeData) => _i1.MaterialPageX<void>(
        routeData: routeData,
        builder: (_) {
          return const _i3.Page2View();
        }),
    Page3Route.name: (routeData) => _i1.CupertinoPageX<void>(
        routeData: routeData,
        builder: (_) {
          return const _i3.Page3View();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig('/#redirect',
            path: '/', redirectTo: 'home', fullMatch: true),
        _i1.RouteConfig(HomeRoute.name, path: 'home'),
        _i1.RouteConfig(Page1Route.name, path: 'page1'),
        _i1.RouteConfig(Page2Route.name, path: 'page2'),
        _i1.RouteConfig(Page3Route.name, path: 'page3')
      ];
}

class HomeRoute extends _i1.PageRouteInfo {
  const HomeRoute() : super(name, path: 'home');

  static const String name = 'HomeRoute';
}

class Page1Route extends _i1.PageRouteInfo {
  const Page1Route() : super(name, path: 'page1');

  static const String name = 'Page1Route';
}

class Page2Route extends _i1.PageRouteInfo {
  const Page2Route() : super(name, path: 'page2');

  static const String name = 'Page2Route';
}

class Page3Route extends _i1.PageRouteInfo {
  const Page3Route() : super(name, path: 'page3');

  static const String name = 'Page3Route';
}
