import 'package:base_components/base_components.dart';
import 'package:flutter/material.dart';

class CommonCardChildWrapper extends StatefulWidget {
  final Widget? child;
  final List<Widget>? children;
  final Alignment alignment;
  final bool scrollable;
  final bool paddingForScrollbar;

  const CommonCardChildWrapper({
    super.key,
    this.child,
    this.children,
    this.alignment = Alignment.topLeft,
    this.scrollable = true,
    this.paddingForScrollbar = true,
  }) : assert(child != null || children != null);

  @override
  State<CommonCardChildWrapper> createState() => _CommonCardChildWrapperState();
}

class _CommonCardChildWrapperState extends State<CommonCardChildWrapper> {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    Widget child = Align(
      alignment: this.widget.alignment,
      child: this.widget.child,
    );

    if (this.widget.children != null || this.widget.scrollable) {
      child = Scrollbar(
        controller: _controller,
        thumbVisibility: true,
        child: this.widget.child != null
            ? SingleChildScrollView(
                controller: _controller,
                clipBehavior: Clip.hardEdge,
                child: Padding(
                  padding: EdgeInsets.only(
                    right: this.widget.paddingForScrollbar
                        ? DesignSystem.spacing.x12
                        : 0,
                  ),
                  child: child,
                ),
              )
            : ListView.separated(
                controller: _controller,
                shrinkWrap: true,
                clipBehavior: Clip.hardEdge,
                padding: EdgeInsets.only(
                  right: this.widget.paddingForScrollbar
                      ? DesignSystem.spacing.x12
                      : 0,
                ),
                separatorBuilder: (context, index) => const BaseDivider(),
                itemBuilder: (context, index) => this.widget.children![index],
                itemCount: this.widget.children!.length,
              ),
      );
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: DesignSystem.size.x256,
      ),
      child: child,
    );
  }
}
