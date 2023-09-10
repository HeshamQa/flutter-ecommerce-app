import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String buttonText;
  GestureTapCallback onTap;

  CustomButton({
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        margin: EdgeInsets.all(8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
