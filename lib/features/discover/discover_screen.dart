import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';

final tabs = [
  "타임라인",
  "사용자",
  "비디오",
  "음악",
  "LIVE",
  "쇼핑",
  "브랜드",
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _isWriting = false;

  void _onSearchChanged(String value) {
    print("Searching for $value");
  }

  void _onSearchSubmitted(String value) {
    print("Submitted $value");
  }

  @override
  void dispose() {
    _textEditingController;
    super.dispose();
  }

  void _dismissKeyboard() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isWriting = false;
    });
  }

  void _onStartWriting() {
    setState(() {
      _isWriting = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _dismissKeyboard,
      child: DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 1,
            title: CupertinoSearchTextField(
              onTap: _onStartWriting,
              controller: _textEditingController,
              onChanged: _onSearchChanged,
              onSubmitted: _onSearchSubmitted,
            ),
            bottom: TabBar(
              splashFactory: NoSplash.splashFactory,
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size16,
              ),
              isScrollable: true,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              ),
              indicatorColor: Theme.of(context).primaryColor,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey.shade500,
              tabs: [
                for (var tab in tabs)
                  Tab(
                    text: tab,
                  ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              GridView.builder(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.all(
                  Sizes.size6,
                ),
                itemCount: 20,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: Sizes.size10,
                  mainAxisSpacing: Sizes.size10,
                  childAspectRatio: 9 / 20,
                ),
                itemBuilder: (BuildContext context, int index) => Column(
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          Sizes.size4,
                        ),
                      ),
                      child: AspectRatio(
                        aspectRatio: 9 / 16,
                        child: FadeInImage.assetNetwork(
                          fit: BoxFit.cover,
                          placeholder: "assets/images/image006.jpeg",
                          image:
                          "https://images.unsplash.com/photo-1592505734135-3c7ee6ae21a3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
                        ),
                      ),
                    ),
                    Gaps.v10,
                    const Text(
                      "I was born to love you with every single day of my life.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Sizes.size16 + Sizes.size2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gaps.v8,
                    DefaultTextStyle(
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://avatars.githubusercontent.com/u/107133642?v=4"),
                            radius: 12,
                          ),
                          Gaps.h4,
                          const Expanded(
                            child: Text(
                              "Ozzy Osbourne & Black Sabbath",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Gaps.h4,
                          FaIcon(
                            FontAwesomeIcons.heart,
                            size: Sizes.size16,
                            color: Colors.grey.shade600,
                          ),
                          Gaps.h2,
                          const Text(
                            "2.5M",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              for (var tab in tabs.skip(1))
                Center(
                  child: Text(
                    tab,
                    style: const TextStyle(
                      fontSize: Sizes.size28,
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