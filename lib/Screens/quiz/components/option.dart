import 'package:flutter/material.dart';

import '../../../constants.dart';

class Option extends StatelessWidget {
  const Option({
    Key key,
    @required this.index,
    @required this.text,
    @required this.press,
    @required this.isAnswered,
    @required this.correctAns,
    @required this.selectedAns,
  }) : super(key: key);

  final int index;
  final String text;
  final Function press;
  final bool isAnswered;
  final int correctAns;
  final int selectedAns;

  @override
  Widget build(BuildContext context) {
    Color getTheRightColor() {
      print("get color");
      if (isAnswered) {
        if (index == correctAns) {
          return kGreenColor;
        } else if (index == selectedAns && selectedAns != correctAns) {
          return kRedColor;
        }
      }
      return kGrayColor;
    }

    IconData getTheRightIcon() {
      return getTheRightColor() == kRedColor ? Icons.close : Icons.done;
    }

    return InkWell(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(top: kDefaultPadding),
        padding: EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          border: Border.all(color: getTheRightColor()),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${index + 1}. $text",
              style: TextStyle(color: getTheRightColor(), fontSize: 16),
            ),
            Container(
              height: 26,
              width: 26,
              decoration: BoxDecoration(
                color: getTheRightColor() == kGrayColor
                    ? Colors.transparent
                    : getTheRightColor(),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: getTheRightColor()),
              ),
              child: getTheRightColor() == kGrayColor
                  ? null
                  : Icon(getTheRightIcon(), size: 16),
            )
          ],
        ),
      ),
    );
  }
}
