import 'package:flutter/material.dart';

import '../constants.dart';

class InternetCheckDialog extends StatelessWidget {
  const InternetCheckDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.signal_wifi_off,color: Colors.red,),
          SizedBox(width: 10),
          Text(
            'No Internet Connection',
            style: TextStyle(
              color: Colors.red,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.white70,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Please check your internet connection and try again.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text(
            'OK',
            style: TextStyle(
              color: cgSecondary,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 10.0,
      backgroundColor: bgColor,
      shadowColor: Colors.transparent,
    );
  }
}
