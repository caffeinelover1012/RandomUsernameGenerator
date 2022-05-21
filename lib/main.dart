import 'package:flutter/material.dart';
import 'package:username_gen/username_gen.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _light = true;
  @override
  Widget build(BuildContext context) {
    int _idx = -1;
    ThemeData _theme = (_light) ? ThemeData.dark() : ThemeData.light();
    return MaterialApp(
      theme: _theme,
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: "Random Username Generator",
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Center(
            child: Text("Random UserName Generator"),
          ),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Center(child: WelcomeText()),
            ]),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int idx) {
            _idx = idx;
            if (idx == 1) {
              print("Changing _state");
              setState(() {
                _theme = (_idx == 1) ? ThemeData.dark() : ThemeData.light();
                _light = !_light;
              });
            }
            if (idx == 0) {
              SystemNavigator.pop();
            }
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.arrow_back_sharp), label: "Exit"),
            BottomNavigationBarItem(
                icon: Icon(Icons.dark_mode), label: "Dark Mode"),
          ],
        ),
      ),
    );
  }
}

class WelcomeText extends StatefulWidget {
  const WelcomeText({Key? key}) : super(key: key);

  @override
  State<WelcomeText> createState() => _WelcomeTextState();
}

class _WelcomeTextState extends State<WelcomeText> {
  String username = UsernameGen().generate();
  void createNewUsername() {
    setState(() {
      username = UsernameGen().generate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          username,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 30),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: createNewUsername, child: const Text("Next")),
            const SizedBox(
              width: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: username));
                  var snackBar = SnackBar(content: Text('Copied $username'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: const Text("Copy"))
          ],
        ),
      ],
    );
  }
}
