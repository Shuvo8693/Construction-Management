import 'package:auto_route/auto_route.dart';
import 'package:charteur/core/helpers/helper_data.dart';
import 'package:charteur/core/widgets/jwt_decoder/payload_value.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:charteur/features/views/bottom_nav/bottom_nav.dart';
import 'package:charteur/features/views/common/sites/view_models/sites_controller.dart';
import 'package:charteur/features/views/common/sites/widgets/site_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class SitesScreen extends StatefulWidget {
  const SitesScreen({super.key});

  @override
  State<SitesScreen> createState() => _SitesScreenState();
}

class _SitesScreenState extends State<SitesScreen> {
  final  _sitesController = Get.find<SitesController>();


  @override
  void initState() {
    super.initState();
    getMyInfo();
    _sitesController.getAssignedSite();
  }

  String myId = '';
  String myRole = '';
  getMyInfo()async{
    final payloads = await getPayloadValue();
    myId = payloads['userId'];
    myRole = payloads['role'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bottomNavigationBar: BottomNavScreen(menuIndex: 1),
      appBar: CustomAppBar(title: 'Sites'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilteredButtonWidget(
            selectedValue: myRole == 'office_admin'? 'Assigned Task' : 'My Task',
            categoryItem: myRole == 'office_admin'? HelperData.filteredItems : HelperData.filteredItemsMyTask,
          ),

      Obx((){
        final siteData = _sitesController.siteListModel.value?.data??[];
        if(_sitesController.isLoading.value){
          return Center(child: CircularProgressIndicator());
        }else if(_sitesController.siteListModel.value == null || siteData.isEmpty){
          return Center(child: Text('No Data Found'));
        }
        return  Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              await _sitesController.getAssignedSite();
            },
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: siteData.length,
              itemBuilder: (context, index) {
                return AnimatedListItemWraper(
                  index: index,
                  child: SiteCardWidget(siteData: siteData[index],),
                );
              },
            ),
          ),
        );
      }
      )] ,
      ),
    );
  }
}