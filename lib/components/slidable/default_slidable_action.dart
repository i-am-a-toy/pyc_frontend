import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DefaultSlidableAction extends StatelessWidget {
  final void Function(BuildContext)? onPressed;
  final String label;
  final IconData icon;
  final Color color;

  const DefaultSlidableAction({
    super.key,
    required this.onPressed,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      onPressed: onPressed,
      backgroundColor: color,
      foregroundColor: Colors.white,
      icon: icon,
      label: label,
    );
  }
}
