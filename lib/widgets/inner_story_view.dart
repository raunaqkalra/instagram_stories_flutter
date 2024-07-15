import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';

import '../constants/constants.dart';
import '../instagram_stories_flutter.dart' show Stories, LastStoryItem;

/// This is a single piece of story
/// Can be multiple inside a story
class InnerStoryView extends StatefulWidget {
  /// Currently tapped index just for init purpose
  final int index;

  final int carouselIndex;

  /// Stories to be displayed to the user
  final List<Stories> allStories;

  /// This is used to store the last opened item by the user for each story
  final List<LastStoryItem> lastOpenedStories;

  /// [CarouselSliderController] is required to switch the user to next page automatically
  /// Or when the user taps on left side of the story - moves backward
  /// Or when the user taps on right side of the story - moves forward
  final CarouselSliderController sliderController;

  /// On story icon item tap
  /// Used to set story to be marked as seen by the user
  final void Function(int?)? onTap;

  final TextStyle? innerTitleStyle;
  final TextStyle? innerSubtitleStyle;
  final TextStyle? innerBottomStyle;

  const InnerStoryView({
    super.key,
    required this.index,
    required this.allStories,
    required this.carouselIndex,
    required this.sliderController,
    required this.onTap,
    required this.lastOpenedStories,
    required this.innerTitleStyle,
    required this.innerSubtitleStyle,
    required this.innerBottomStyle,
  });

  @override
  State<InnerStoryView> createState() => _InnerStoryViewState();
}

