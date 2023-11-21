import 'package:flutter/material.dart';

class Arrows extends StatelessWidget {
  const Arrows({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(child: SizedBox()),
              buttonWidget(
                Icons.arrow_circle_up_outlined,
                () {},
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
          Row(
            children: [
              buttonWidget(
                Icons.arrow_circle_left_outlined,
                () {},
              ),
              const Expanded(child: SizedBox()),
              buttonWidget(
                Icons.arrow_circle_right_outlined,
                () {},
              )
            ],
          ),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              buttonWidget(
                Icons.arrow_circle_down_outlined,
                () {},
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }

  buttonWidget(IconData iconData, VoidCallback function) {
    return Expanded(
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          function.call();
        },
        icon: Icon(
          iconData,
          size: 85,
        ),
      ),
    );
  }
}