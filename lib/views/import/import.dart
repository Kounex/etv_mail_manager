import 'package:base_components/base_components.dart';
import 'package:etv_mail_manager/views/import/widgets/validated_mails/validated_mails.dart';
import 'package:etv_mail_manager/views/import/widgets/wrong_mails.dart';
import 'package:etv_mail_manager/widgets/etv_scaffold.dart';
import 'package:flutter/material.dart';

import '../../router/view.dart';
import 'widgets/mail_text_field.dart';

class ImportView extends RouterStatefulView {
  const ImportView({super.key});

  @override
  State<ImportView> createState() => _ImportViewState();
}

class _ImportViewState extends State<ImportView> {
  @override
  void initState() {
    super.initState();

    // SchedulerBinding.instance.addPostFrameCallback((_) {
    //   SignalsUtils.handleAsync(
    //     context,
    //     ETVMailService().mailCreateBulk,
    //     handleLoading: true,
    //   );

    //   SignalsUtils.handleAsync(
    //     context,
    //     ETVMailService().mailUpdateBulk,
    //     handleLoading: true,
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    const textBlock = EnumerationBlock(
      title:
          'Paste the email addresses which should be imported. Allowed separators:',
      entries: [
        'comma (,)',
        'semicolon (;)',
        'space ( )',
        'newline (\\n)',
        'tab (\\t)'
      ],
    );

    return ETVScaffold(
      children: [
        SizedBox(height: DesignSystem.spacing.x12),
        switch (DesignSystem.breakpoint(context: context)) {
          <= Breakpoint.sm => Column(
              children: [
                textBlock,
                SizedBox(height: DesignSystem.spacing.x24),
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
                textBlock,
                SizedBox(height: DesignSystem.spacing.x24),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Flexible(
                      child: MailTextField(),
                    ),
                    SizedBox(width: DesignSystem.spacing.x48),
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
