import 'package:base_components/base_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app.dart';
import '../../../../models/etv_mail/etv_mail.dart';

class MailBoxTitle extends StatelessWidget {
  final MailType type;
  final Iterable<ETVMail>? mails;
  final bool isFiltered;

  const MailBoxTitle({
    super.key,
    required this.type,
    this.mails,
    this.isFiltered = false,
  });

  Future<void> _handleCopy(BuildContext context) async {
    try {
      String? clipboard = this.mails?.fold<String>('',
          (previousValue, element) => '$previousValue ${element.address}, ');

      clipboard = clipboard?.substring(0, clipboard.length - 2);

      await Clipboard.setData(
        ClipboardData(
          text: clipboard ?? '',
        ),
      );

      if (context.mounted) {
        scaffoldMessengerKey.currentState!.showSnackBar(
          const SnackBar(
            content: Text('Copied to clipboard!'),
          ),
        );
      }
    } catch (_) {
      if (context.mounted) {
        scaffoldMessengerKey.currentState!.showSnackBar(
          const SnackBar(
            content: Text('Could not copy!'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final copyButton = IconButton(
      onPressed: this.mails != null && this.mails!.isNotEmpty
          ? () => _handleCopy(context)
          : null,
      icon: const Icon(Icons.copy),
      visualDensity: VisualDensity.compact,
    );

    final mailsRow = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (this.mails == null) ...[
          SizedBox(width: DesignSystem.spacing.x12),
          BaseProgressIndicator(
            size: DesignSystem.size.x18,
          ),
          SizedBox(width: DesignSystem.spacing.x12),
          const Text('Fetching...'),
        ],
        if (this.mails != null) ...[
          Text(
            '${this.mails!.length} mail${(this.mails!.length) == 1 ? "" : "s"}',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
              fontFeatures: [
                const FontFeature.tabularFigures(),
              ],
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(width: DesignSystem.spacing.x12),
          AnimatedColor(
            color: this.isFiltered
                ? CupertinoColors.activeBlue
                : Theme.of(context).disabledColor,
            builder: (context, color, child) => Icon(
              CupertinoIcons.line_horizontal_3_decrease_circle_fill,
              color: color,
              size: DesignSystem.size.x18,
            ),
          ),
          SizedBox(width: DesignSystem.spacing.x12),
        ],
      ],
    );

    final mailTypeDescription = Text(this.type.description);

    final tagBox = Padding(
      padding: EdgeInsets.only(right: DesignSystem.spacing.x12),
      child: TagBox(
        width: DesignSystem.size.x92,
        alignment: MainAxisAlignment.center,
        color: this.type.color,
        label: this.type.name,
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) => switch (constraints.maxWidth) {
        > 420 => Row(
            children: [
              copyButton,
              SizedBox(width: DesignSystem.spacing.x24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    mailsRow,
                    SizedBox(height: DesignSystem.spacing.x4),
                    mailTypeDescription,
                  ],
                ),
              ),
              SizedBox(width: DesignSystem.spacing.x24),
              tagBox,
              SizedBox(width: DesignSystem.spacing.x12),
            ],
          ),
        _ => Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                copyButton,
                SizedBox(width: DesignSystem.spacing.x24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: DesignSystem.size.x24,
                        child: mailsRow,
                      ),
                      SizedBox(height: DesignSystem.spacing.x4),
                      mailTypeDescription,
                      SizedBox(height: DesignSystem.spacing.x8),
                      tagBox,
                    ],
                  ),
                ),
                SizedBox(width: DesignSystem.spacing.x12),
              ],
            ),
          ),
      },
    );
  }
}
