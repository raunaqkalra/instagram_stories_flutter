import 'package:flutter/material.dart';

import 'instagram_stories_flutter.dart';

/// Story builder to build a list of story widget
class StoriesBuilder extends StatefulWidget {
  final List<Stories> allStories;

  /// Text style assigned to title below the main story icon
  final TextStyle? outerTitleStyle;

  /// Text style assigned to header title inside the story
  final TextStyle? innerTitleStyle;

  /// Text style assigned to subtitle inside the story
  final TextStyle? innerSubtitleStyle;

  /// Text style assigned to bottom inside the story
  final TextStyle? innerBottomStyle;

  /// Story builder to build a list of story widget
  const StoriesBuilder({
    super.key,
    required this.allStories,
    this.outerTitleStyle,
    this.innerTitleStyle,
    this.innerSubtitleStyle,
    this.innerBottomStyle,
  });

  @override
  State<StoriesBuilder> createState() => _StoriesBuilderState();
}

class _StoriesBuilderState extends State<StoriesBuilder> {
  ///used to store whether the story has been opened or not
  final List<bool> isUnopenedList = [];

  ///this is used to store the last opened item by the user for each story
  final List<LastStoryItem> lastOpenedStories = [];

  @override
  void initState() {
    isUnopenedList.addAll(
      List.generate(widget.allStories.length, (index) => true),
    );
    lastOpenedStories.addAll(
      List.generate(
        widget.allStories.length,
        (index) => LastStoryItem(
          carouselIndex: 0,
          innerStoryIndex: 0,
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => StoryViewIcon(
        allStories: widget.allStories,
        index: index,
        lastOpenedStories: lastOpenedStories,
        isUnopened: isUnopenedList[index],
        onTap: (openedIndex) {
          setState(() {
            isUnopenedList[index] = false;
            if (openedIndex != null) {
              isUnopenedList[openedIndex] = false;
            }
          });
        },
        outerTitleStyle: widget.outerTitleStyle,
        innerTitleStyle: widget.innerTitleStyle,
        innerSubtitleStyle: widget.innerSubtitleStyle,
        innerBottomStyle: widget.innerBottomStyle,
      ),
      separatorBuilder: (context, index) => const SizedBox(width: 20),
      itemCount: widget.allStories.length,
    );
  }
}
