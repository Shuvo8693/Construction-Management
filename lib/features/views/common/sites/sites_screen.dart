import 'package:auto_route/auto_route.dart';
import 'package:charteur/core/helpers/helper_data.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:charteur/features/views/bottom_nav/bottom_nav.dart';
import 'package:charteur/features/views/common/sites/widgets/site_card_widget.dart';
import 'package:flutter/material.dart';

class SitesScreen extends StatelessWidget {
  const SitesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: 'Sites'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilteredButtonWidget(
            selectedValue: 'Assigned Task',
            categoryItem: HelperData.filteredItems,
          ),

          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {},
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return AnimatedListItemWraper(
                    index: index,
                    child: SiteCardWidget(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}