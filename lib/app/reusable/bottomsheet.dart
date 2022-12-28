// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:helia/app/color/colors.dart';

class RsBottomSheet extends StatefulWidget {
  final double height;
  final String title;
  final String cancel;
  final String yes;
  final Widget? widget;
  final Widget? contentTitle;
  final Widget? contentSubTitle;
  final bool isLoading;
  final Function() onPressCancel;
  final Function() onPressYes;

  const RsBottomSheet({
    Key? key,
    required this.height,
    required this.title,
    required this.cancel,
    required this.yes,
    this.widget,
    this.contentTitle,
    this.contentSubTitle,
    required this.isLoading,
    required this.onPressCancel,
    required this.onPressYes,
  }) : super(key: key);

  @override
  State<RsBottomSheet> createState() => _RsBottomSheetState();
}

class _RsBottomSheetState extends State<RsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: widget.height,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10.0),
          Container(
            width: 100,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            widget.title,
            style: const TextStyle(
              color: ColorSelect.black,
              fontWeight: FontWeight.bold,
              fontSize: 26.0,
            ),
          ),
          const SizedBox(height: 10.0),
          const Divider(color: Colors.grey),
          // BODY
          widget.widget ?? Container(),
          widget.contentTitle ?? Container(),
          widget.contentSubTitle ?? Container(),
          const SizedBox(height: 10.0),
          // BUTTON
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorSelect.greenSoft,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onPressed: widget.onPressCancel,
                    child: Text(
                      widget.cancel,
                      style: const TextStyle(
                        color: ColorSelect.green,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorSelect.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onPressed: widget.onPressYes,
                    child: widget.isLoading
                        ? const SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              color: Colors.white,
                            ),
                          )
                        : Text(widget.yes),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}