class _InnerStoryViewState extends State<InnerStoryView>
    with SingleTickerProviderStateMixin {
  /// This list is needed to show the story based on their data.
  List<String> stories = [];

  /// This is used to control the page
  final PageController _pageController = PageController();

  /// Will be initialized in init
  int storyIndex = 0;

  List<int> times = [];
  AnimationController? animationController;
  Animation<double>? tween;
  double currentPage = 0;

  @override
  void initState() {
    /// This functionality is used to maintain the last state of the story
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      currentPage = widget
          .lastOpenedStories[widget.carouselIndex].innerStoryIndex
          .toDouble();
      /*if (currentPage == widget.lastOpenedStories.length - 1) {
        _pageController.jumpToPage(
          0,
        );
        setState(() {
          currentPage = 0;
        });
      } else*/
      {
        try {
          _pageController.jumpToPage(
            widget.lastOpenedStories[widget.carouselIndex].innerStoryIndex,
          );

          setState(() {
            currentPage = widget
                .lastOpenedStories[widget.carouselIndex].innerStoryIndex
                .toDouble();
          });
        } catch (e) {
          log(e.toString());
        }
      }
    });
    super.initState();
    stories.addAll(
      List.generate(
        widget.allStories[storyIndex].storyItems.length,
        (index) => widget.allStories[storyIndex].storyItems[index].url,
      ),
    );
    if (stories.isNotEmpty) {
      animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 7),
      );
      tween = Tween<double>(begin: 0, end: 1)
          .animate(animationController ?? AnimationController(vsync: this));

      final TickerFuture? val = animationController?.forward();
      log(val.toString());
      animationController?.addListener(animationListener);
    }
  }

  void animationListener() {
    if (animationController?.isCompleted ?? false) {
      animationController?.reset();
      if (stories.length - 1 == _pageController.page) {
        animationController?.removeListener(animationListener);
        if (widget.allStories.length - 1 == widget.carouselIndex) {
          Navigator.pop(context);
        } else {
          final value = widget.sliderController.nextPage(
            const Duration(milliseconds: 300),
          );
          log(value.toString());
        }
        return;
      }
      setState(() {
        currentPage = (_pageController.page ?? 0) + 1;
        _pageController.nextPage(
          duration: const Duration(milliseconds: 5),
          curve: Curves.easeIn,
        );
        final TickerFuture? val = animationController?.forward();
        log(val.toString());
      });
    }
  }

  /// remove the controllers whenever the screen removed.
  @override
  void dispose() {
    _pageController.dispose();
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        if (stories.isNotEmpty)
          PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: stories.length,
            onPageChanged: (val) => {
              widget.lastOpenedStories[widget.carouselIndex].innerStoryIndex =
                  val,
              widget.lastOpenedStories[widget.carouselIndex].carouselIndex =
                  widget.carouselIndex,
            },
            // onPageChanged: (index) => widget.onPageChanged?.call(index),
            itemBuilder: (context, i) {
              log('carouselIndex:${widget.carouselIndex} storyIndex:$i');

              if (stories.length - 1 == i) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  widget.onTap?.call(widget.index);
                });
              }
              return Stack(
                alignment: Alignment.center,
                children: [
                  // FittedBox(
                  //   fit: BoxFit.cover,
                  //   child: Uri.parse(widget.stories[i].url).isAbsolute
                  //       ? ADCachedImage(
                  //           imageUrl: widget.stories[i].url,
                  //           boxFit: BoxFit.contain,
                  //           // height: double.infinity,
                  //           // width: double.infinity,
                  //         )
                  //       : Image.asset(widget.stories[i].url),
                  // ),
                  // Image.network(
                  //   widget.allStories[widget.carouselIndex][i],
                  //   height: MediaQuery.of(context).size.height,
                  //   width: MediaQuery.of(context).size.width,
                  //   fit: BoxFit.contain,
                  //   placeHolder: (context, url) => ADShimmer.fromColors(
                  //     // type: ShimmerType.rectangleBox,
                  //     // width: double.infinity,
                  //     // height: double.infinity,
                  //     period: const Duration(seconds: 1),
                  //     baseColor: const Color(0xff1D3670),
                  //     highlightColor: const Color(0xff212a44),
                  //     child: Container(
                  //       width: context.widthOfScreen,
                  //       height: context.heightOfScreen,
                  //       decoration: BoxDecoration(
                  //         borderRadius:
                  //             const BorderRadius.all(Radius.circular(5)),
                  //         color: context.adColors.shimmerColor,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  FadeInImage.memoryNetwork(
                    image: widget
                        .allStories[widget.carouselIndex].storyItems[i].url,
                    height: size.height,
                    width: size.width,
                    placeholder: kTransparentImage,
                    // placeholder: 'placeholder',
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: size.height / 2,
                      width: size.width,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black,
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (widget.allStories[widget.carouselIndex].storyItems[i]
                          .title !=
                      null)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 30,
                        ),
                        child: Text(
                          widget.allStories[widget.carouselIndex].storyItems[i]
                                  .title ??
                              '',
                          style: widget.innerBottomStyle ??
                              const TextStyle(
                                  color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onLongPress: () => onLongPress(),
                          onLongPressUp: () => onLongPressUp(),
                          onTapUp: (val) => animationController?.forward(),
                          onTap: () => onLeftTap(),
                          onPanUpdate: (details) =>
                              onDragDown(details, context),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onLongPress: () => onLongPress(),
                          onLongPressUp: () => onLongPressUp(),
                          onTapUp: (val) => animationController?.forward(),
                          onTap: () => onRightTap(),
                          onPanUpdate: (details) =>
                              onDragDown(details, context),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          )
        else
          const Center(child: Text('No Data Found!')),
        AnimatedOpacity(
          opacity: animationController?.isAnimating ?? true ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 100),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: 10,
                ),
                child: Row(
                  children: List.generate(
                    stories.length,
                    (index) => currentPage != index
                        ? Expanded(
                            child: Container(
                              height: 2,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: LinearProgressIndicator(
                                value: currentPage > index ? 1 : 0,
                                valueColor: const AlwaysStoppedAnimation(
                                  Color(0xffFFA329),
                                ),
                              ),
                            ),
                          )
                        : AnimatedBuilder(
                            animation: animationController ??
                                AnimationController(vsync: this),
                            builder: (context, child) => Expanded(
                              child: Container(
                                height: 2,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 2,
                                ),
                                child: LinearProgressIndicator(
                                  value: tween?.value ?? 0,
                                  valueColor: const AlwaysStoppedAnimation(
                                    Color(0xffFFA329),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
              ),
              ListTile(
                leading: AbsorbPointer(
                  child: Transform.translate(
                    offset: const Offset(0, 4),
                    child: FadeInImage.memoryNetwork(
                      image: widget.allStories[widget.carouselIndex].url ?? '',
                      placeholder: kTransparentImage,
                    ),
                  ),
                ),
                title: Text(
                  widget.allStories[widget.carouselIndex].title,
                  style: widget.innerTitleStyle,
                ),
                subtitle: widget.allStories[widget.carouselIndex]
                            .storyItems[currentPage.toInt()].createdDate !=
                        null
                    ? Text(
                        widget.allStories[widget.carouselIndex]
                                .storyItems[currentPage.toInt()].createdDate ??
                            '',
                        style: widget.innerSubtitleStyle,
                      )
                    : null,
                trailing: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 28,
                    width: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 17,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void onLongPress() {
    setState(() {
      animationController?.stop();
    });
  }

  void onLongPressUp() {
    setState(() {
      final value = animationController?.forward();
      log(value.toString());
    });
  }

  void onLeftTap() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 5),
      curve: Curves.easeIn,
    );
    setState(() {
      if (currentPage > 0) {
        animationController?.reset();
        currentPage--;
      }
      final TickerFuture? val = animationController?.forward();
      log(val.toString());
    });
    if (_pageController.page == 0) {
      final value = widget.sliderController.previousPage(
        const Duration(milliseconds: 300),
      );
      log(value.toString());
    }
  }

  void onRightTap() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 5),
      curve: Curves.easeIn,
    );
    setState(() {
      if (currentPage < stories.length - 1) {
        currentPage++;
        animationController?.reset();
        final TickerFuture? val = animationController?.forward();
        log(val.toString());
      }
    });
    if (_pageController.page == (stories.length - 1)) {
      if (widget.allStories.length - 1 != widget.carouselIndex) {
        final value = widget.sliderController.nextPage(
          const Duration(milliseconds: 300),
        );
        log(value.toString());
      } else {
        Navigator.canPop(context);
      }
    }
  }
}

void onDragDown(DragUpdateDetails details, BuildContext context) {
  {
    // Swiping in down direction.
    if (details.delta.dy > 10) {
      Navigator.pop(context);
    }
  }
}
