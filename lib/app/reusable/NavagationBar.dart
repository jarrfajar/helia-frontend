import 'package:flutter/material.dart';
import 'package:helia/app/color/colors.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NavagationBar extends StatefulWidget {
  final int controller;
  final Function(int value) onChanged;
  final String? label;

  const NavagationBar({
    Key? key,
    required this.controller,
    required this.onChanged,
    this.label,
  }) : super(key: key);

  @override
  State<NavagationBar> createState() => _NavagationBarState();
}

class _NavagationBarState extends State<NavagationBar> {
  @override
  Widget build(BuildContext context) {
    return SalomonBottomBar(
      currentIndex: widget.controller,
      onTap: (i) => widget.onChanged(i),
      items: [
        SalomonBottomBarItem(
          icon: const Icon(Icons.home),
          title: const Text("Home"),
          selectedColor: ColorSelect.green,
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.search),
          title: const Text("Search"),
          selectedColor: ColorSelect.green,
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.my_library_books),
          title: const Text("Booking"),
          selectedColor: ColorSelect.green,
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.person_outline_rounded),
          title: const Text("Profile"),
          selectedColor: ColorSelect.green,
        ),
      ],
    );
  }
}
