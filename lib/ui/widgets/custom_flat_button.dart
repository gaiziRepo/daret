import 'package:flutter/material.dart';

class CustomFlatButton extends StatelessWidget {
  final String title;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback onPressed;
  final Color color;
  final Color splashColor;
  final Color borderColor;
  final double borderWidth;
  final Icon icon;

  CustomFlatButton(
      {this.title,
      this.textColor,
      this.fontSize,
      this.fontWeight,
      this.onPressed,
      this.color,
      this.splashColor,
      this.borderColor,
      this.borderWidth,
      this.icon});

  @override
  Widget build(BuildContext context) {
    if ( icon != null ) {
      return FlatButton.icon(
        onPressed: onPressed,
        color: color,
        splashColor: splashColor,
        icon: icon,
        label: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            title,
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              decoration: TextDecoration.none,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontFamily: "OpenSans",
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: BorderSide(
            color: borderColor,
            width: borderWidth,
          ),
        ),
      );
    } else {
      return FlatButton(
        onPressed: onPressed,
        color: color,
        splashColor: splashColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            title,
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              decoration: TextDecoration.none,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontFamily: "OpenSans",
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: BorderSide(
            color: borderColor,
            width: borderWidth,
          ),
        ),
      );
    }

  }
}
