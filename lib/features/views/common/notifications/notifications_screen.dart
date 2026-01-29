import 'package:auto_route/auto_route.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:charteur/features/views/common/notifications/widgets/notification_card_widget.dart';
import 'package:flutter/material.dart';


@RoutePage()
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: 'Notifications',
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
          return AnimatedListItemWraper(
            totalItems: 10,
            index: index,
            child: const NotificationCardWidget(),
          );
        },),
      ),
    );
  }
}
