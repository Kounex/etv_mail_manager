import 'package:base_components/base_components.dart';
import 'package:flutter/material.dart';

import '../../../../models/etv_mail/etv_mail.dart';
import '../../../../models/etv_mail/service.dart';

class MailBoxTitle extends StatelessWidget {
  final Iterable<ETVMail>? mails;

  const MailBoxTitle({
    super.key,
    this.mails,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: mails != null && mails!.isNotEmpty ? () {} : null,
          icon: const Icon(Icons.copy),
          visualDensity: VisualDensity.compact,
        ),
        SizedBox(width: DesignSystem.spacing.x12),
        if (ETVMailService().mails.value.isLoading)
          Row(
            children: [
              BaseProgressIndicator(
                size: DesignSystem.size.x24,
              ),
              SizedBox(width: DesignSystem.spacing.x12),
              const Text('Fetching...'),
            ],
          ),
        if (!ETVMailService().mails.value.isLoading)
          Text(
            '${mails?.length ?? 0} mail${(mails?.length ?? 0) == 1 ? "" : "s"}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
      ],
    );
  }
}
