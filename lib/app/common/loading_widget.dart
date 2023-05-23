import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:school_management_app/app/common/style.dart';

loadingWidget([double? height]) {
  return Center(
    child: SizedBox(
      height: height ?? 60,
      child: const LoadingIndicator(
        indicatorType: Indicator.ballSpinFadeLoader,
        colors: [primaryColor],
        // pathBackgroundColor: red,
      ),
    ),
  );
}
