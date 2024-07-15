import 'package:flutter/material.dart';
import 'package:instagram_stories_flutter/constants/constants.dart';
import 'package:instagram_stories_flutter/models/last_story_item.dart';
import 'package:instagram_stories_flutter/models/story_item.dart';
import 'package:instagram_stories_flutter/widgets/story_view_screen.dart';

///Main story icon to open a story
class StoryViewIcon extends StatelessWidget {
  ///Whether the user has opened it already
  final bool isUnopened;

  ///Current tapped story index
  final int index;

  ///Stories to be displayed to the user
  final List<Stories> allStories;

  ///This is used to store the last opened item by the user for each story
  final List<LastStoryItem> lastOpenedStories;

  ///Set to be true if we want to display the bottom title
  ///Default value set to true
  final bool isBottomTitleVisible;

  ///On story icon item tap
  ///Used to set story to be marked as seen by the user
  final Function(int?)? onTap;

  final TextStyle? outerTitleStyle;
  final TextStyle? innerTitleStyle;
  final TextStyle? innerSubtitleStyle;
  final TextStyle? innerBottomStyle;

  const StoryViewIcon({
    super.key,
    this.isUnopened = true,
    this.isBottomTitleVisible = true,
    required this.allStories,
    required this.index,
    this.onTap,
    required this.lastOpenedStories,
    required this.outerTitleStyle,
    required this.innerTitleStyle,
    required this.innerSubtitleStyle,
    required this.innerBottomStyle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        // onTap?.call(null),
        showModalBottomSheet(
          isScrollControlled: true,
          constraints: BoxConstraints(
            minWidth: double.infinity,
            minHeight: MediaQuery.of(context).size.height * 0.96,
            maxHeight: MediaQuery.of(context).size.height * 0.96,
          ),
          context: context,
          builder: (context) => ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(6),
            ),
            child: StoryViewScreen(
              lastOpenedStories: lastOpenedStories,
              index: index,
              allStories: allStories,
              onTap: onTap,
              innerTitleStyle: innerTitleStyle,
              innerSubtitleStyle: innerSubtitleStyle,
              innerBottomStyle: innerBottomStyle,
            ),
          ),
        ),
      },
      child: Column(
        children: [
          Flexible(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 70,
                  width: 70,
                  padding: EdgeInsets.all(isUnopened ? 2 : 1),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: isUnopened
                        ? const LinearGradient(
                            colors: [
                              Color(0xff2D72AF),
                              Color(0xffBC466D),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : LinearGradient(
                            colors: [
                              Colors.grey.withOpacity(0.5),
                              Colors.grey.withOpacity(0.5),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: FadeInImage.memoryNetwork(
                        image: allStories[index].url,
                        fit: BoxFit.cover,
                        placeholder: kTransparentImage,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isBottomTitleVisible) const SizedBox(height: 8),
          if (isBottomTitleVisible)
            Text(
              allStories[index].title,
              style: outerTitleStyle ?? const TextStyle(fontSize: 12),
            ),
        ],
      ),
    );
  }
}
