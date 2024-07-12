///a single item in the story
class StoryItem {
  /// image url for a single item in story
  final String url;

  /// title for a single item in story
  final String title;

  /// date/subtitle for a single item in story
  final String createdDate;

  StoryItem({
    required this.url,
    required this.title,
    required this.createdDate,
  });
}

///a complete story containing multiple images/[StoryItem]
class Stories {
  ///story icon of a complete story
  String url;

  ///title of a complete story
  String title;

  ///multiple items/images containing in a single story
  ///having separate url/title and subtitle(createdDate)
  List<StoryItem> storyItems;

  Stories(this.url, this.title, this.storyItems);
}
