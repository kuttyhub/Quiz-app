import 'package:flutter/material.dart';

import '../../../constants.dart';

class DefaultOption extends StatelessWidget {
  final int index;
  final String text;
  final Function press;

  const DefaultOption({Key key, this.index, this.text, this.press}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(top: kDefaultPadding),
        padding: EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          border: Border.all(color:kGrayColor),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "${index + 1}. $text",
                style: TextStyle(color:kGrayColor, fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              height: 26,
              width: 26,
              decoration: BoxDecoration(
                color:Colors.transparent,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color:kGrayColor),
              ),
              child:  null
            )
          ],
        ),
      ),
    );
  }
}