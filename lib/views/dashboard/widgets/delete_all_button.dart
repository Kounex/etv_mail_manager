import 'package:base_components/base_components.dart';
import 'package:etv_mail_manager/models/etv_mail/service.dart';
import 'package:flutter/material.dart';

class DeleteAllButton extends StatelessWidget {
  const DeleteAllButton({super.key});

  void _handleDeleteAll(BuildContext context) {
    ModalUtils.showBaseDialog(
      context,
      ConfirmationDialog(
        title: 'Delete All',
        body:
            'Are you sure you want to delete all mails? This action can\'t be undone and could lead to tremendous data loss!\n\nPlease make sure you really want to do this.',
        isYesDestructive: true,
        onYes: (_) => ModalUtils.showBaseDialog(
          context,
          ConfirmationDialog(
            title: 'Last Chance',
            body:
                'Just to double check you did not click yes by mistake. If not, go ahead!',
            isYesDestructive: true,
            onYes: (_) => ETVMailService()
                .deleteBulk(ETVMailService().mails.value.value!),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      child: BaseConstrainedBox(
        child: SizedBox(
          width: double.infinity,
          child: BaseButton(
            onPressed: () => _handleDeleteAll(context),
            child: const Text('Delete All'),
          ),
        ),
      ),
    );
  }
}
