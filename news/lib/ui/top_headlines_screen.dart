import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news/data/models/top_headlines_model.dart.dart';
import 'package:news/iew_model/top_headline_view.dart';
import 'package:news/ui/news_detail_screen.dart';

class TopHeadlineWidget extends StatefulWidget {
  final double width;
  final double height;
  final String selectedOption;

  const TopHeadlineWidget(
      {super.key,
      required this.height,
      required this.width,
      required this.selectedOption});

  @override
  State<TopHeadlineWidget> createState() => _TopHeadlineWidgetState();
}

class _TopHeadlineWidgetState extends State<TopHeadlineWidget> {
  late Future<TopHeadline> _futureHeadlines;
  final topHeadlineView = TopHeadlineView();
  @override
  void initState() {
    super.initState();
    _futureHeadlines = topHeadlineView.fetchTopHeadlines(widget.selectedOption);
  }

  @override
  void didUpdateWidget(covariant TopHeadlineWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedOption != widget.selectedOption) {
      _futureHeadlines = topHeadlineView.fetchTopHeadlines(
          widget.selectedOption); // Re-fetch data when selectedOption changes
    }
  }

  String truncateText(String text, int limit) {
    return text.length > limit
        ? "${text.substring(0, limit)}.." //
        : "$text..";
  }

  final format = DateFormat("MMMM dd, yyyyy");

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: widget.height * .55,
        width: widget.width * 1,
        child: FutureBuilder<TopHeadline>(
            future: _futureHeadlines,
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SpinKitFadingCircle(
                    size: 40,
                    color: Colors.blue.shade400,
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                          "Failed to load headlines. Please try again later."),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _futureHeadlines = topHeadlineView
                                .fetchTopHeadlines(widget.selectedOption);
                          }); // Trigger re-fetch
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              } else {
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data?.data!.length,
                    itemBuilder: (context, index) {
                      DateTime datetime = DateTime.parse(
                          snapshot.data!.data![index].publishedAt!.toString());
                      return SizedBox(
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NewsDetailsScreen(
                                              date: format.format(datetime),
                                              description: snapshot.data!
                                                  .data![index].description!
                                                  .toString(),
                                              imgurl: snapshot
                                                  .data!.data![index].image
                                                  .toString()
                                                  .toString(),
                                              source: snapshot.data!
                                                  .data![index].source
                                                  .toString(),
                                            )));
                              },
                              child:
                                  Stack(alignment: Alignment.center, children: [
                                Container(
                                  height: widget.height * 0.6,
                                  width: widget.width * 0.9,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: widget.height * 0.02,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      height: widget.height * 0.6,
                                      width: widget.width * 0.7,
                                      imageUrl: snapshot
                                              .data?.data![index].image
                                              .toString() ??
                                          'https://via.placeholder.com/150',
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: SpinKitFadingCircle(
                                            color: Colors.blue),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.error,
                                              color: Colors.red),
                                          const SizedBox(height: 5),
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                _futureHeadlines =
                                                    topHeadlineView
                                                        .fetchTopHeadlines(widget
                                                            .selectedOption);
                                              }); // Retry logic
                                            },
                                            child: Text(
                                              'Retry',
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.05),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    bottom: widget.height * 0.01,
                                    child: Card(
                                      shadowColor:
                                          Colors.black.withOpacity(0.1),
                                      elevation: 2,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: widget.height * 0.01,
                                            vertical: widget.width * 0.01),
                                        child: Container(
                                          alignment: Alignment.bottomCenter,
                                          height: widget.height * 0.2,
                                          width: widget.width * 0.7,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  truncateText(
                                                      snapshot
                                                          .data!
                                                          .data![index]
                                                          .description
                                                          .toString(),
                                                      100),
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.05,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const Spacer(),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        truncateText(
                                                            snapshot
                                                                .data!
                                                                .data![index]
                                                                .source
                                                                .toString(),
                                                            30),
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: Colors.black,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.04,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Expanded(
                                                      child: Text(
                                                        truncateText(
                                                            format.format(
                                                                datetime),
                                                            12),
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: Colors.black,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.04,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ))
                              ])));
                    });
              }
            }));
  }
}
