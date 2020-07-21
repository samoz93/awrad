import 'package:awrad/Consts/ThemeCosts.dart';
import 'package:flutter/material.dart';

class AwradBtn extends StatelessWidget {
  final String txt;
  final Function onPressed;
  const AwradBtn({Key key, this.onPressed, this.txt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(8),
      width: media.width * 0.9,
      height: media.height * 0.1,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black38, offset: Offset(0, 5), blurRadius: 5)
          ],
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: Color(0xffFEC4A3), width: 1),
          color: AppColors.mainColorSelected),
      child: FlatButton(
        child: Text(
          txt,
          style: AppThemes.buttonTextStyle,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
