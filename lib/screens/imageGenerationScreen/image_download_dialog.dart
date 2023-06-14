import 'package:chatgpt/providers/image_generation_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../util/constants/constants.dart';

class ImageDownloadingDialog extends StatelessWidget {
  const ImageDownloadingDialog({super.key, required this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Consumer<ImageGenerationProvider>(
      builder:(context, value, child) => AlertDialog(
          backgroundColor: secondaryColor,
          shadowColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          actionsAlignment: MainAxisAlignment.spaceAround,
          title:  Text(
            "Downloading Image",
            style: GoogleFonts.nunito(color: Colors.white),
          ),
          content:  LinearProgressIndicator(
            backgroundColor: Colors.white70,
            value: value.progress,
            valueColor: const AlwaysStoppedAnimation<Color>(cgSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () => {
                 value.downloadImage(url: imageUrl),
              },
              child:  Text(
                'Download In Folder',
                style: GoogleFonts.nunito(color: cgSecondary),
              ),
            ),
          ],
        ),
    );
  }
}
