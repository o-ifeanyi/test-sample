import 'package:example/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _joke = '';
  bool _isLoading = false;
  Api _api = Api(client: http.Client());

  void _getJoke() async {
    setState(() {
      _isLoading = true;
    });
    _joke = await _api.getRandomJoke();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Unit test example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_joke, textAlign: TextAlign.center),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _getJoke,
                    child: Text('Get Joke'),
                  )
          ],
        ),
      ),
    );
  }
}
