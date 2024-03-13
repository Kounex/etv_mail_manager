import 'package:base_components/base_components.dart';
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../models/etv_mail/service.dart';

class MailBox extends StatelessWidget {
  const MailBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Watch(
      (context) => BaseCard(
        title:
            '${ETVMailService().mails.value.value?.length ?? 0} mail(s) in list',
        titleStyle: Theme.of(context).textTheme.bodyLarge,
        initialExpanded: false,
        centerChild: false,
        child: Align(
          alignment: Alignment.topLeft,
          child: Wrap(
            children: List.from(
              ETVMailService().mails.value.value?.map(
                        (mail) => Chip(
                          label: Text(mail.address),
                        ),
                      ) ??
                  [],
            ),
          ),
        ),
      ),
    );
  }
}
