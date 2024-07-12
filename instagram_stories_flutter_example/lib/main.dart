import 'package:flutter/material.dart';
import 'package:instagram_stories_flutter/components/story_view_icon.dart';
import 'package:instagram_stories_flutter/models/last_story_item.dart';
import 'package:instagram_stories_flutter/models/story_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ///used to store whether the story has been opened or not
  final List<bool> isUnopenedList = [];

  ///this is used to store the last opened item by the user for each story
  final List<LastStoryItem> lastOpenedStories = [];

  ///stories to be displayed to the user
  final List<Stories> allStories = [
    Stories(
        'https://sa.uat.adanione.com/-/media/Project/Campaigns/PaymentCategory/bill-payments-icon-svgs/ic_mobile_recharge.png',
        'Mobile Recharge', [
      StoryItem(
        url:
            'https://sa.uat.adanione.com/-/media/Project/Campaigns/PaymentCategory/bill-payments-icon-svgs/ic_electricity_bill.png',
        title: 'title11',
        createdDate: 'createdDate11',
      ),
      StoryItem(
        url:
            'https://sa.uat.adanione.com/-/media/Project/Campaigns/PaymentCategory/Sample/Electricity.png',
        title: 'title12',
        createdDate: 'createdDate12',
      ),
    ]),
    Stories(
        'https://sa.uat.adanione.com/-/media/Project/Campaigns/PaymentCategory/bill-payments-icon-svgs/ic_mobile_postpaid.png',
        'Mobile Postpaid', [
      StoryItem(
        url:
            'https://sa.uat.adanione.com/-/media/Project/Campaigns/PaymentCategory/bill-payments-icon-svgs/ic_Fastag_recharge.png',
        title: 'title21',
        createdDate: 'createdDate21',
      ),
      StoryItem(
        url:
            'https://sa.uat.adanione.com/-/media/Project/Campaigns/PaymentCategory/Sample/Fastag.png',
        title: 'title22',
        createdDate: 'createdDate22',
      ),
    ]),
  ];

  @override
  void initState() {
    isUnopenedList.addAll(
      List.generate(allStories.length, (index) => true),
    );
    lastOpenedStories.addAll(
      List.generate(
        allStories.length,
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => StoryViewIcon(
                  allStories: allStories,
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
                ),
                separatorBuilder: (context, index) => const SizedBox(width: 20),
                itemCount: allStories.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
