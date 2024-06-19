import 'package:base_components/base_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../models/etv_mail/etv_mail.dart';

class MailBoxTitle extends StatelessWidget {
  final Iterable<ETVMail>? mails;
  final bool isFiltered;

  const MailBoxTitle({
    super.key,
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Copied to clipboard!'),
          ),
        );
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not copy!'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: mails != null && mails!.isNotEmpty
              ? () => _handleCopy(context)
              : null,
          icon: const Icon(Icons.copy),
          visualDensity: VisualDensity.compact,
        ),
        if (this.mails == null)
          Row(
            children: [
              SizedBox(width: DesignSystem.spacing.x12),
              BaseProgressIndicator(
                size: DesignSystem.size.x18,
              ),
              SizedBox(width: DesignSystem.spacing.x12),
              const Text('Fetching...'),
            ],
          ),
        if (this.mails != null) ...[
          SizedBox(
            width: DesignSystem.size.x92,
            child: Text(
              '${this.mails!.length} mail${(this.mails!.length) == 1 ? "" : "s"}',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(width: DesignSystem.spacing.x12),
          Icon(
            this.isFiltered
                ? CupertinoIcons.line_horizontal_3_decrease_circle_fill
                : CupertinoIcons.line_horizontal_3_decrease_circle,
            color: this.isFiltered
                ? CupertinoColors.activeBlue
                : Theme.of(context).disabledColor,
            size: DesignSystem.size.x18,
          ),
        ]
      ],
    );
  }
}
