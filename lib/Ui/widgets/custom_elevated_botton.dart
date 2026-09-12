import 'package:evently_project/utils/AppColors.dart';
import 'package:evently_project/utils/size_utils.dart';
import 'package:flutter/material.dart';

class CustomElevatedBotton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? padding;
  const CustomElevatedBotton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.borderColor,
    this.padding
  });

  @override
  Widget build(BuildContext context) {
    var height =context.height;
    // var width =context.width;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side:BorderSide(
            width: 2,
            color:borderColor ?? AppColors.transparent
           )
        ),
        padding: EdgeInsets.symmetric(
          vertical: padding?? height*0.01
        ),
        backgroundColor: backgroundColor ?? Theme.of(context).cardColor,
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
