import 'package:flutter/material.dart';
import 'package:instagram_stories_flutter/instagram_stories_flutter.dart';
import 'package:instagram_stories_flutter/stories_builder.dart';

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
  ///stories to be displayed to the user
  final List<Stories> allStories = [
    Stories(
      url:
          'https://sa.uat.adanione.com/-/media/Project/Campaigns/PaymentCategory/bill-payments-icon-svgs/ic_mobile_recharge.png',
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
          StoryItem(
            url:
                'https://sa.uat.adanione.com/-/media/Project/Campaigns/PaymentCategory/Sample/Fastag.png',
            title: 'title22',
            createdDate: 'createdDate22',
          ),
        ]),
    Stories(
      url:
          'https://sa.uat.adanione.com/-/media/Project/Campaigns/PaymentCategory/bill-payments-icon-svgs/ic_mobile_recharge.png',
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
        child: Text('Custom Widget'),
      ),
    ),
  ];

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
              child: StoriesBuilder(
                allStories: allStories,
                // openedStoryColor: Colors.black,
                // unopenedStoryColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
