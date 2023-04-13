import 'package:chatgpt/util/constants/constants.dart';
import 'package:flutter/material.dart';

class GenderWidget extends StatefulWidget {
  const GenderWidget({super.key});
  @override
  State<GenderWidget> createState() => _GenderWidgetState();
}

class _GenderWidgetState extends State<GenderWidget> {
  final isMale = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: isMale
                    ? cgSecondary
                    : const Color.fromARGB(20, 158, 158, 158)),
            child: const Icon(
              Icons.male_rounded,
              color: Colors.white70,
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.15),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: !isMale
                    ? cgSecondary
                    : const Color.fromARGB(20, 158, 158, 158)),
            child: const Icon(
              Icons.female_rounded,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
