import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/auth/common/auth_button.dart';
import 'package:tictok_clone/features/auth/login_form_screen.dart';
import 'package:tictok_clone/utils.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  void _onSignUpTap(BuildContext context) {
    // Avoid Push Material to prevent infinite goBack...
    Navigator.of(context).pop(); // Remove current Stack
  }

  void _onEmailLoginTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginFormScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size40,
          ),
          child: Column(
            children: [
              Gaps.v80,
              const Opacity(
                opacity: 0.7,
                child: Text(
                  "TikTok 로그인",
                  style: TextStyle(
                    fontSize: Sizes.size24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Gaps.v20,
              const Text(
                "컨텐츠를 관리하기 위해서는 로그인을 해주셔야 해요.",
                style: TextStyle(
                  fontSize: Sizes.size14,
                ),
                textAlign: TextAlign.center,
              ),
              Gaps.v40,
              GestureDetector(
                onTap: () => _onEmailLoginTap(context),
                child: const AuthButton(
                  icon: FaIcon(
                    FontAwesomeIcons.user,
                  ),
                  text: "계정 로그인",
                ),
              ),
              Gaps.v16,
              const AuthButton(
                icon: FaIcon(
                  FontAwesomeIcons.apple,
                ),
                text: "Continue with Apple",
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: isDarkMode(context) ? null : Colors.grey.shade50,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size32,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "아직 틱톡 회원이 아니신가요?",
                style: TextStyle(
                  fontSize: Sizes.size16,
                ),
              ),
              Gaps.h12,
              GestureDetector(
                onTap: () => _onSignUpTap(context),
                child: Text(
                  "회원가입",
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
