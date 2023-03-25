import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/onboarding/tutorial_screen.dart';
import 'package:tictok_clone/features/onboarding/widgets/interest_button.dart';

const interests = [
  "일상생활",
  "코미디",
  "엔터테인먼트",
  "반려동물",
  "먹방",
  "뷰티 & 미용",
  "드라마",
  "공부",
  "재능",
  "스포츠",
  "자동차",
  "가족",
  "헬스 & 건강",
  "DIY & 꿀팁",
  "예술 & 공예",
  "댄스",
  "아웃도어",
  "심심풀이",
  "홈 & 주방",
  "애니",
  "게임",
  "음악",
  "전자기기",
  "영화",
  "쇼트",
  "드라마",
];

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({Key? key}) : super(key: key);

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showTitle = false;

  void _onScroll() {
    if (_scrollController.offset >= 94.0) {
      if (_showTitle) return;
      setState(() {
        _showTitle = true;
      });
    } else {
      setState(() {
        _showTitle = false;
      });
    }
  }

  void _onNextTap() {
    Navigator.push( // Stateful 위젯에서는 of(context)를 인자로 받을 필요가 없다.
      context,
      MaterialPageRoute(
        builder: (context) => const TutorialScreen(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedOpacity(
          opacity: _showTitle ? 1 : 0,
          duration: const Duration(
            milliseconds: 300,
          ),
          child: const Text("관심사 설정"),
        ),
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(
              left: Sizes.size24,
              right: Sizes.size24,
              bottom: Sizes.size20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v32,
                const Text(
                  "크리에이터님의 관심사를 선택해주세요!",
                  style: TextStyle(
                    fontSize: Sizes.size40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v20,
                const Text(
                  "크리에이터님에게 어울리는 컨텐츠를 추천해드리겠습니다.",
                  style: TextStyle(
                    fontSize: Sizes.size16,
                  ),
                ),
                Gaps.v64,
                Wrap(
                  runSpacing: 15,
                  spacing: 15,
                  children: [
                    for (var interest in interests)
                      InterestButton(interest: interest),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: Sizes.size24,
            top: Sizes.size16,
            left: Sizes.size24,
            right: Sizes.size24,
          ),
          child: GestureDetector(
            onTap: _onNextTap,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size20,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(Sizes.size8),
              ),
              child: const Text(
                "다음으로",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Sizes.size16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
