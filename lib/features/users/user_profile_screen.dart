import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Scrollable AppBar
        SliverAppBar(
          floating: true,
          stretch: true,
          pinned: true,
          backgroundColor: Theme.of(context).primaryColor,
          collapsedHeight: 80,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [
              StretchMode.blurBackground,
              StretchMode.zoomBackground,
            ],
            title: const Text("We Rock!"),
            background: Image.asset(
              "assets/images/image007.jpeg",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
