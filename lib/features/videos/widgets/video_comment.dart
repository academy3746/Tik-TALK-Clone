import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({Key? key}) : super(key: key);

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  void _onClosePressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Sizes.size14,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          automaticallyImplyLeading: false,
          title: const Text("22,796개"),
          actions: [
            IconButton(
              onPressed: _onClosePressed,
              icon: const FaIcon(
                FontAwesomeIcons.xmark,
              ),
            ),
          ],
        ),
        body: ListView.separated(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size10,
            horizontal: Sizes.size16,
          ),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 18,
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
                foregroundImage: NetworkImage(
                  "https://avatars.githubusercontent.com/u/107133642?v=4",
                ),
                child: Text("마따크"),
              ),
              Gaps.h10,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "마따크",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Sizes.size14,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    Gaps.v4,
                    const Text("강아지가 너무 귀여워요!"),
                  ],
                ),
              ),
              Gaps.h10,
              Column(
                children: [
                  FaIcon(
                    FontAwesomeIcons.heart,
                    size: Sizes.size20,
                    color: Colors.grey.shade500,
                  ),
                  Gaps.v2,
                  Text(
                    "52.2K",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          separatorBuilder: (BuildContext context, int index) => Gaps.v20,
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Row(
            children: const [
              CircleAvatar(
                radius: 18,
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
                foregroundImage: NetworkImage(
                  "https://avatars.githubusercontent.com/u/107133642?v=4",
                ),
                child: Text("마따크"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
