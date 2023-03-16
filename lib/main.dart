import 'package:flutter/material.dart';
import 'package:implosion/data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jordan - Charged Up',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red).copyWith(background: Colors.white)
      ),
      home: const MainPage(title: 'MainPage'),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red).copyWith(background: Colors.black)
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});


  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late TextEditingController _controller;

  //the silly
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = DataRecord.scouter;
  }


  void updateScouter(String s) {
    DataRecord.scouter = s.trim();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("jordan")),
      backgroundColor: Colors.white,
      body: Center(
        child: Row(
          children: [
            const Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text("Scouter Name", textScaleFactor: 1.5,),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0)),
                  TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    controller: _controller,

                  )
                ],
              )
            ),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
          ]
        )
      ),
    );
  }
}
