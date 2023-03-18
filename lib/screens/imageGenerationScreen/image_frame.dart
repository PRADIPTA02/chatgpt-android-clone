import 'package:flutter/material.dart';

import '../../constants.dart';

class ImageFrame extends StatelessWidget {
  const ImageFrame({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        child: Image.network(
          url,
          fit: BoxFit.fill,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                color: cgSecondary,
                backgroundColor: Color.fromRGBO(73, 111, 101, 1),
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        ),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(3)),
      ),
    );
  }
}
