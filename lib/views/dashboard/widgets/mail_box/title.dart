import 'package:base_components/base_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../models/etv_mail/etv_mail.dart';

class MailBoxTitle extends StatelessWidget {
  final Iterable<ETVMail>? mails;

  const MailBoxTitle({
    super.key,
    this.mails,
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
        SizedBox(width: DesignSystem.spacing.x12),
        if (this.mails == null)
          Row(
            children: [
              BaseProgressIndicator(
                size: DesignSystem.size.x18,
              ),
              SizedBox(width: DesignSystem.spacing.x12),
              const Text('Fetching...'),
            ],
          ),
        if (this.mails != null)
          Text(
            '${this.mails!.length} mail${(this.mails!.length) == 1 ? "" : "s"}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
      ],
    );
  }
}
