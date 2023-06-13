import 'package:chatgpt/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../util/constants/constants.dart';

class ImagePickerButton extends StatelessWidget {
  const ImagePickerButton(
      {super.key,
      required this.ontap,
      required this.title,
      required this.icon});
  final VoidCallback ontap;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, value, child) => InkWell(
        onTap: ontap,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.height * 0.06,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: cglasscolor, width: 2)),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: cgSecondary,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(title,
                  style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70)),
            ],
          )),
        ),
      ),
    );
  }
}
