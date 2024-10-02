import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news/iew_model/list_news_view.dart';
import 'package:news/iew_model/news_category_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news/ui/news_detail_screen.dart';

class CustomCard extends StatefulWidget {
  final double height;
  final double width;
  final double fsize;
  final String calledFrom;
  final String category;

  const CustomCard({
    super.key,
    required this.height,
    required this.width,
    required this.fsize,
    required this.calledFrom,
    required this.category,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  late Future newsFuture;
  final newsList = NewsSourcesView();
  final newsCategory = NewsCategoryView();
  final format = DateFormat("MMMM dd, yyyyy");

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  @override
  void didUpdateWidget(CustomCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Check if category or calledFrom has changed
    if (oldWidget.category != widget.category || oldWidget.calledFrom != widget.calledFrom) {
      _fetchNews();
    }
  }

  // Fetch news based on the widget's calledFrom and category
  void _fetchNews() {
    setState(() {
      newsFuture = widget.calledFrom == "category"
          ? newsCategory.fetchNewsSources(widget.category)
          : newsList.fetchNewsSources();
    });
  }

  void _retryFetchNews() {
    _fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    String truncateText(String text, int limit) {
      return text.length > limit ? "${text.substring(0, limit)}.." : "$text..";
    }

    final padding1 = EdgeInsets.symmetric(
        horizontal: widget.width * 0.05, vertical: widget.height * 0.01);
    final padding2 = EdgeInsets.symmetric(
        horizontal: widget.width * 0.005 > 8 ? widget.width * 0.05 : 4,
        vertical: widget.height * 0.01 > 8 ? widget.height * 0.01 : 8);

    return FutureBuilder(
        future: newsFuture,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitFadingCircle(
                size: 40,
                color: Colors.blue.shade400,
              ),
            );
          }else if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                          "Failed to load headlines. Please try again later."),
                      ElevatedButton(
                        onPressed: () {
                          _retryFetchNews();
                          // Trigger re-fetch
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }  else if (snapshot.hasData) {
            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.data.length,
                itemBuilder: (context, index) {
                  DateTime datetime = DateTime.parse(
                      snapshot.data!.data![index].publishedAt!.toString());
                  final iurl = snapshot.data!.data![index].image.toString();
                  final imageUrl = iurl ?? 'https://via.placeholder.com/150';
                  return InkWell(
                      onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsDetailsScreen(
                                date: snapshot.data!.data![index].publishedAt
                                    .toString(),
                                source: snapshot.data!.data![index].source
                                    .toString(),
                                description: snapshot
                                    .data!.data![index].description
                                    .toString(),
                                imgurl: snapshot.data!.data![index].image
                                    .toString(),
                              ),
                            ),
                          ),
                      child: Padding(
                          padding: padding1,
                          child: Card(
                              color: Colors.white,
                              elevation: 4,
                              shadowColor: Colors.black26,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Container(
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomLeft: Radius.circular(20))),
                                  height: widget.height * 0.25,
                                  width: widget.width * 0.9,
                                  child: Row(children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                      ),
                                      child: CachedNetworkImage(
                                        height: widget.height * 0.25,
                                        width: widget.width * 0.4,
                                        imageUrl: iurl ??
                                            'https://via.placeholder.com/150',
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error,
                                                color: Colors.red),
                                        placeholder: (context, url) =>
                                            Container(
                                          color: Colors.grey.shade200,
                                          child: const Center(
                                            child: SpinKitFadingCircle(
                                                color: Colors.blue),
                                          ),
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: padding2,
                                      child: Container(
                                        alignment: Alignment.bottomCenter,
                                        height: widget.height,
                                        width: widget.width * 0.42,
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
                                                widget.calledFrom == "category"
                                                    ? truncateText(
                                                        snapshot
                                                            .data!
                                                            .data![index]
                                                            .description
                                                            .toString(),
                                                        50)
                                                    : truncateText(
                                                        snapshot.data!
                                                            .data![index].title
                                                            .toString(),
                                                        50),
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.045,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
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
                                                          20),
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.035,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: Text(
                                                      truncateText(
                                                          format
                                                              .format(datetime),
                                                          5),
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
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ])))));

                });
          } else {
            return const Center(child: Text('No news sources available.'));
          }
        });
  }
}
