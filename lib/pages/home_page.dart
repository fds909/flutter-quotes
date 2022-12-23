import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:quotes/styles/color_palette.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          sectionMainQuote(),
          sectionListSavedQuotes(),
        ],
      ),
    );
  }

  // Main section that shows the loaded quote, giving the user the opportunity
  // to reload it or save it to favourites
  Widget sectionMainQuote() {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(20),
        // imposto un'altezza relativa in base alle dimensioni dello schermo
        height: MediaQuery.of(context).size.height * 0.8,
        child: Stack(
          children: [
            Center(
              child: Text(
                "lorem ipsum lorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsum",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              // Icons
              child: Row(
                children: [
                  // Reload IconButton
                  IconButton(
                    icon: Icon(
                      Icons.replay_outlined,
                      color: Colors.grey.shade400,
                      size: 40,
                    ),
                    onPressed: () {},
                  ),
                  SizedBox(width: 5),
                  // Save to Favourites IconButton
                  IconButton(
                    icon: Icon(
                      Icons.favorite_outline,
                      color: Colors.red.shade300,
                      size: 40,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionListSavedQuotes() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Container(
          decoration: BoxDecoration(
            color: colors[index % colors.length],
          ),
          height: 250,
          padding: EdgeInsets.all(20),
          child: Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        childCount: 10,
      ),
    );
  }
}
