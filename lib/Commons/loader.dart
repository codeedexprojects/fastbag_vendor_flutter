import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevents closing when tapped outside
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: Colors.blue,
            size: 50,
          ),
        ),
      );
    },
  );
}
