import 'package:flutter/material.dart';

class CreateButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final String text;
  final double borderRadius;
  final Color? borderColor;
  final double borderWidth;
  final void Function()? onTap;

  const CreateButton({
    super.key,
    required this.text,
    required this.width,
    required this.height,
    required this.color,
    required this.onTap,
    this.borderRadius = 13,
    this.borderColor,
    this.borderWidth = 2,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onHover: (value) {},
        onTap: onTap,
        child: Container(
          color: color,
          decoration: (borderColor != null)
              ? BoxDecoration(
                  border: Border.all(
                      color: borderColor ?? color, width: borderWidth),
                  borderRadius: BorderRadius.circular(borderRadius),
                )
              : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                ),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
