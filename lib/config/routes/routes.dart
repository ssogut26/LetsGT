import 'package:auto_route/auto_route.dart';
import 'package:letsgt/features/auth/presentation/pages/sign_in.dart';
import 'package:letsgt/features/auth/presentation/pages/sign_up.dart';
import 'package:letsgt/features/home/presentation/pages/home.dart';

part 'routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')

///[AppRouter] is the main router for the app
///replaceInRouteName replaces the word View with Route
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: SignInRoute.page),
        AutoRoute(page: SignUpRoute.page),
      ];
}
