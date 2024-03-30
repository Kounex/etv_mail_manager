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
      List<String>? potentialMails = text?.split(RegExp(r'[,;\t\n\r ]'));

      Set<String>? errors = potentialMails
          ?.map((mail) {
            String? error = ValidationUtils.email(mail);
            if (mail.isNotEmpty && error != null) {
              ImportSignals().wrongMails.add(mail);
            }
            return error;
          })
          .whereType<String>()
          .toSet();

      if (errors != null && errors.isNotEmpty) {
        return errors.join('\n');
      }
      return null;
    });
  }

  void _validateImport() {
    if (_controller.isValid) {
      List<String> mails = _controller.text.split(RegExp(r'[,;\t\n\r ]'));

      ImportSignals().validatedMails.value = Set.from(
        mails.map((mail) => ETVMail.data(address: mail)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseConstrainedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const EnumerationBlock(
            title:
                'Paste the email addresses which should be imported. Allowed separators:',
            entries: [
              'comma (,)',
              'semicolon (;)',
              'space ( )',
              'newline (\\n)',
              'tab (\\t)'
            ],
          ),
          SizedBox(height: DesignSystem.spacing.x12),
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
