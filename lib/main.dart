import 'package:cached_network_image/cached_network_image.dart';
import 'package:copy_and_share/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomepage(),
    );
  }
}

class MyHomepage extends StatefulWidget {
  const MyHomepage({Key? key}) : super(key: key);

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  @override
  Widget build(BuildContext context) {
    final notify = dummyNotification[0];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample app'),
      ),
      body: Center(
        child: listviewObject(notify: notify),
      ),
      // ignore: dead_code
    );
  }
}

class listviewObject extends StatelessWidget {
  const listviewObject({
    Key? key,
    required this.notify,
  }) : super(key: key);

  final Notifications notify;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        CachedNetworkImage(
          imageUrl: notify.photoIcon,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: notify.photoIcon))
                  .then((_) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Image url copied clipboard")));
              });
            },
            child: const Text('Copy Url')),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
            onPressed: () async {
              await Share.share(notify.photoIcon);
            },
            child: const Text('share'))
      ],
    );
  }
}
