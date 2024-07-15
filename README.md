# instagram_stories_flutter

Customisable instagram like stories with animation for Flutter.

## Features

Can add multiple images in a story.
Can add multiple stories.

## Getting started

dart pub add instagram_stories_flutter

## Usage StoriesBuilder

<img src="https://raw.githubusercontent.com/raunaqkalra/instagram_stories_flutter/master/screenshots/home_default.png" width="180"/>
<img src="https://raw.githubusercontent.com/raunaqkalra/instagram_stories_flutter/master/screenshots/home_partial_seen.png" width="180"/>
<img src="https://raw.githubusercontent.com/raunaqkalra/instagram_stories_flutter/master/screenshots/home_complete_seen.png" width="180"/>
<img src="https://raw.githubusercontent.com/raunaqkalra/instagram_stories_flutter/master/screenshots/story_page.png" width="180"/>
<img src="https://raw.githubusercontent.com/raunaqkalra/instagram_stories_flutter/master/screenshots/story_animating.png" width="180"/>

```dart

final List<Stories> allStories = [
  Stories(
    // url:
    //     'https://sa.uat.adanione.com/-/media/Project/Campaigns/PaymentCategory/bill-payments-icon-svgs/ic_mobile_recharge.png',
    title: 'Mobile Recharge',
    storyItems: [
      StoryItem(
        url:
        'https://sa.uat.adanione.com/-/media/Project/Campaigns/PaymentCategory/bill-payments-icon-svgs/ic_electricity_bill.png',
        title: 'title11',
        createdDate: null,
      ),
      StoryItem(
        url:
        'https://sa.uat.adanione.com/-/media/Project/Campaigns/PaymentCategory/Sample/Electricity.png',
        title: 'title12',
        createdDate: 'createdDate12',
      ),
    ],
    customWidget: const Center(
      child: Text('Test'),
    ),
  ),
  Stories(
      url:
      'https://sa.uat.adanione.com/-/media/Project/Campaigns/PaymentCategory/bill-payments-icon-svgs/ic_mobile_postpaid.png',
      title: 'Mobile Postpaid',
      storyItems: [
        StoryItem(
          url:
          'https://sa.uat.adanione.com/-/media/Project/Campaigns/PaymentCategory/bill-payments-icon-svgs/ic_Fastag_recharge.png',
          title: 'title21',
          createdDate: 'createdDate21',
        ),
      ]),
];

@override
Widget build(BuildContext context) {
  return SizedBox(
    height: 100,
    child: StoriesBuilder(
      allStories: allStories,
      // openedStoryColor: Colors.black,
      // unopenedStoryColor: Colors.green,
    ),
  );
}
```

## Additional information

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors)
specification. Contributions of any kind welcome!

Made with :heart: in India