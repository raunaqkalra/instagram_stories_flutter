/*
 * Copyright (c) 2022 .
 * All rights reserved.
 * Adani Digital Labs Confidential Information
 */
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:instagram_stories_flutter/inner_story_view.dart';
import 'package:instagram_stories_flutter/models/last_story_item.dart';
import 'package:instagram_stories_flutter/models/story_item.dart';

///this class is used to show the story.

class StoryViewScreen extends StatefulWidget {
  ///currently tapped index
  final int index;

  ///stories to be displayed to the user
  final List<Stories> allStories;

  ///this is used to store the last opened item by the user for each story
  final List<LastStoryItem> lastOpenedStories;

  ///on story icon item tap
  ///usually used to set story to be marked as seen by the user
  final Function(int?)? onTap;

  const StoryViewScreen({
    super.key,
    required this.allStories,
    required this.index,
    required this.onTap,
    required this.lastOpenedStories,
  });

  @override
  StoryScreenState createState() => StoryScreenState();
}

class StoryScreenState extends State<StoryViewScreen> {
  int storyIndex = 0;
  final CarouselSliderController _sliderController = CarouselSliderController();

  @override
  void initState() {
    storyIndex = widget.index;
    super.initState();
    // _sliderController.nextPage()
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CarouselSlider.builder(
          controller: _sliderController,
          initialPage: storyIndex,
          scrollPhysics: const ClampingScrollPhysics(),
          itemCount: widget.allStories.length + 1,
          slideBuilder: (carouselIndex) =>
              (carouselIndex != widget.allStories.length)
                  ? InnerStoryView(
                      lastOpenedStories: widget.lastOpenedStories,
                      sliderController: _sliderController,
                      index: storyIndex,
                      allStories: widget.allStories,
                      carouselIndex: carouselIndex,
                      onTap: widget.onTap,
                    )
                  : const SizedBox(),
          slideTransform: const CubeTransform(),
          onSlideChanged: (i) => {
            if (i == widget.allStories.length)
              {
                Navigator.pop(context),
              },
            // widget.onTap?.call(i),
          },
        ),
      ),
    );
  }
}
