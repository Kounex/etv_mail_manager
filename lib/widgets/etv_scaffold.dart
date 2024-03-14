import 'package:base_components/base_components.dart';
import 'package:flutter/cupertino.dart';

class ETVScaffold extends StatelessWidget {
  final Iterable<Widget> children;

  const ETVScaffold({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return WebScaffold(
      verticalPadding: DesignSystem.spacing.x92,
      children: this.children,
    );
  }
}
