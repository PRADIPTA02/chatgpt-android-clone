import 'package:chatgpt/providers/auth_provider.dart';
import 'package:chatgpt/util/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GenderWidget extends StatelessWidget {
  const GenderWidget({required this.gender, Key? key}) : super(key: key);
    final String gender;

  @override
  Widget build(BuildContext context) {
        print(gender);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Consumer<AuthProvider>(
        builder: (context, value, child) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: gender == "Male"
                      ? cgSecondary
                      : const Color.fromARGB(20, 158, 158, 158)),
              child: const Icon(
                Icons.male_rounded,
                color: Colors.white70,
              ),
            ),
            // SizedBox(width: MediaQuery.of(context).size.width * 0.12),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: gender == "Female"
                      ? cgSecondary
                      : const Color.fromARGB(20, 158, 158, 158)),
              child: const Icon(
                Icons.female_rounded,
                color: Colors.white70,
              ),
            ),
            // SizedBox(width: MediaQuery.of(context).size.width * 0.12),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: gender == "Other"
                      ? cgSecondary
                      : const Color.fromARGB(20, 158, 158, 158)),
              child: const Icon(
                Icons.transgender_rounded,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
