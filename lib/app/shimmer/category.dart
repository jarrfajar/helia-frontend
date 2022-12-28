// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:helia/app/color/colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCategory extends StatefulWidget {
  const ShimmerCategory({
    Key? key,
  }) : super(key: key);

  @override
  State<ShimmerCategory> createState() => _ShimmerCategoryState();
}

class _ShimmerCategoryState extends State<ShimmerCategory> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.0,
      child: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: const Color.fromARGB(255, 230, 230, 230),
            highlightColor: Colors.white,
            child: Container(
              width: 100.0,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.only(right: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(50.0),
                ),
                border: Border.all(
                  color: ColorSelect.green,
                  width: 2,
                ),
              ),
              child: const Center(
                child: Text(
                  'category.title!',
                  style: TextStyle(
                    color: ColorSelect.green,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
