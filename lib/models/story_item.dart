import 'package:flutter/material.dart';

///a single item in the story
class StoryItem {
  /// image url for a single item in story
  final String url;

  /// title for a single item in story
  final String? title;

  /// date/subtitle for a single item in story
  final String? createdDate;

  StoryItem({
    /// image url for a single item in story
    required this.url,

    /// title for a single item in story
    required this.title,

    /// date/subtitle for a single item in story
    required this.createdDate,
  });
}

///a complete story containing multiple images/[StoryItem]
class Stories {
  ///story icon of a complete story
  ///can be null in case user has provided a custom widget
  String? url;

  ///title of a complete story
  String title;

  ///multiple items/images containing in a single story
  ///having separate url/title and subtitle(createdDate)
  List<StoryItem> storyItems;

  /// Custom widget for main story icon
  /// Which is default circular image
  final Widget? customWidget;

  Stories({
    ///story icon of a complete story
    ///can be null in case user has provided a custom widget
    this.url,

    ///title of a complete story
    required this.title,

    ///multiple items/images containing in a single story
    ///having separate url/title and subtitle(createdDate)
    required this.storyItems,

    /// Custom widget for main story icon
    /// Which is default circular image

    this.customWidget,
  });
}
