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
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 62, 0, 170)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
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
  int _count = 0;
  String _result = '';
  late final List<Map<String, dynamic>> _values = [];

  _row(int index) {
    return Row(
      children: [
        Text('ID: $index'),
        SizedBox(width: 30),
        Expanded(
          child: TextFormField(
            onChanged: (val) {
              _onUpdate(index, val);
            },
          ),
        ),
      ],
    );
  }

  _onUpdate(int index, String val) async {
    int foundKey = -1;
    for (var map in _values) {
      if (map.containsKey("id")) {
        if (map["id"] == index) {
          foundKey = index;
          break;
        }
      }
    }
    if (-1 != foundKey) {
      _values.removeWhere((map) {
        return map["id"] == foundKey;
      });
    }
    late Map<String, dynamic> json = {
      "id": index,
      "value": {"text": val},
    };
    _values.add(json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Form'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              setState(() {
                _count++;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              setState(() {
                _count = 0;
                _result = '';
              });
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: ListView(
                shrinkWrap: true,
                children: List.generate(_count, (index) {
                  return _row(index);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
