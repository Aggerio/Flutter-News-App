import 'package:flutter/material.dart';
//import 'package:news_app/models/PostInfo.dart';
import 'package:news_app/widgets/HomePage.dart';

//import 'package:provider/provider.dart';
//import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//import 'package:flutter/foundation.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
  //  await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
  //}

  runApp(
      //MultiProvider(
      // //providers: [
      // ChangeNotifierProvider(
      ///    create: (_) => PostInfo(),
      //   ),
      // ],
      // child: MyApp(),
      //),
      const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
