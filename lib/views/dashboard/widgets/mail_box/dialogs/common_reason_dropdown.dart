import 'package:base_components/base_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../models/etv_mail/etv_mail.dart';

class CommonReasonDropdown extends StatelessWidget {
  final MailType type;
  final CommonReason? commonReason;
  final void Function(CommonReason? commonReason) onChanged;
  final void Function() onDelete;

  const CommonReasonDropdown({
    super.key,
    required this.type,
    required this.commonReason,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DropdownButton<CommonReason?>(
          onChanged: this.onChanged,
          value: this.commonReason,
          padding: const EdgeInsets.all(0),
          hint: Transform.translate(
            offset: Offset(-DesignSystem.spacing.x12, 0),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text('Reason'),
            ),
          ),
          selectedItemBuilder: (context) => List.from(
            CommonReason.forType(this.type).map(
              (commonReason) => Transform.translate(
                offset: Offset(-DesignSystem.spacing.x12, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(commonReason.text),
                ),
              ),
            ),
          ),
          items: List.from(
            CommonReason.forType(this.type).map(
              (commonReason) => DropdownMenuItem(
                value: commonReason,
                child: Text(commonReason.text),
              ),
            ),
          ),
        ),
        SizedBox(width: DesignSystem.spacing.x12),
        AnimatedSwitcher(
          duration: DesignSystem.animation.defaultDurationMS250,
          child: this.commonReason != null
              ? InkWell(
                  onTap: this.onDelete,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  child: Icon(
                    CupertinoIcons.clear_circled_solid,
                    size: DesignSystem.size.x18,
                  ),
                )
              : const SizedBox(),
        ),
      ],
    );
  }
}
