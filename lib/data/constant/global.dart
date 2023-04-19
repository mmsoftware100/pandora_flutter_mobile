import "package:flutter/material.dart";
import "package:hexcolor/hexcolor.dart";

// Color primaryColor = HexColor('#DC54FE');
// Color accentColor = HexColor('#8A02AE');

Color primaryColor = HexColor('#69001e');
Color accentColor = HexColor('#8A02AE');

// Design color
// Color primaryColor= HexColor('#FFC867');
// Color accentColor= HexColor('#FF3CBD');

// Our Logo Color
// Color primaryColor= HexColor('#D44CF6');
// Color accentColor= HexColor('#5E18C8');

// Our Logo Blue Color
//Color primaryColor= HexColor('#651BD2');
//Color accentColor= HexColor('#320181');

Color parseColor(String color) {
  String hex = color.replaceAll("#", "");
  if (hex.isEmpty) hex = "ffffff";
  if (hex.length == 3) {
    hex = '${hex.substring(0, 1)}${hex.substring(0, 1)}${hex.substring(1, 2)}${hex.substring(1, 2)}${hex.substring(2, 3)}${hex.substring(2, 3)}';
  }
  Color col = Color(int.parse(hex, radix: 16)).withOpacity(1.0);
  return col;
}