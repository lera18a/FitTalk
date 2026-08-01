import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    super.key,
    required this.expandedHeight,
    required this.title,
    this.actions,
    required this.avatarImage,
  });
  final String title;
  final double expandedHeight;
  final List<Widget>? actions;
  final Widget avatarImage;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: expandedHeight,
      pinned: true,
      stretch: true,
      // title: null,
      // foregroundColor: Colors.white,
      // centerTitle: false,
      // backgroundColor: const Color(0xFF1A1A1A),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          title,
          style: TextStyle(
            color:
                Theme.of(context).appBarTheme.titleTextStyle?.color ??
                Colors.white,
          ),
        ),
        centerTitle: true,
        expandedTitleScale: 1.3,
        titlePadding: const EdgeInsets.only(bottom: 16),
        collapseMode: CollapseMode.parallax,
        background: avatarImage,
      ),

      actionsPadding: EdgeInsets.symmetric(horizontal: 10),
      actions: actions,
    );
  }
}
