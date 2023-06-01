import 'package:flutter/material.dart';

extension Layout on BuildContext {
  bool get isKeyboardOpen {
    final size = MediaQuery.of(this).viewInsets.bottom;
    switch (size) {
      case 0:
        return false;
      default:
        return true;
    }
  }

  double get height {
    return MediaQuery.of(this).size.height;
  }

  double get width {
    return MediaQuery.of(this).size.width;
  }
}
