import 'package:flutter/material.dart';

import '../../constants.dart';
import '../chatScreen/carousel_message_body.dart';
import '../chatScreen/message_list.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Text completion",
          style: TextStyle(color: Colors.white70),
        ),
        backgroundColor: bgColor,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () => {},
              icon: Icon(
                Icons.add,
                size: 30,
                color: Colors.white70,
              ))
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                size: 30,
                color: Colors.white70,
              ),
              onPressed: () {},
            );
          },
        ),
      ),
      backgroundColor: bgColor,
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Column(
      //     children: [
      //       Expanded(child: MessegeList()),
      //     ],
      //   ),
      // ),
      body: ListView(
        children: [],
      ),
    );
  }
}
