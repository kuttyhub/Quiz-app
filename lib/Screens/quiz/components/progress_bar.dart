import 'package:flutter/material.dart';

import '../../../constants.dart';

// ignore: must_be_immutable
class ProgressBar extends StatelessWidget {
  Animation<double> _animation;
  ProgressBar(this._animation);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 30,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF3F4768), width: 2),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Stack(
        children: [
          // LayoutBuilder provide us the available space for the conatiner
          // constraints.maxWidth needed for our animation
          LayoutBuilder(
            builder: (context, constraints) => Container(
              // from 0 to 1 it takes 60s
              width: constraints.maxWidth * _animation.value,
              decoration: BoxDecoration(
                gradient: kPrimaryGradient,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${(_animation.value * 60).round()} sec"),
                  FittedBox(
                      child: Icon(
                        Icons.alarm,
                        size: 20,
                      ),
                      fit: BoxFit.cover),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
