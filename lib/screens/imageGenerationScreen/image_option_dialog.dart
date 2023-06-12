import 'package:chatgpt/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/image_generation_provider.dart';
import '../../util/constants/constants.dart';

class ImageOptionDialog extends StatelessWidget {
  const ImageOptionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ImageGenerationProvider,AuthProvider>(
        builder: (context, imageGenerationProvider,authProvider, _)=>AlertDialog(
      backgroundColor: secondaryColor,
      shadowColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      elevation: 0,
      title: Text(
        'Image Generation Options',
        style: GoogleFonts.nunito(
            color: Colors.white, fontWeight: FontWeight.bold),
      ),
      content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Picture Size:',
                style: GoogleFonts.nunito(
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              DropdownButton<String>(
                dropdownColor: cbgColor,
                style: GoogleFonts.nunito(
                  fontSize: 15,
                  color: cgSecondary,
                  fontWeight: FontWeight.bold
                ),
                value: imageGenerationProvider.SizeOfImages,
                items: ['256x256', '512x512','1024x1024']
                    .map((size) => DropdownMenuItem<String>(
                          value: size,
                          child: Text(size),
                        ))
                    .toList(),
                onChanged: (selectedSize) {
                  imageGenerationProvider.setSizeOfImages(selectedSize!);
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Select Number of Images:',
                style: GoogleFonts.nunito(
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              DropdownButton<int>(
                style: GoogleFonts.nunito(
                  fontSize: 15,
                  color: cgSecondary,
                  fontWeight: FontWeight.bold
                ),
                dropdownColor: bgColor,
                value: imageGenerationProvider.numberOfImages,
                items: List.generate(10, (index) => index + 1)
                    .map((number) => DropdownMenuItem<int>(
                          value: number,
                          child: Text(number.toString()),
                        ))
                    .toList(),
                onChanged: (selectedNumber) {
                  imageGenerationProvider.setNumberOfImages(selectedNumber!);
                },
              ),
            ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Add your logic here when the user clicks the "Cancel" button.
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: GoogleFonts.nunito(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        TextButton(
          onPressed: () async{
            Navigator.of(context).pop();
            await authProvider.imageSizeUpdate(
              image_size:imageGenerationProvider.SizeOfImages,
              num: imageGenerationProvider.numberOfImages,
            );
          },
          child: Text(
            'OK',
            style: GoogleFonts.nunito(
                color: cgSecondary, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ));
  }
}
