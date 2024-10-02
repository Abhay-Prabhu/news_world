import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/ui/category/category_screen.dart';
import 'package:news/ui/top_headlines_screen.dart';
import 'package:news/widgets/custom_news_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreeenStateState();
}

class _HomeScreeenStateState extends State<HomeScreen> {
  String? selectedOption = 'The Hindu';

  final Map<String, String> newsSources = {
    'The Hindu': 'the-hindu',
    'BBC': 'bbc',
    'ABC News': 'abc',
    'NBC-News': 'nbc',
    'Fox News': 'foxnews',
    'Al Jazeera': 'aljazeera'
  };

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const NewsCategoryScreen(),
            ),
          ),
          icon: Image.asset(
            "assets/images/category_icon.png",
            width: height * 0.03,
            height: height * 0.03,
          ),
        ),
        title: Text(
          "NEWS WORLD",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: width * 0.06,
          ),
        ),
        centerTitle: true,
        actions: [
          DropdownButton<String>(
            value: selectedOption,
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.black,
            ),
            elevation: 16,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 16,
            ),
            underline: Container(
              height: 1,
              width: 0.5,
              color: Colors.grey,
            ),
            onChanged: (String? newValue) {
              setState(() {
                selectedOption = newValue;
              });
            },
            dropdownColor: Colors.white,
            items:
                newsSources.keys.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: height * 0.02,
            horizontal: width * 0.00,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: height * 0.02,
                ),
                child: TopHeadlineWidget(
                  selectedOption: newsSources[selectedOption]!,
                  height: height,
                  width: width,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: height * 0.02,
                ),
                child: CustomCard(
                  height: height,
                  width: width,
                  fsize: 16.0,
                  calledFrom: "newsSources",
                  category: "",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
