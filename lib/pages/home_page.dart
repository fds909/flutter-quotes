import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:quotes/models/saved_quote_model.dart';
import 'package:quotes/styles/color_palette.dart';
import 'package:quotes/repositories/quotes_repository.dart';
import 'package:quotes/models/saved_quotes_list.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<String> mainQuoteFuture;
  final savedQuotes = SavedQuotesList();

  @override
  void initState() {
    super.initState();

    // inizializza la lista delle quote salvate
    // e aggiorna lo stato automaticamente
    savedQuotes.initialize().then((_) {
      setState(() {});
    });

    setState(() {
      mainQuoteFuture = QuotesRepositories.get();
    });
  }

  void createQuote(String text) {
    if (!savedQuotes.contains(text)) {
      savedQuotes.create(text).then((_) {
        setState(() {});
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Quote already saved"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void refreshQuote() {
    setState(() {
      mainQuoteFuture = QuotesRepositories.get();
    });
  }

  void removeQuote(SavedQuotesModel quote) {
    setState(() {
      savedQuotes.delete(savedQuotes.quotes[0]).then((_) {
        setState(() {});
      });
    });
  }

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
        child: FutureBuilder<String>(
            future: mainQuoteFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Stack(
                  children: [
                    Center(
                      child: AutoSizeText(
                        "${snapshot.data!}",
                        maxLines: 7,
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
                            onPressed: refreshQuote,
                          ),
                          SizedBox(width: 5),
                          // Save to Favourites IconButton
                          IconButton(
                            icon: Icon(
                              savedQuotes.contains(snapshot.data!)
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_outline,
                              color: savedQuotes.contains(snapshot.data!)
                                  ? Colors.red
                                  : Colors.red.shade300,
                              size: 40,
                            ),
                            onPressed: () => createQuote(snapshot.data!),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }

  Widget sectionListSavedQuotes() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => GestureDetector(
          onDoubleTap: () => removeQuote(savedQuotes.quotes[index]),
          child: Container(
            decoration: BoxDecoration(
              color: colors[index % colors.length],
            ),
            height: 250,
            padding: EdgeInsets.all(20),
            child: AutoSizeText(
              savedQuotes.quotes[index].text,
              maxLines: 7,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        childCount: savedQuotes.quotes.length,
      ),
    );
  }
}
