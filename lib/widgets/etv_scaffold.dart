// @JS()
// library stringify;

import 'package:base_components/base_components.dart';
import 'package:flutter/material.dart';
// import 'package:js/js.dart';

// Calls invoke JavaScript `JSON.stringify(obj)`.
// @JS('disableFlutterScroll')
// external String disableFlutterScroll();

class ETVScaffold extends StatelessWidget {
  final Iterable<Widget> children;
  final bool fadeIn;

  const ETVScaffold({
    super.key,
    required this.children,
    this.fadeIn = true,
  });

  @override
  Widget build(BuildContext context) {
    return WebScaffold(
      verticalPadding: DesignSystem.spacing.x92,
      fadeIn: this.fadeIn,
      children: this.children,
    );
  }
}
