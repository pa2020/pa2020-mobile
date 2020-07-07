
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Spinner{

  static Widget startSpinner(Color color) {
    return Center(
      child: SpinKitDualRing(
        color: color,
      ),
    );
  }
}