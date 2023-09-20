import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/constants.dart';

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({required this.text});

  @override
  _DescriptionTextWidgetState createState() => new _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 150) {
      firstHalf = widget.text.substring(0, 150);
      secondHalf = widget.text.substring(150, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      // padding: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: secondHalf.isEmpty
          ? new Text(firstHalf,
          style: GoogleFonts.padauk(
              color: Colors.grey[600],
              letterSpacing: 1,
              fontSize: newsFontSize,
              fontWeight: FontWeight.normal),
          textAlign: TextAlign.left,
      )
          : new Column(
        children: <Widget>[
          new Text(flag ? (firstHalf + "...") : (firstHalf + secondHalf),
      style: GoogleFonts.padauk(
          color: Colors.grey[600],
          letterSpacing: 1,
          fontSize: newsFontSize,
          fontWeight: FontWeight.normal),
      textAlign: TextAlign.justify,
      ),
          new InkWell(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Text(
                  flag ? "see more..." : "show less",
                  style: new TextStyle(color: Colors.blue),
                ),
              ],
            ),
            onTap: () {
              setState(() {
                flag = !flag;
              });
            },
          ),
        ],
      ),
    );
  }
}