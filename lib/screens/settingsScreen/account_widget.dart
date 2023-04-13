import 'package:flutter/material.dart';

import '../../util/constants/constants.dart';

class AccountWidget extends StatelessWidget {
  const AccountWidget({super.key, required this.accountImage});
  final String accountImage;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.width * 0.15,
        width: MediaQuery.of(context).size.width * 0.15,
        decoration: const BoxDecoration(
            color: Color.fromARGB(37, 124, 130, 143),
            borderRadius: BorderRadius.all(Radius.circular(100))),
        child: Center(
            child: Image.asset(
          accountImage,
          height: MediaQuery.of(context).size.width * 0.08,
          width: MediaQuery.of(context).size.width * 0.08,
        )));
  }
}
