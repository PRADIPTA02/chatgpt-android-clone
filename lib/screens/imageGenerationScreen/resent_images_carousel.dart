import 'package:chatgpt/util/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ResentImagesCarousel extends StatefulWidget {
  const ResentImagesCarousel({super.key});

  @override
  State<ResentImagesCarousel> createState() => _ResentImagesCarouselState();
}

class _ResentImagesCarouselState extends State<ResentImagesCarousel> {
  final List<String> images = [
    'assets/images/img1.png',
    'assets/images/img2.png',
    'assets/images/img3.png',
    'assets/images/img4.png',
    'assets/images/img5.png'
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: images.map((img) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: cglasscolor,
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage(img),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: images.map((img) {
            int index = images.indexOf(img);
            return Container(
              width: currentIndex == index?20:8.0,
              height: 8.0,
              margin: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 2.0,
              ),
              decoration: BoxDecoration(
                color: currentIndex == index
                    ? cgSecondary.withOpacity(0.9)
                    : cgSecondary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10)
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
