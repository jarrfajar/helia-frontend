// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerListKamar extends StatefulWidget {
  @override
  State<ShimmerListKamar> createState() => _ShimmerListKamarState();
}

class _ShimmerListKamarState extends State<ShimmerListKamar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350.0,
      child: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: const Color.fromARGB(255, 230, 230, 230),
            highlightColor: Colors.white,
            child: Container(
              width: 230.0,
              margin: const EdgeInsets.only(right: 20.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 236, 236, 236),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        },
      ),
    );
  }
}
