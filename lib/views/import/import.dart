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
  Widget build(BuildContext context) {
    return const ETVScaffold(
      children: [
        MailTextField(),
      ],
    );
  }
}
