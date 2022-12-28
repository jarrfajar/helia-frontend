// ignore_for_file: camel_case_types

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:helia/app/color/colors.dart';
import 'package:shimmer/shimmer.dart';

class RsCard extends StatefulWidget {
  final String name;
  final String category;
  final String price;
  final String review;
  final Widget icon;
  final String image;
  // final Function(String value) onChanged;

  const RsCard({
    Key? key,
    required this.name,
    // required this.onChanged,
    required this.review,
    required this.image,
    required this.price,
    required this.category,
    required this.icon,
  }) : super(key: key);

  @override
  State<RsCard> createState() => _RsCardState();
}

class _RsCardState extends State<RsCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CachedNetworkImage(
                imageUrl: widget.image,
                imageBuilder: (context, imageProvider) => Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                placeholder: (context, url) => Shimmer.fromColors(
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
              ),
              // const SizedBox(width: 10.0),
              SizedBox(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: ColorSelect.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.category,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    // Text("100 reviews"),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: widget.price,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(text: ' / night'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(width: 5.0),
              SizedBox(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          widget.review,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        const Text("Reviews"),
                      ],
                    ),
                    widget.icon,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
