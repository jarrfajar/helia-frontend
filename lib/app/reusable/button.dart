// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class RsButton extends StatefulWidget {
  final Function() onPress;
  final String label;
  final Color color;
  final bool isLoading;

  const RsButton({
    Key? key,
    required this.onPress,
    required this.color,
    required this.isLoading,
    required this.label,
  }) : super(key: key);

  @override
  State<RsButton> createState() => _RsButtonState();
}

class _RsButtonState extends State<RsButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.maxFinite,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        // onPressed: () {},
        onPressed: widget.onPress,
        child: widget.isLoading
            ? const SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                ),
              )
            : Text(
                widget.label,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
      ),
    );
  }
}
