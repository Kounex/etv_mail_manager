import 'package:base_components/base_components.dart';
import 'package:etv_mail_manager/models/etv_mail/etv_mail.dart';
import 'package:etv_mail_manager/models/etv_mail/service.dart';
import 'package:etv_mail_manager/views/dashboard/widgets/mail_box/dialogs/mail_type_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'common_reason_dropdown.dart';

class MailBoxEditDialog extends StatefulWidget {
  final ETVMail mail;

  const MailBoxEditDialog({
    super.key,
    required this.mail,
  });

  @override
  State<MailBoxEditDialog> createState() => _MailBoxEditDialogState();
}

class _MailBoxEditDialogState extends State<MailBoxEditDialog> {
  late final CustomValidationTextEditingController _email;
  late final CustomValidationTextEditingController _reason;

  final FocusNode _focusNode = FocusNode();

  late MailType _type;

  CommonReason? _commonReason;

  @override
  void initState() {
    super.initState();

    _type = this.widget.mail.type;
    _commonReason = this.widget.mail.commonReason;

    _email = CustomValidationTextEditingController(
      text: this.widget.mail.address,
      check: (text) =>
          ValidationUtils.email(text) ??
          (ETVMailService().mails.value.value!.any((existingMail) =>
                  existingMail.uuid != this.widget.mail.uuid &&
                  existingMail.address == (text ?? '').toLowerCase().trim())
              ? 'Email exists!'
              : null),
    );

    _reason =
        CustomValidationTextEditingController(text: this.widget.mail.reason);
  }

  void _handleSave() {
    if (_email.isValid) {
      ETVMailService()
          .update(
            this.widget.mail.copyWith(
                  address: _email.text.toLowerCase().trim(),
                  type: _type,
                  commonReason: _commonReason,
                  reason: _commonReason == CommonReason.other
                      ? _reason.text.trim()
                      : null,
                ),
          )
          .then((_) => Navigator.of(context).pop());
    }
  }

  void _handleDelete() {
    ModalUtils.showBaseDialog(
      context,
      ConfirmationDialog(
        title: 'Delete Mail',
        body:
            'Are you sure you want to delete this mail? You will need to go through the import procedure again to get it back!',
        isYesDestructive: true,
        onYes: (_) => ETVMailService()
            .delete(this.widget.mail.uuid)
            .then((_) => Navigator.of(context).pop()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseAdaptiveDialog(
      titleWidget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Edit Mail'),
          TextButton(
            onPressed: _handleDelete,
            style: ButtonStyle(
              foregroundColor: const MaterialStatePropertyAll(
                CupertinoColors.destructiveRed,
              ),
              overlayColor: MaterialStatePropertyAll(
                CupertinoColors.destructiveRed.withOpacity(0.1),
              ),
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
      bodyWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Make sure to press "Save" to persist your changes.'),
          SizedBox(height: DesignSystem.spacing.x24),
          BaseAdaptiveTextField(
            controller: _email,
            platform: TargetPlatform.iOS,
            clearButton: true,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: DesignSystem.spacing.x12),
          MailTypeDropdown(
            type: _type,
            onChanged: (type) {
              if (type != _type) {
                setState(() {
                  _commonReason = null;
                  _type = type ?? MailType.active;
                });
              }
            },
          ),
          SizedBox(height: DesignSystem.spacing.x12),
          CommonReasonDropdown(
            onChanged: (commonReason) {
              _reason.clear();
              setState(() => _commonReason = commonReason);
            },
            onDelete: () => setState(() => _commonReason = null),
            type: _type,
            commonReason: _commonReason,
          ),
          SizedBox(height: DesignSystem.spacing.x12),
          AnimatedSize(
            duration: DesignSystem.animation.defaultDurationMS250,
            curve: Curves.easeOutCirc,
            child: _commonReason == CommonReason.other
                ? SizedBox(
                    key: const ValueKey(1),
                    height: DesignSystem.size.x92,
                    child: BaseKeyboardHeader(
                      focusNode: _focusNode,
                      child: BaseAdaptiveTextField(
                        controller: _reason,
                        focusNode: _focusNode,
                        platform: TargetPlatform.iOS,
                        scrollPadding:
                            EdgeInsets.all(DesignSystem.spacing.x128),
                        placeholder: 'Reasoning...',
                        expands: true,
                        keyboardType: TextInputType.multiline,
                        textAlignVertical: TextAlignVertical.top,
                      ),
                    ),
                  )
                : const SizedBox(
                    key: ValueKey(0),
                  ),
          ),
        ],
      ),
      actions: [
        BaseDialogAction(
          child: const Text('Close'),
          isDefaultAction: true,
        ),
        BaseDialogAction(
          onPressed: (_) => _handleSave(),
          popOnAction: false,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
