import 'package:base_components/base_components.dart';
import 'package:etv_mail_manager/models/etv_mail/etv_mail.dart';
import 'package:etv_mail_manager/models/etv_mail/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  late final CustomValidationTextEditingController _controller;

  MailType? _type;

  @override
  void initState() {
    super.initState();

    _type = this.widget.mail.type;

    _controller = CustomValidationTextEditingController(
      text: this.widget.mail.address,
      check: (text) =>
          ValidationUtils.email(text) ??
          (ETVMailService().mails.value.value!.any((existingMail) =>
                  existingMail.$id != this.widget.mail.$id &&
                  existingMail.address == (text ?? '').toLowerCase().trim())
              ? 'Email exists!'
              : null),
    );
  }

  void _handleSave() {
    if (_controller.isValid) {
      ETVMailService()
          .update(
            mail: this.widget.mail.copyWith(
                  address: _controller.text.toLowerCase().trim(),
                  type: _type!,
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
            .delete(uuid: this.widget.mail.$id!)
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
            controller: _controller,
            platform: TargetPlatform.iOS,
            clearButton: true,
          ),
          SizedBox(height: DesignSystem.spacing.x12),
          Row(
            children: [
              DropdownButton<MailType?>(
                onChanged: (type) => setState(() => _type = type),
                value: _type,
                padding: const EdgeInsets.all(0),
                selectedItemBuilder: (context) => List.from(
                  MailType.values.map(
                    (type) => Transform.translate(
                      offset: Offset(-DesignSystem.spacing.x12, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(type.name),
                      ),
                    ),
                  ),
                ),
                items: List.from(
                  MailType.values.map(
                    (type) => DropdownMenuItem(
                      value: type,
                      child: Text(type.name),
                    ),
                  ),
                ),
              ),
              SizedBox(width: DesignSystem.spacing.x12),
              StatusDot(
                color: _type!.color,
              ),
            ],
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
