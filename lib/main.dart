import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: MyApplication(),
  ));
}

class MyApplication extends StatelessWidget {
  const MyApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text("Chat app"),
          centerTitle: true,
          backgroundColor: Colors.green[600],
        ),
        body: Container(
          padding: EdgeInsets.all(3),
        ),
      ),
    );
  }
}



