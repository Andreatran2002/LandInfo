import 'package:flutter/material.dart';


class TextField extends StatelessWidget {
  const TextField({
    required this.textHint,
    required this.inputType,
    required this.maxLine,
    Key? key
  }) : super(key: key);

  final String textHint;
  final TextInputType inputType;
  final int maxLine ;
  static const kTextBoxHeight = 65.0;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
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
