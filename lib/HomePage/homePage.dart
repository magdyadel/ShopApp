import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text("My Shop"),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.library_music),
            onPressed: () {
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.cyanAccent,
        child: ListView(
          children: [
            ListTile(
              title: Text("Log Out"),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}