# instagram_stories_flutter

Customisable instagram like stories for Flutter.

## Features

Can add multiple images in a story.
Can add multiple stories.

## Getting started

dart pub add instagram_stories_flutter

## Usage StoriesBuilder

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
TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
