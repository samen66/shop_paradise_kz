import 'package:flutter/material.dart';

import '../../domain/repositories/profile_repository.dart';
import 'profile_orders_tab_page.dart';

class ProfileToReceivePage extends StatelessWidget {
  const ProfileToReceivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileOrdersTabPage(
      tab: ProfileOrdersTab.toReceive,
      title: 'To Receive',
      subtitle: 'My Orders',
    );
  }
}
