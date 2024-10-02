import 'package:flutter/material.dart';
import 'package:news/widgets/custom_news_list.dart';

class NewsCategoryScreen extends StatefulWidget {
  const NewsCategoryScreen({super.key});

  @override
  State<NewsCategoryScreen> createState() => _NewsCategoryScreenState();
}

class _NewsCategoryScreenState extends State<NewsCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Category"),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(icon: Icon(Icons.school_outlined), text: "Education"),
              Tab(icon: Icon(Icons.computer_outlined), text: "Technology"),
              Tab(icon: Icon(Icons.business), text: "Business"),
              Tab(icon: Icon(Icons.sports), text: "sports"),
              Tab(icon: Icon(Icons.how_to_vote), text: "Politics"),
            ],
            indicatorColor: Colors.white,
            labelColor: Colors.lightBlueAccent,
            unselectedLabelColor: Colors.blueGrey,
          ),
        ),
        body: TabBarView(children: [
          CustomCard(
            height: height,
            width: width,
            fsize: 16.0,
            calledFrom: "category",
            category: 'education',
          ),
          CustomCard(
            height: height,
            width: width,
            fsize: 16.0,
            calledFrom: "category",
            category: 'technology',
          ),
          CustomCard(
            height: height,
            width: width,
            fsize: 16.0,
            calledFrom: "category",
            category: 'business',
          ),
          CustomCard(
            height: height,
            width: width,
            fsize: 16.0,
            calledFrom: "category",
            category: 'sports',
          ),
          CustomCard(
            height: height,
            width: width,
            fsize: 16.0,
            calledFrom: "category",
            category: "politics",
          ),
        ]),
      ),
    );
  }
}
