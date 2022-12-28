// ignore_for_file: camel_case_types

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:helia/app/color/colors.dart';

class RsTabBar extends StatefulWidget {
  final double? width;
  // final Function(String value) onChanged;
  final String label;
  final Color color;
  final Color colorText;

  const RsTabBar({
    Key? key,
    required this.width,
    // required this.onChanged,
    required this.label,
    required this.color,
    required this.colorText,
  }) : super(key: key);

  @override
  State<RsTabBar> createState() => _RsTabBarState();
}

class _RsTabBarState extends State<RsTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: widget.width,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: const BorderRadius.all(Radius.circular(50.0)),
        border: Border.all(
          color: ColorSelect.green,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          widget.label,
          style: TextStyle(
            color: widget.colorText,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
