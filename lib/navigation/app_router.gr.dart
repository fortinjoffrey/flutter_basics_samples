// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../views/dummies/colorful_view.dart' as _i9;
import '../views/dummies/placeholder_view.dart' as _i6;
import '../views/login_view.dart' as _i5;
import '../views/main_view.dart' as _i4;
import '../views/tabs/home_view.dart' as _i7;
import '../views/tabs/profile_view.dart' as _i8;
import 'auth_guard.dart' as _i3;

class AppRouter extends _i1.RootStackRouter {
  AppRouter(
      {_i2.GlobalKey<_i2.NavigatorState>? navigatorKey,
      required this.authGuard})
      : super(navigatorKey);

  final _i3.AuthGuard authGuard;

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    MainRoute.name: (routeData) => _i1.MaterialPageX<void>(
        routeData: routeData,
        builder: (_) {
          return const _i4.MainView();
        }),
    LoginRoute.name: (routeData) => _i1.MaterialPageX<void>(
        routeData: routeData,
        builder: (data) {
          final args =
              data.argsAs<LoginRouteArgs>(orElse: () => const LoginRouteArgs());
          return _i5.LoginView(key: args.key, onLogin: args.onLogin);
        },
        fullscreenDialog: true),
    PlaceholderRoute.name: (routeData) => _i1.MaterialPageX<void>(
        routeData: routeData,
        builder: (_) {
          return const _i6.PlaceholderView();
        }),
    HomeTab.name: (routeData) => _i1.MaterialPageX<void>(
        routeData: routeData,
        builder: (_) {
          return const _i1.EmptyRouterPage();
        }),
    ProfileTab.name: (routeData) => _i1.MaterialPageX<void>(
        routeData: routeData,
        builder: (_) {
          return const _i1.EmptyRouterPage();
        }),
    HomeRoute.name: (routeData) => _i1.MaterialPageX<void>(
        routeData: routeData,
        builder: (_) {
          return const _i7.HomeView();
        }),
    ProfileRoute.name: (routeData) => _i1.MaterialPageX<void>(
        routeData: routeData,
        builder: (_) {
          return const _i8.ProfileView();
        }),
    ColorfulRoute.name: (routeData) => _i1.MaterialPageX<void>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<ColorfulRouteArgs>(
              orElse: () => const ColorfulRouteArgs());
          return _i9.ColorfulView(key: args.key, color: args.color);
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(MainRoute.name, path: '/', guards: [
          authGuard
        ], children: [
          _i1.RouteConfig(HomeTab.name, path: 'home', children: [
            _i1.RouteConfig(HomeRoute.name, path: ''),
            _i1.RouteConfig(PlaceholderRoute.name, path: 'placeholder')
          ]),
          _i1.RouteConfig(ProfileTab.name, path: 'profile', children: [
            _i1.RouteConfig(ProfileRoute.name, path: ''),
            _i1.RouteConfig(ColorfulRoute.name, path: 'colorful')
          ])
        ]),
        _i1.RouteConfig(LoginRoute.name, path: 'login'),
        _i1.RouteConfig(PlaceholderRoute.name, path: 'placeholder')
      ];
}

class MainRoute extends _i1.PageRouteInfo {
  const MainRoute({List<_i1.PageRouteInfo>? children})
      : super(name, path: '/', initialChildren: children);

  static const String name = 'MainRoute';
}

class LoginRoute extends _i1.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i2.Key? key, void Function()? onLogin})
      : super(name,
            path: 'login', args: LoginRouteArgs(key: key, onLogin: onLogin));

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key, this.onLogin});

  final _i2.Key? key;

  final void Function()? onLogin;
}

class PlaceholderRoute extends _i1.PageRouteInfo {
  const PlaceholderRoute() : super(name, path: 'placeholder');

  static const String name = 'PlaceholderRoute';
}

class HomeTab extends _i1.PageRouteInfo {
  const HomeTab({List<_i1.PageRouteInfo>? children})
      : super(name, path: 'home', initialChildren: children);

  static const String name = 'HomeTab';
}

class ProfileTab extends _i1.PageRouteInfo {
  const ProfileTab({List<_i1.PageRouteInfo>? children})
      : super(name, path: 'profile', initialChildren: children);

  static const String name = 'ProfileTab';
}

class HomeRoute extends _i1.PageRouteInfo {
  const HomeRoute() : super(name, path: '');

  static const String name = 'HomeRoute';
}

class ProfileRoute extends _i1.PageRouteInfo {
  const ProfileRoute() : super(name, path: '');

  static const String name = 'ProfileRoute';
}

class ColorfulRoute extends _i1.PageRouteInfo<ColorfulRouteArgs> {
  ColorfulRoute({_i2.Key? key, _i2.Color? color})
      : super(name,
            path: 'colorful', args: ColorfulRouteArgs(key: key, color: color));

  static const String name = 'ColorfulRoute';
}

class ColorfulRouteArgs {
  const ColorfulRouteArgs({this.key, this.color});

  final _i2.Key? key;

  final _i2.Color? color;
}
