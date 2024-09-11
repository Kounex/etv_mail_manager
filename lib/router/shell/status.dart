import 'package:base_components/base_components.dart';
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../signals/meta.dart';
import '../../utils/supabase/client.dart';

class ShellStatus extends StatelessWidget {
  const ShellStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(left: DesignSystem.spacing.x12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(BaseSupabaseClient().session()?.user.email ?? 'Unknown'),
            Text(
              BaseSupabaseClient().session()?.user.role ?? 'Unknown',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            SizedBox(height: DesignSystem.spacing.x8),
            Watch(
              (_) => Text(
                MetaSignals().appVersion.value.maybeMap(
                      data: (version) => version,
                      orElse: () => '-',
                    ),
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Theme.of(context).disabledColor,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
