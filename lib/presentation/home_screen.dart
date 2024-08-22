import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled3/presentation/process_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home screen', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Set valid API base URL in order to continue',
                    ),
                  ),
                ),
                Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Icon(Icons.compare_arrows),
                      ),
                      Expanded(child: TextField(
                        autocorrect: false,
                        controller: _controller,
                      )),
                    ]
                )

              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                onPressed: (){
                  final urlAPI = _controller.text;
                  if (_isValidURL(urlAPI)) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProcessScreen(urlAPI: urlAPI),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter a valid URL')),
                    );
                  }
                },
                style: Theme.of(context).elevatedButtonTheme.style,
                child: const Padding(
                  padding:  EdgeInsets.all(13.0),
                  child: Text('Start counting process', style: TextStyle(color: Colors.black),),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  bool _isValidURL(String url) {
    final urlPattern = r'^(https?:\/\/)?([a-zA-Z0-9.-]+)\.([a-zA-Z]{2,6})(\/[a-zA-Z0-9.-]*)*\/?$';
    final result = RegExp(urlPattern).hasMatch(url);
    return result;
  }
}