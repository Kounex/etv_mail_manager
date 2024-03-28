@JS()
library stringify;

import 'package:base_components/base_components.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:js/js.dart';

// Calls invoke JavaScript `JSON.stringify(obj)`.
@JS('disableFlutterScroll')
external String disableFlutterScroll();

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
      children: [
        // ElevatedButton(
        //   onPressed: () => disableFlutterScroll(),
        //   child: const Text('TEST'),
        // ),
        ...this.children,
      ],
    );
  }
}

class TestScaffold extends StatefulWidget {
  final Iterable<Widget> children;

  final double? horizontalPadding;
  final double? verticalPadding;

  final bool fadeIn;
  final bool staggered;

  const TestScaffold({
    super.key,
    required this.children,
    this.horizontalPadding,
    this.verticalPadding,
    this.fadeIn = false,
    this.staggered = true,
  });

  @override
  State<TestScaffold> createState() => _TestScaffoldState();
}

class _TestScaffoldState extends State<TestScaffold> {
  final ScrollController _controller = ScrollController();
  ScrollPhysics? _physics;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerMove: (move) {
        if (move.delta.dy > 0 &&
            _controller.offset <= 0 &&
            _physics is! NeverScrollableScrollPhysics) {
          setState(() => _physics = const NeverScrollableScrollPhysics());
        } else if (move.delta.dy < 0 &&
            _physics is! AlwaysScrollableScrollPhysics) {
          setState(() => _physics = const AlwaysScrollableScrollPhysics());
        }
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal:
                  this.widget.horizontalPadding ?? DesignSystem.spacing.x24),
          child: CustomScrollView(
            controller: _controller,
            physics: _physics,
            slivers: [
              SliverList(
                delegate: widget.fadeIn
                    ? SliverChildListDelegate.fixed(
                        List.from(
                          widget.children.mapIndexed(
                            (index, child) => Fader(
                              delay: this.widget.staggered
                                  ? Duration(milliseconds: 75 * index)
                                  : Duration.zero,
                              child: child,
                            ),
                          ),
                        ),
                      )
                    : SliverChildBuilderDelegate(
                        (context, index) =>
                            index == 0 || index == widget.children.length + 1
                                ? SizedBox(
                                    height: (this.widget.verticalPadding ??
                                            DesignSystem.spacing.x24) +
                                        MediaQuery.paddingOf(context).top,
                                  )
                                : widget.children.elementAt(index - 1),
                        childCount: widget.children.length + 2,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
