import 'package:base_components/base_components.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/supabase/client.dart';

class ShellLogout extends StatelessWidget {
  const ShellLogout({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(DesignSystem.spacing.x24),
      child: SizedBox(
        width: double.infinity,
        child: BaseButton(
          onPressed: () => BaseSupabaseClient().signOut(),
          text: 'Logout',
        ),
      ),
    );
  }
}
