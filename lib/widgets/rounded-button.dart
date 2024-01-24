import 'package:flutter/material.dart';
import '../pallete.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.buttonName,
    this.onClick,
  }) : super(key: key);

  final String buttonName;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      width: size.width * 1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: kBlue,
      ),
      child: TextButton(
        onPressed: onClick,
        child: Text(
          buttonName,
          style: kBodyText.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
