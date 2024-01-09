import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:news_app/models/NewsModel.dart';
import 'package:news_app/logic/database_interaction.dart';

class NewsDisplay extends StatefulWidget {
  NewsModel info;
  NewsDisplay({super.key, required this.info});

  NewsModel get newsInfo => info;
  @override
  State<NewsDisplay> createState() => MyNewsDisplay(info: info);
}

class MyNewsDisplay extends State<NewsDisplay> {
  bool _bookmarked = false;

  NewsModel info;
  MyNewsDisplay({required this.info});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final browser = InAppBrowser();

        final settings = InAppBrowserClassSettings(
          browserSettings: InAppBrowserSettings(
              hideUrlBar: false,
              toolbarTopBackgroundColor: Colors.white,
              presentationStyle: ModalPresentationStyle.POPOVER),
        );
        browser.addMenuItem(
          InAppBrowserMenuItem(
            id: 0,
            title: 'Menu Item 0',
            iconColor: Colors.black,
            order: 0,
            onClick: () {
              browser.webViewController?.reload();
            },
          ),
        );

        browser.openUrlRequest(
          urlRequest: URLRequest(url: WebUri(info.url)),
          settings: settings,
        );
      },
      onHorizontalDragEnd: (details) {
        void showSnackBar(BuildContext context) {
          const snackBar = SnackBar(
            content: Text('This would be removed from favorites on refresh'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

        showSnackBar(context);

        removeArticle(info);
      },
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 600,
        ),
        child: Card(
          elevation: 10.0,
          color: Colors.white,
          shadowColor: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  top: 10.0,
                ),
                child: Text(info.title.split(' - ')[0],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      overflow: TextOverflow.visible,
                    )),
              ),
              //Padding(
              //  padding: const EdgeInsets.only(
              //    left: 100.0,
              //  ),
              //  child: Text(info.author,
              //      style: const TextStyle(
              //        fontWeight: FontWeight.bold,
              //        fontSize: 20.0,
              //        overflow: TextOverflow.visible,
              //      )),
              //),
              Image.network(
                info.urlToImage,
                height: 250,
                fit: BoxFit.fitWidth,
                // When image is loading from the server it takes some time
                // So we will show progress indicator while loading
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                // When dealing with networks it completes with two states,
                // complete with a value or completed with an error,
                // So handling errors is very important otherwise it will crash the app screen.
                // I showed dummy images from assets when there is an error, you can show some texts or anything you want.
                errorBuilder: (context, exception, stackTrace) {
                  return const Text("Could not load image");
                },
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Text(
                  info.description,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 200.0),
                child: ElevatedButton.icon(
                  label: const Text("BookMark"),
                  icon: (_bookmarked == true)
                      ? const Icon(Icons.favorite)
                      : const Icon(Icons.favorite_border),
                  onPressed: () {
                    setState(
                      () {
                        if (_bookmarked) {
                          _bookmarked = false;
                          removeArticle(info);
                        } else {
                          _bookmarked = true;

                          insertArticle(info);
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
