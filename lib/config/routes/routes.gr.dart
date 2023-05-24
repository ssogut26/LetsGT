// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'routes.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    ActivitiesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ActivitiesPage(),
      );
    },
    ActivityDetailRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ActivityDetailPage(),
      );
    },
    ConfirmResetPasswordRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ConfirmResetPasswordPage(),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ResetPasswordPage(),
      );
    },
    SignInRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignInPage(),
      );
    },
    SignUpRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignUpPage(),
      );
    },
    SignUpConfirmRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignUpConfirmPage(),
      );
    },
    CreateActivityRoute.name: (routeData) {
      final args = routeData.argsAs<CreateActivityRouteArgs>(
          orElse: () => const CreateActivityRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CreateActivityPage(
          key: args.key,
          locationInfo: args.locationInfo,
        ),
      );
    },
    MapRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MapPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    ChatRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ChatPage(),
      );
    },
    MessagesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MessagesPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfilePage(),
      );
    },
  };
}

/// generated route for
/// [ActivitiesPage]
class ActivitiesRoute extends PageRouteInfo<void> {
  const ActivitiesRoute({List<PageRouteInfo>? children})
      : super(
          ActivitiesRoute.name,
          initialChildren: children,
        );

  static const String name = 'ActivitiesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ActivityDetailPage]
class ActivityDetailRoute extends PageRouteInfo<void> {
  const ActivityDetailRoute({List<PageRouteInfo>? children})
      : super(
          ActivityDetailRoute.name,
          initialChildren: children,
        );

  static const String name = 'ActivityDetailRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ConfirmResetPasswordPage]
class ConfirmResetPasswordRoute extends PageRouteInfo<void> {
  const ConfirmResetPasswordRoute({List<PageRouteInfo>? children})
      : super(
          ConfirmResetPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ConfirmResetPasswordRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ResetPasswordPage]
class ResetPasswordRoute extends PageRouteInfo<void> {
  const ResetPasswordRoute({List<PageRouteInfo>? children})
      : super(
          ResetPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignInPage]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute({List<PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignUpPage]
class SignUpRoute extends PageRouteInfo<void> {
  const SignUpRoute({List<PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignUpConfirmPage]
class SignUpConfirmRoute extends PageRouteInfo<void> {
  const SignUpConfirmRoute({List<PageRouteInfo>? children})
      : super(
          SignUpConfirmRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpConfirmRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CreateActivityPage]
class CreateActivityRoute extends PageRouteInfo<CreateActivityRouteArgs> {
  CreateActivityRoute({
    Key? key,
    String? locationInfo,
    List<PageRouteInfo>? children,
  }) : super(
          CreateActivityRoute.name,
          args: CreateActivityRouteArgs(
            key: key,
            locationInfo: locationInfo,
          ),
          initialChildren: children,
        );

  static const String name = 'CreateActivityRoute';

  static const PageInfo<CreateActivityRouteArgs> page =
      PageInfo<CreateActivityRouteArgs>(name);
}

class CreateActivityRouteArgs {
  const CreateActivityRouteArgs({
    this.key,
    this.locationInfo,
  });

  final Key? key;

  final String? locationInfo;

  @override
  String toString() {
    return 'CreateActivityRouteArgs{key: $key, locationInfo: $locationInfo}';
  }
}

/// generated route for
/// [MapPage]
class MapRoute extends PageRouteInfo<void> {
  const MapRoute({List<PageRouteInfo>? children})
      : super(
          MapRoute.name,
          initialChildren: children,
        );

  static const String name = 'MapRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ChatPage]
class ChatRoute extends PageRouteInfo<void> {
  const ChatRoute({List<PageRouteInfo>? children})
      : super(
          ChatRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MessagesPage]
class MessagesRoute extends PageRouteInfo<void> {
  const MessagesRoute({List<PageRouteInfo>? children})
      : super(
          MessagesRoute.name,
          initialChildren: children,
        );

  static const String name = 'MessagesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
