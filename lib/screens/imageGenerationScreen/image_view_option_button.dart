import 'package:chatgpt/providers/image_generation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageViewOption extends StatelessWidget {
  const ImageViewOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ImageGenerationProvider>(
        builder: (context, value, child) => DropdownButton<String>(
              value: value.GetImageViewType,
              onChanged: (newValue) {
                value.changeImageViewType(newValue!);
              },
              icon: const Icon(Icons.view_list), // Icon for the dropdown button
              items: [
                'grid',
                'list',
              ].map((viewTypeString) {
                return DropdownMenuItem<String>(
                  value: viewTypeString,
                  child: Row(
                    children: [
                      Icon(viewTypeString == 'Grid View'
                          ? Icons.grid_on
                          : Icons.list),
                      const SizedBox(width: 8),
                      Text(viewTypeString),
                    ],
                  ),
                );
              }).toList(),
            ));
  }
}
