import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewWidget extends StatefulWidget {
  String fileUrl;
  ImageViewWidget({Key? key,required this.fileUrl}) : super(key: key);

  @override
  State<ImageViewWidget> createState() => _ImageViewWidgetState();
}

class _ImageViewWidgetState extends State<ImageViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("PhotoView"),
      ),
      // add this body tag with container and photoview widget
      body: Container(
          child: PhotoView(
            imageProvider: NetworkImage(widget.fileUrl),
          )),
    );
  }
}
