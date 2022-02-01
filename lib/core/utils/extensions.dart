import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Transition { basic, sharedAxis }

extension ContextExtension on BuildContext {
  double getHeight({double factor = 1}) {
    assert(factor != 0);
    return MediaQuery.of(this).size.height * factor;
  }

  double getWidth({double factor = 1}) {
    assert(factor != 0);
    return MediaQuery.of(this).size.width * factor;
  }

  double get height => getHeight();
  double get width => getWidth();

  TextTheme get textTheme => Theme.of(this).textTheme;

  Future<T?> push<T>(Widget page, {transition = Transition.basic}) {
    switch (transition) {
      case Transition.sharedAxis:
        return Navigator.push<T>(
          this,
          CupertinoPageRoute(builder: (context) => page),
        );

      default:
        return Navigator.push<T>(
          this,
          MaterialPageRoute(builder: (context) => page),
        );
    }
  }

  Future<bool> pop<T>([T? result]) => Navigator.maybePop(this, result);
}

extension ClickableExtension on Widget {
  Widget onTap(VoidCallback action, {bool opaque = true}) {
    return GestureDetector(
      behavior: opaque ? HitTestBehavior.opaque : HitTestBehavior.deferToChild,
      onTap: action,
      child: this,
    );
  }
}
