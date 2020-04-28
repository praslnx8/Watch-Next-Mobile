import 'package:flutter/material.dart';

class ArcBannerImage extends StatelessWidget {
  ArcBannerImage(this.imageUrl);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return ClipPath(
      clipper: ArcClipper(),
      child: Image.network(
        imageUrl,
        width: screenWidth,
        height: 160.0,
        fit: BoxFit.cover
      ),
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height - 20);


    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
