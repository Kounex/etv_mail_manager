import 'package:base_components/base_components.dart';
import 'package:etv_mail_manager/models/etv_mail/etv_mail.dart';
import 'package:etv_mail_manager/views/import/signals/signals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MailTextField extends StatefulWidget {
  const MailTextField({super.key});

  @override
  State<MailTextField> createState() => _MailTextFieldState();
}

class _MailTextFieldState extends State<MailTextField> {
  late final CustomValidationTextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _controller = CustomValidationTextEditingController(check: (text) {
      ImportSignals().wrongMails.clear();

      if (text == null || text.trim().isEmpty) {
        return 'Field is required!';
      }

      Set<String>? potentialMails = _extractPotentialEmails(text);

      if (potentialMails == null || potentialMails.isEmpty) {
        return 'Not possible to extract any email from the provided text. Make sure there are correct email addresses included and you follow the spec as mentioned above!';
      }

      return null;
    });
  }

  Set<String>? _extractPotentialEmails(String? text) => text
      ?.split(RegExp(r'[,;<>\t\n\r ]'))
      .where((potentialMail) =>
          potentialMail.trim().isNotEmpty &&
          ValidationUtils.email(potentialMail) == null)
      .toSet();

  void _validateImport() {
    if (_controller.isValid) {
      Set<String>? mails = _extractPotentialEmails(_controller.text);

      if (mails != null && mails.isNotEmpty) {
        ImportSignals().validatedMails.value = Set.from(
          mails.map((mail) => ETVMail.data(address: mail.trim())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseConstrainedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: DesignSystem.size.x256,
            child: BaseKeyboardHeader(
              focusNode: _focusNode,
              child: BaseAdaptiveTextField(
                controller: _controller,
                focusNode: _focusNode,
                platform: TargetPlatform.iOS,
                expands: true,
                placeholder: 'Emails...',
                keyboardType: TextInputType.multiline,
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
          ),
          SizedBox(height: DesignSystem.spacing.x12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: DesignSystem.size.x128,
                child: BaseButton(
                  onPressed: _validateImport,
                  text: 'Validate',
                ),
              ),
              SizedBox(width: DesignSystem.spacing.x12),
              SizedBox(
                width: DesignSystem.size.x128,
                child: BaseButton(
                  onPressed: () {
                    _controller.clear();
                    ImportSignals().wrongMails.clear();
                    ImportSignals().validatedMails.clear();
                  },
                  text: 'Reset',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
