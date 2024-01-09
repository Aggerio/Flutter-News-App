import 'package:flutter/material.dart';
import 'package:news_app/widgets/FavoriteArticles.dart';
import 'package:news_app/widgets/NewsDisplay.dart';
import 'package:news_app/logic/network_logic.dart';
import 'package:news_app/models/NewsModel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String current_category = "general";
  String current_country = "in";

  List<String> category_list = [
    'general',
    'business',
    'entertainment',
    'health',
    'science',
    'sports',
    'technology',
  ];
  List<String> country_list = [
    'India',
    'USA',
    'Australia',
    'Russia',
    'France',
    'United Kingdom',
  ];
  Map<String, String> country_map = {
    "India": "in",
    "USA": "us",
    "Australia": "au",
    "Russia": "ru",
    "France": "fr",
    "United Kingdom": "gb"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: const Text('User Name'),
              accountEmail: const Text('user.name@email.com'),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: FlutterLogo(size: 42.0),
              ),
              otherAccountsPictures: <Widget>[
                const CircleAvatar(
                  backgroundColor: Colors.yellow,
                  child: Text('A'),
                ),
                const CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Text('B'),
                )
              ],
            ),
            ListTile(
              title: const Text('My Account'),
              onTap: () {},
              /*
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyHomePage(),
                ),
              ),*/
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {},
              /*
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyHomePage(),
                ),
              ),
              */
            ),
            ListTile(
              title: const Text('About'),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Newzzz App'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              child: const Icon(Icons.favorite),
              onPressed: () {
                //print('pressed favorites page!');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FavoriteArticles(),
                  ),
                );
              },
            ),
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Category: ',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownMenu<String>(
                initialSelection: category_list.first,
                onSelected: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    current_category = value!;
                  });
                },
                dropdownMenuEntries:
                    category_list.map<DropdownMenuEntry<String>>(
                  (String value) {
                    return DropdownMenuEntry<String>(
                        value: value, label: value);
                  },
                ).toList(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Country: ',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownMenu<String>(
                initialSelection: country_list.first,
                onSelected: (String? value) {
                  // This is called when the user selects an item.
                  // TODO
                  setState(() {
                    current_country = country_map[value]!;
                  });
                },
                dropdownMenuEntries:
                    country_list.map<DropdownMenuEntry<String>>(
                  (String value) {
                    return DropdownMenuEntry<String>(
                        value: value, label: value);
                  },
                ).toList(),
              ),
            ],
          ),
          FutureBuilder<List<NewsModel>>(
            future: getNewsArticles(current_category, current_country),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('No news available.'),
                );
              } else {
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      setState(
                        () {
                          current_country = current_country;
                          current_category = current_category;
                        },
                      );
                    },
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        NewsModel news = snapshot.data![index];
                        return NewsDisplay(info: news);
                      },
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
