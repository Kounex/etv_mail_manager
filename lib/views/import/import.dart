import 'package:base_components/base_components.dart';
import 'package:etv_mail_manager/models/etv_mail/service.dart';
import 'package:etv_mail_manager/utils/signals.dart';
import 'package:etv_mail_manager/views/import/widgets/validated_mails.dart';
import 'package:etv_mail_manager/views/import/widgets/wrong_mails.dart';
import 'package:etv_mail_manager/widgets/etv_scaffold.dart';
import 'package:flutter/material.dart';

import 'widgets/mail_text_field.dart';

class ImportView extends StatefulWidget {
  const ImportView({super.key});

  @override
  State<ImportView> createState() => _ImportViewState();
}

class _ImportViewState extends State<ImportView> {
  @override
  void initState() {
    super.initState();

    SignalsUtils.handleAsync(
      context,
      ETVMailService().mailCreateBulk,
      handleLoading: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ETVScaffold(
      children: [
        switch (DesignSystem.breakpoint(context: context)) {
          <= Breakpoint.sm => Column(
              children: [
                const MailTextField(),
                SizedBox(height: DesignSystem.spacing.x12),
                const WrongMails(),
                SizedBox(height: DesignSystem.spacing.x24),
                const ValidatedMails(),
              ],
            ),
          _ => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
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
                SizedBox(height: DesignSystem.spacing.x12),
                const WrongMails(),
              ],
            ),
        },
      ],
    );
  }
}
