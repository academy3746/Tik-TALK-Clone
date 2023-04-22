import 'package:go_router/go_router.dart';
import 'package:tictok_clone/features/auth/email_screen.dart';
import 'package:tictok_clone/features/auth/login_screen.dart';
import 'package:tictok_clone/features/auth/sign_up_screen.dart';
import 'package:tictok_clone/features/auth/user_name_screen.dart';

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
      builder: (context, state) => const EmailScreen(),
    ),
  ],
);
