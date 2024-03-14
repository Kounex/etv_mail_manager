import 'package:base_components/base_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MailTextField extends StatefulWidget {
  const MailTextField({super.key});

  @override
  State<MailTextField> createState() => _MailTextFieldState();
}

class _MailTextFieldState extends State<MailTextField> {
  late final CustomValidationTextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = CustomValidationTextEditingController(check: (text) {
      if (text == null || text.isEmpty) return null;
      List<String> potentialMails = text.split(RegExp(r'[,;\t\n\r ]'));

      Set<String> errors = potentialMails
          .map((mail) => ValidationUtils.email(mail))
          .whereType<String>()
          .toSet();

      if (errors.isNotEmpty) {
        return errors.join('\n');
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    const Widget text = EnumerationBlock(
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

    final Widget textField = SizedBox(
      height: DesignSystem.size.x256,
      child: BaseAdaptiveTextField(
        controller: _controller,
        platform: TargetPlatform.iOS,
        expands: true,
        placeholder: 'Emails...',
        textAlignVertical: TextAlignVertical.top,
      ),
    );

    final Widget button = BaseButton(
      onPressed: () => _controller.submit(),
      text: 'Validate',
    );

    return Align(
      child: BaseConstrainedBox(
        child: switch (DesignSystem.breakpoint(context: context)) {
          <= Breakpoint.md => Row(
              children: [
                Expanded(
                  child: IntrinsicWidth(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        text,
                        SizedBox(height: DesignSystem.spacing.x12),
                        textField,
                        SizedBox(height: DesignSystem.spacing.x12),
                        button,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          _ => const SizedBox(),
        },
      ),
    );
  }
}
