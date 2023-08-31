// ignore_for_file: prefer_const_constructors

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controller = TextEditingController();
  String results = "Resultas are be shown here";
  late OpenAI openAI;
  @override
  void initState() {
    super.initState();
    openAI = OpenAI.instance.build(
      token: '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',
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 25)),
      enableLog: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: Text(results)),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(hintText: "Type Here..."),
                  ),
                ),
                ElevatedButton(
                  child: Icon(Icons.send),
                  onPressed: () {},
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
