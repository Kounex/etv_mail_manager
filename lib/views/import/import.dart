import 'package:base_components/base_components.dart';
import 'package:etv_mail_manager/views/import/widgets/validated_mails.dart';
import 'package:etv_mail_manager/widgets/etv_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'widgets/mail_text_field.dart';

class ImportView extends StatefulWidget {
  const ImportView({super.key});

  @override
  State<ImportView> createState() => _ImportViewState();
}

class _ImportViewState extends State<ImportView> {
  @override
  Widget build(BuildContext context) {
    return ETVScaffold(
      children: [
        switch (DesignSystem.breakpoint(context: context)) {
          <= Breakpoint.md => Column(
              children: [
                const MailTextField(),
                SizedBox(height: DesignSystem.spacing.x24),
                const ValidatedMails(),
              ],
            ),
          _ => Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Flexible(
                  child: MailTextField(),
                ),
                SizedBox(width: DesignSystem.spacing.x24),
                const Flexible(
                  child: ValidatedMails(),
                ),
              ],
            ),
        },
      ],
    );
  }
}
