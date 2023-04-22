import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/auth/common/form_button.dart';
import 'package:tictok_clone/features/auth/email_screen.dart';

class UserNameScreen extends StatefulWidget {
  static String routeName = "/username";
  const UserNameScreen({Key? key}) : super(key: key);

  @override
  State<UserNameScreen> createState() => _UserNameScreenState();
}

class _UserNameScreenState extends State<UserNameScreen> {
  final TextEditingController _userNameController = TextEditingController();
  String _userName = "";

  @override
  void initState() {
    super.initState();
    _userNameController.addListener(() {
      if (kDebugMode) {
        print(_userNameController.text);
      }

      setState(() {
        _userName = _userNameController.text;
      });
    });
  }

  @override
  void dispose() {
    _userNameController.dispose();
    super.dispose();
  }

  void _onNextTap() {
    if (_userName.isEmpty) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const EmailScreen(),
      ),
    );
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "직접 입력",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v40,
              const Text(
                "회원명",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v8,
              const Text(
                "회원명은 언제든 변경할 수 있어요.",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: Sizes.size16,
                ),
              ),
              Gaps.v16,
              TextField(
                controller: _userNameController,
                decoration: InputDecoration(
                  hintText: "회원명 (익명, 실명 모두 가능)",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
                cursorColor: Theme.of(context).primaryColor,
              ),
              Gaps.v28,
              GestureDetector(
                onTap: _onNextTap,
                child: FormButton(
                  disabled: _userName.isEmpty,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
