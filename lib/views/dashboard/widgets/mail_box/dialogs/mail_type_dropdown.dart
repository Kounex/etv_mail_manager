import 'package:base_components/base_components.dart';
import 'package:flutter/material.dart';

import '../../../../../models/etv_mail/etv_mail.dart';

class MailTypeDropdown extends StatelessWidget {
  final MailType type;
  final void Function(MailType? type) onChanged;

  const MailTypeDropdown({
    super.key,
    required this.type,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DropdownButton<MailType?>(
          onChanged: this.onChanged,
          value: this.type,
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
          color: this.type.color,
        ),
      ],
    );
  }
}
