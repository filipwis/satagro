import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.onTap,
    required this.title,
    super.key,
  });

  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 12.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          color: Colors.green,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
