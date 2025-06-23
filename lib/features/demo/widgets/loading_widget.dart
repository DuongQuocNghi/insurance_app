import 'package:flutter/material.dart';
import 'package:insurance_app/core/widgets/rotating_widget.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RotatingWidget(
        child: Icon(Icons.autorenew_rounded, size: 96,),
      ),
    );
  }
}
