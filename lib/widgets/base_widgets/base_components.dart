import 'package:flutter/material.dart';

class TextSub extends StatelessWidget {
  const TextSub({
    super.key,
    required this.title,
    required this.align,
    required this.fontSize,
    required this.weight,
    required this.color,
  });

  final String title;
  final TextAlign align;
  final double fontSize;
  final FontWeight weight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: align,
      style: TextStyle(fontSize: fontSize, fontWeight: weight, color: color),
    );
  }
}

class TextTitle extends StatelessWidget {
  const TextTitle({
    super.key,
    required this.title,
    required this.align,
    required this.fontSize,
    required this.weight,
    required this.color,
  });

  final String title;
  final TextAlign align;
  final double fontSize;
  final FontWeight weight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: align,
      style: TextStyle(fontSize: fontSize, fontWeight: weight, color: color),
    );
  }
}

class FieldContainer extends StatelessWidget {
  const FieldContainer({
    super.key,
    required this.controllerText,
    required this.title,
    required this.hintText,
    required this.obscureText
  });

  final TextEditingController controllerText;
  final String title;
  final String hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 15,
        ),
        TextFormField(
          controller: controllerText,
          textAlign: TextAlign.start,
          obscureText: obscureText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16
          ),
          decoration: InputDecoration(
            hintText: hintText,
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            hintStyle: const TextStyle(fontSize: 10, color: Colors.white60),
          ),
        ),
      ],
    );
  }
}

class ButtonContainer extends StatelessWidget {
  const ButtonContainer({
    super.key,
    required this.width,
    required this.height,
    required this.color,
    required this.opacity,
    required this.radiusCircular,
    required this.title,
    required this.sizeFont,
    required this.fontWeight,
    required this.fontColor,
  });

  final int width;
  final int height;
  final Color color;
  final double opacity;
  final double radiusCircular;
  final String title;
  final double sizeFont;
  final FontWeight fontWeight;
  final Color fontColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / width,
      height: MediaQuery.of(context).size.height / height,
      decoration: BoxDecoration(
          color: color.withOpacity(opacity),
          borderRadius: BorderRadius.circular(radiusCircular)),
      child: Center(
          child: Text(
        title,
        style: TextStyle(
          fontSize: sizeFont,
          fontWeight: fontWeight,
          color: fontColor,
        ),
      )),
    );
  }
}
