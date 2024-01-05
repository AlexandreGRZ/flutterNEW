import 'package:flutter/material.dart';

class noTransitionPage<T> extends MaterialPageRoute<T> {
  noTransitionPage({
    required WidgetBuilder builder,
    RouteSettings? settings,
  }) : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}
