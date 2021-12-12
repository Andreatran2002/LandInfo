import 'dart:async';

import 'package:flutter/material.dart';


class TextField extends StatelessWidget {
  const TextField({
    required this.textHint,
    required this.inputType,
    required this.maxLine,
    required this.controller,
    Key? key
  }) : super(key: key);

  final String textHint;
  final TextInputType inputType;
  final int maxLine ;
  final TextEditingController controller;
  static const kTextBoxHeight = 65.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: MediaQuery
          .of(context)
          .size
          .width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0)
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLine,
        keyboardType: inputType,
        decoration: InputDecoration(
            hintText: textHint,
            hintStyle: const TextStyle(
                color: Colors.black12,
                fontSize: 12
            ),
            contentPadding: const EdgeInsets.only(left: 20, right: 20)
        ),
      ),
    );

  }
}
