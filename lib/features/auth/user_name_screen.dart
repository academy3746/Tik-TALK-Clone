import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';

class UserNameScreen extends StatefulWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "개인정보 입력",
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
                hintText: "익명, 실명 모두 입력 가능",
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
            FractionallySizedBox(
              widthFactor: 1,
              child: AnimatedContainer(
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.size16,
                ),
                decoration: BoxDecoration(
                  color: _userName.isEmpty
                      ? Colors.grey.shade300
                      : Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(
                    Sizes.size5,
                  ),
                ),
                duration: const Duration(
                  milliseconds: 500,
                ),
                child: const Text(
                  "다음으로",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
