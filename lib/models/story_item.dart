class StoryItem {
  /// media url
  final String url;
  final String title;
  final String createdDate;

  StoryItem({
    required this.url,
    required this.title,
    required this.createdDate,
  });
}

class Stories {
  String url;
  String title;
  List<StoryItem> storyItems;

  Stories(this.url, this.title, this.storyItems);
}
