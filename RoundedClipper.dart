import 'package:flutter/material.dart';

class RoundedClipper extends CustomClipper<Path> {
  var differenceInHeights = 0;

  RoundedClipper(int differenceInHeights) {
    this.differenceInHeights = differenceInHeights;
  }

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - differenceInHeights);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
