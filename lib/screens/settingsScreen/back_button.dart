import 'package:flutter/material.dart';

import '../../util/constants/constants.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key,required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Container(
                height: MediaQuery.of(context).size.width * 0.12,
          width: MediaQuery.of(context).size.width * 0.12,
          decoration: const BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(5))
          ),
          child: const Center(
            child: Icon(Icons.keyboard_arrow_right,color: Colors.white,),
          ),
      ),
    );
  }
}