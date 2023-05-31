import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:letsgt/features/activities/presentation/pages/activities.dart';
import 'package:letsgt/features/activities/presentation/pages/activity_detail.dart';
import 'package:letsgt/features/auth/presentation/pages/confirm_reset_password.dart';
import 'package:letsgt/features/auth/presentation/pages/reset_password.dart';
import 'package:letsgt/features/auth/presentation/pages/sign_in.dart';
import 'package:letsgt/features/auth/presentation/pages/sign_up.dart';
import 'package:letsgt/features/auth/presentation/pages/sign_up_confirm.dart';
import 'package:letsgt/features/create_activity/presentation/pages/create_activity.dart';
import 'package:letsgt/features/create_activity/presentation/pages/map_view.dart';
import 'package:letsgt/features/create_post/presantation/create_post.dart';
import 'package:letsgt/features/home/presentation/pages/home.dart';
import 'package:letsgt/features/messages/presentation/pages/chat.dart';
import 'package:letsgt/features/messages/presentation/pages/messages.dart';
import 'package:letsgt/features/my_profile/presentation/pages/my_profile.dart';
import 'package:letsgt/models/LocationModel.dart';

part 'routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')

///[AppRouter] is the main router for the app
///replaceInRouteName replaces the word View with Route
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          initial: true,
          guards: [
            AuthGuard(),
          ],
        ),
        AutoRoute(page: SignInRoute.page),
        AutoRoute(page: ResetPasswordRoute.page),
        AutoRoute(page: ConfirmResetPasswordRoute.page),
        AutoRoute(page: SignUpRoute.page),
        AutoRoute(page: SignUpConfirmRoute.page),
        AutoRoute(
          page: CreateActivityRoute.page,
          fullscreenDialog: true,
          guards: [
            AuthGuard(),
          ],
        ),
        AutoRoute(
          page: MapRoute.page,
          fullscreenDialog: true,
          guards: [
            AuthGuard(),
          ],
        ),
        AutoRoute(
          page: MessagesRoute.page,
          guards: [
            AuthGuard(),
          ],
        ),
        AutoRoute(
          page: ChatRoute.page,
          guards: [
            AuthGuard(),
          ],
        ),
        AutoRoute(
          page: ActivitiesRoute.page,
          guards: [
            AuthGuard(),
          ],
        ),
        AutoRoute(
          page: ProfileRoute.page,
          guards: [
            AuthGuard(),
          ],
        ),
        AutoRoute(
          page: ActivityDetailRoute.page,
          guards: [
            AuthGuard(),
          ],
        ),
        AutoRoute(
          page: CreatePostRoute.page,
          guards: [
            AuthGuard(),
          ],
        ),
      ];
}

class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    // we check if the user is authenticated
    bool? authenticated;
    try {
      final user = await Amplify.Auth.getCurrentUser();
      if (user.username.isNotEmpty) {
        authenticated = true;
      } else {
        authenticated = false;
      }
    } catch (e) {
      authenticated = false;
    }
    if (authenticated) {
      // if user is authenticated we continue
      resolver.next(true);
    } else {
      // we redirect the user to our login page
      await router.push(
        const SignInRoute(),
      );
    }
  }
}
