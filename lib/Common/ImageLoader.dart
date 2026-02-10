import 'package:flutter/material.dart';

class ImageLoader extends StatefulWidget {
  String imageUrl;
  final double width;
  final double height;
  final double radius;
  final BoxFit boxFit;

  ImageLoader({
    Key? key,
    required this.imageUrl,
    this.width = double.infinity,
    this.radius = 0.0,
    this.boxFit = BoxFit.cover,
    this.height = double.infinity,
  }) : super(key: key);

  @override
  _ImageWithFallbackDecorationState createState() =>
      _ImageWithFallbackDecorationState();
}

class _ImageWithFallbackDecorationState extends State<ImageLoader> {
  bool _isImageLoaded = true; // Assume image loads initially

  @override
  Widget build(BuildContext context) {
    // if(widget.imageUrl.isEmpty){
    //   widget.imageUrl = "https://media.istockphoto.com/id/494388654/photo/this-partys-on-fire.jpg?s=612x612&w=0&k=20&c=euuLNz7r93Q6bo8yO4GsvBpD8gqebhU7403p48JPMt4=";
    // }
    if (!widget.imageUrl.contains("http")) {
      widget.imageUrl = "https://" + widget.imageUrl;
    }
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.grey[300], // Default background color
        borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
        image: widget.imageUrl.isNotEmpty ||
            _isImageLoaded ||
            widget.imageUrl != ""
            ? DecorationImage(
          image: NetworkImage(widget.imageUrl),
          fit: widget.boxFit,
          onError: (error, stackTrace) {
            print(error);
            setState(() {
              _isImageLoaded =
              false; // Set image load status to false on error
            });
          },
        )
            : null, // No image decoration if loading fails
      ),
      child:
      widget.imageUrl.isEmpty || _isImageLoaded || widget.imageUrl != ""
          ? null // If image loads, show nothing extra
          : Icon(
        // Display fallback icon if loading fails
        Icons.image,
        color: Colors.grey[100],
        size: 30,
      ),
    );
  }
}

