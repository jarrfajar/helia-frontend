// ignore_for_file: camel_case_types

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:helia/app/color/colors.dart';
import 'package:shimmer/shimmer.dart';

class RsGrid extends StatefulWidget {
  final String name;
  final String price;
  final String image;
  final String category;
  final Widget icon;

  const RsGrid({
    Key? key,
    required this.name,
    required this.price,
    required this.image,
    required this.category,
    required this.icon,
  }) : super(key: key);

  @override
  State<RsGrid> createState() => _RsGridState();
}

class _RsGridState extends State<RsGrid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: widget.image,
            imageBuilder: (context, imageProvider) => Container(
              height: 120,
              width: 120,
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
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 236, 236, 236),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
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
              color: ColorSelect.black,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.price,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: ColorSelect.black,
                ),
              ),
              widget.icon,
            ],
          ),
        ],
      ),
    );
  }
}
