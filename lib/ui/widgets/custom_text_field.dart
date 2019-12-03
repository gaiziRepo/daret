import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final Color baseColor;
  final Color borderColor;
  final Color errorColor;
  final TextInputType inputType;
  final bool obscureText;
  final Function validator;
  final Function onChanged;
  final Function onTap;
  final double height;
  final double verticalPad;

  CustomTextField(
      {this.hint,
      this.controller,
      this.onChanged,
      this.baseColor,
      this.borderColor,
      this.errorColor,
      this.inputType = TextInputType.text,
      this.obscureText = false,
      this.validator,
      this.onTap,
      this.height = 65,
      this.verticalPad = 6});

  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  Color currentColor;

  @override
  void initState() {
    super.initState();
    currentColor = widget.borderColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.height,
        child: Card(
          elevation: 0.0,
          color: Colors.white70,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: currentColor, width: 0.5),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: widget.verticalPad),
            child: TextField(
              onTap: widget.onTap,
              obscureText: widget.obscureText,
              onChanged: (text) {
                if (widget.onChanged != null) {
                  widget.onChanged(text);
                }
                setState(() {
                  if (!widget.validator(text) || text.length == 0) {
                    currentColor = widget.errorColor;
                  } else {
                    currentColor = widget.baseColor;
                  }
                });
              },
              keyboardType: widget.inputType,
              controller: widget.controller,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: widget.baseColor,
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w300,
                ),
                border: InputBorder.none,
                hintText: widget.hint,
              ),
            ),
          ),
    ));
  }
}
