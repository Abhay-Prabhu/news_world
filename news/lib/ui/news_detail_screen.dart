import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class NewsDetailsScreen extends StatelessWidget {
  final String imgurl;
  final String source;
  final String date;
  final String description;

  const NewsDetailsScreen({
    super.key,
    required this.imgurl,
    required this.source,
    required this.date,
    required this.description,
  });
  // final format = DateFormat("MMMM dd, yyyyy");
  

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        title: const Text(
          'News Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the image on top
            ClipRRect(
              borderRadius:const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: CachedNetworkImage(
                imageUrl: imgurl.isNotEmpty
                    ? imgurl
                    : 'https://via.placeholder.com/600x400.png?text=No+Image+Available',
                width: width,
                height: height * 0.35,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: SpinKitFadingCircle(color: Colors.blue),
                ),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, color: Colors.red),
              ),
            ),

            // Text content below the image
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // News Source
                  Text(
                    source.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Date Published
                  Text(
                    date,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // News Description
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.5, // Line height for better readability
                    ),
                    textAlign: TextAlign.justify,
                    maxLines: 10, // Adjust based on needs
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
