import 'package:flutter/material.dart';
import 'package:kittens/providers/playlist.dart';
import 'package:kittens/routes/post_route.dart';
import 'package:kittens/widgets/posts_widget.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => Playlist(),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'M9',
      theme: ThemeData(
          accentColor: Colors.pinkAccent,
          primarySwatch: Colors.blue,
          brightness: Brightness.dark),
      home: MyHomePage(title: 'M9'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Scaffold(
                        appBar: AppBar(
                          title: Text("Playlist"),
                        ),
                        body: Consumer<Playlist>(
                          builder: (BuildContext context, Playlist value,
                              Widget child) {
                            return Column(
                                children: value.items
                                    .map((item) => Text(item.title))
                                    .toList());
                          },
                        ))),
              );
            }
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                title: Text(""), icon: Icon(Icons.library_music)),
            BottomNavigationBarItem(
                title: Text(""), icon: Icon(Icons.featured_play_list))
          ],
        ),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          title: Text(widget.title),
        ),
        body: Center(
            child:
                Posts()) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
