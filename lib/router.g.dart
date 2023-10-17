// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $homeRoute,
    ];

RouteBase get $homeRoute => GoRouteData.$route(
      path: '/home',
      factory: $HomeRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'details/:itemId',
          factory: $DetailsRouteExtension._fromState,
        ),
      ],
    );

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location(
        '/home',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DetailsRouteExtension on DetailsRoute {
  static DetailsRoute _fromState(GoRouterState state) => DetailsRoute(
        itemId: state.pathParameters['itemId']!,
        itemName: state.uri.queryParameters['item-name'],
        shoudShowDialog: _$convertMapValue(
            'shoud-show-dialog', state.uri.queryParameters, _$boolConverter),
        isFavorite: _$convertMapValue(
            'is-favorite', state.uri.queryParameters, _$boolConverter),
        initialSignUpStep: _$convertMapValue('initial-sign-up-step',
            state.uri.queryParameters, _$SignUpStepsEnumMap._$fromName),
      );

  String get location => GoRouteData.$location(
        '/home/details/${Uri.encodeComponent(itemId)}',
        queryParams: {
          if (itemName != null) 'item-name': itemName,
          if (shoudShowDialog != null)
            'shoud-show-dialog': shoudShowDialog!.toString(),
          if (isFavorite != null) 'is-favorite': isFavorite!.toString(),
          if (initialSignUpStep != null)
            'initial-sign-up-step': _$SignUpStepsEnumMap[initialSignUpStep!],
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

const _$SignUpStepsEnumMap = {
  SignUpSteps.email: 'email',
  SignUpSteps.name: 'name',
  SignUpSteps.adress: 'adress',
};

T? _$convertMapValue<T>(
  String key,
  Map<String, String> map,
  T Function(String) converter,
) {
  final value = map[key];
  return value == null ? null : converter(value);
}

bool _$boolConverter(String value) {
  switch (value) {
    case 'true':
      return true;
    case 'false':
      return false;
    default:
      throw UnsupportedError('Cannot convert "$value" into a bool.');
  }
}

extension<T extends Enum> on Map<T, String> {
  T _$fromName(String value) =>
      entries.singleWhere((element) => element.value == value).key;
}
