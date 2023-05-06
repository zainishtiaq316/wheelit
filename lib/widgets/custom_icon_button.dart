// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    required this.icon, required this.onpress,
  }) : super(key: key);
  final Widget icon;
  final VoidCallback onpress;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onpress,
        constraints: const BoxConstraints.tightFor(width: 40),
        color: Colors.black54,
        icon: icon,
        splashRadius: 22,
      ),
    );
  }
}
