import 'dart:io';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: './assests/env/storage.env');
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
      token: dotenv.env['APP_SECRET'],
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 25)),
      enableLog: true,
    );
  }

  void chatCompleteWithSSE() {
    print(Platform.environment.keys);
    final request = ChatCompleteText(
        messages: [Messages(role: Role.user, content: controller.text)],
        maxToken: 200,
        model: GptTurbo0631Model());

    openAI.onChatCompletionSSE(request: request).listen((it) {
      debugPrint(it.choices?.last.message?.content);
    });
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
                    decoration: const InputDecoration(hintText: "Type Here..."),
                  ),
                ),
                ElevatedButton(
                  child: const Icon(Icons.send),
                  onPressed: () => chatCompleteWithSSE(),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
