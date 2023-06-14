import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({super.key, required this.data});
  final String data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: MediaQuery.of(context).size.width * 0.15),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Text(
              data,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.nunito(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.020),
          Container(
            color: const Color.fromARGB(20, 158, 158, 158),
            height: MediaQuery.of(context).size.width * 0.002,
            width: MediaQuery.of(context).size.width * 0.67,
          ),
        ],
      ),
    );
  }
}
