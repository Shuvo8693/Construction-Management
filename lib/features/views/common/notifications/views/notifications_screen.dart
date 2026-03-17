import 'package:auto_route/auto_route.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:charteur/features/views/common/notifications/view_models/notification_controller.dart';
import 'package:charteur/features/views/common/notifications/widgets/notification_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class NotificationsScreen extends StatelessWidget {
   NotificationsScreen({super.key});
 final controller = Get.find<NotificationController>();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: 'Notifications',
      ),
      body: Obx((){
        final notificationData = controller.notificationResponse.value?.data??[];
        if(controller.isLoading.value){
          return Center(child: CircularProgressIndicator());
        }else if( notificationData.isEmpty){
          return Center(child: Text('No notifications'));
        }
        return  RefreshIndicator(
          onRefresh: () async {
            await controller.getNotifications();
          },
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: notificationData.length,
            itemBuilder: (context, index) {
             final notificationIndex = notificationData[index];
              return AnimatedListItemWraper(
                totalItems: notificationData.length,
                index: index,
                child:  NotificationCardWidget(notificationData: notificationIndex,),
              );
            },),
        );
        }
      ),
    );
  }
}
