import 'package:go_router/go_router.dart';
import 'package:tictok_clone/features/auth/email_screen.dart';
import 'package:tictok_clone/features/auth/login_screen.dart';
import 'package:tictok_clone/features/auth/sign_up_screen.dart';
import 'package:tictok_clone/features/auth/user_name_screen.dart';
import 'package:tictok_clone/features/users/user_profile_screen.dart';

// Newest Type of Navigator Ver 2.0

final router = GoRouter(
  routes: [
    GoRoute(
      path: SignUpScreen.routeName,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: LoginScreen.routeName,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: UserNameScreen.routeName,
      builder: (context, state) => const UserNameScreen(),
    ),
    GoRoute(
      path: EmailScreen.routeName,
      builder: (context, state) {
        final args = state.extra as EmailScreenArgs;
        return EmailScreen(username: args.userName);
      },
    ),
    // For Web Service
    GoRoute(
      path: "/users/:username",
      builder: (context, state) {
        final username = state.params['username'];
        final tab = state.queryParams["show"];

        return UserProfileScreen(
          username: username!,
          tab: tab!,
        );
      },
    ),
  ],
);
