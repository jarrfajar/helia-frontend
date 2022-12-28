// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerRecent extends StatefulWidget {
  const ShimmerRecent({
    Key? key,
  }) : super(key: key);

  @override
  State<ShimmerRecent> createState() => _ShimmerRecentState();
}

class _ShimmerRecentState extends State<ShimmerRecent> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 209, 209, 209),
                  blurRadius: 10,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Shimmer.fromColors(
                  baseColor: const Color.fromARGB(255, 230, 230, 230),
                  highlightColor: Colors.white,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 236, 236, 236),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: const Color.fromARGB(255, 230, 230, 230),
                      highlightColor: Colors.white,
                      child: Container(
                        height: 30,
                        width: 130,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 236, 236, 236),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Shimmer.fromColors(
                      baseColor: const Color.fromARGB(255, 230, 230, 230),
                      highlightColor: Colors.white,
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 236, 236, 236),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
