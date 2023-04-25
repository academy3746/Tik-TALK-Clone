import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/auth/email_screen.dart';
import 'package:tictok_clone/features/auth/login_screen.dart';
import 'package:tictok_clone/features/auth/sign_up_screen.dart';
import 'package:tictok_clone/features/auth/user_name_screen.dart';
import 'package:tictok_clone/features/videos/video_recording_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 화면 세로 고정
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light,
  );

  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tik-TALK! Clone',
      themeMode: ThemeMode.system,
      // Dark Mode in IOS Simulator: Shift + Command + a
      theme: ThemeData(
        //useMaterial3: true,
        textTheme: Typography.blackMountainView,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: const Color(0xFFE9435A),
        scaffoldBackgroundColor: Colors.white,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        splashColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size20 - Sizes.size2,
            fontWeight: FontWeight.w600,
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey.shade500,
          indicatorColor: Theme.of(context).primaryColor,
        ),
        listTileTheme: const ListTileThemeData(
          iconColor: Colors.black,
        ),
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        //useMaterial3: true,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        textTheme: Typography.whiteMountainView,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade900,
          surfaceTintColor: Colors.grey.shade900,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: Sizes.size20 - Sizes.size2,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade900,
        ),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        primaryColor: const Color(0xFFE9435A),
      ),
      debugShowCheckedModeBanner: false,
      //home: const SignUpScreen(),
      //initialRoute: SignUpScreen.routeName,
      initialRoute: VideoRecordingScreen.routeName,
      routes: {
        SignUpScreen.routeName: (context) => const SignUpScreen(),
        UserNameScreen.routeName: (context) => const UserNameScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        EmailScreen.routeName: (context) => const EmailScreen(),
        VideoRecordingScreen.routeName: (context) => const VideoRecordingScreen(),
      },
    );
  }
}
