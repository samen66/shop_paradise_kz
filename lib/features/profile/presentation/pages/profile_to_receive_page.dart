import 'package:flutter/material.dart';

import '../../../../core/l10n/l10n_helpers.dart';
import '../../domain/repositories/profile_repository.dart';
import 'profile_orders_tab_page.dart';

class ProfileToReceivePage extends StatelessWidget {
  const ProfileToReceivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileOrdersTabPage(
      tab: ProfileOrdersTab.toReceive,
      title: context.l10n.profileTabToReceive,
      subtitle: context.l10n.profileMyOrdersSubtitle,
    );
  }
}
