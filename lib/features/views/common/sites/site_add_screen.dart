import 'package:auto_route/auto_route.dart';
import 'package:charteur/assets/assets.gen.dart';
import 'package:charteur/core/helpers/menu_show_helper.dart';
import 'package:charteur/core/helpers/photo_picker_helper.dart';
import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/search_bottom_sheet.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class SiteAddScreen extends StatefulWidget {
  const SiteAddScreen({super.key});

  @override
  State<SiteAddScreen> createState() => _SiteAddScreenState();
}

class _SiteAddScreenState extends State<SiteAddScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final TextEditingController _siteOwnerController = TextEditingController();
  final TextEditingController _siteTitleController = TextEditingController();
  final TextEditingController _siteStatusController = TextEditingController();
  final TextEditingController _siteLocationController = TextEditingController();
  final TextEditingController _buildingTypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: 'Add a Site'),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: _globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                label: 'Site Owner',
                hint: 'Chartear Company',
                controller: _siteOwnerController,
              ),
              _buildTextField(
                label: 'Site Tittle',
                hint: 'Downtown Mall Projects',
                controller: _siteTitleController,
              ),
              GestureDetector(
                onTapDown: (details) async {
                  final value = await MenuShowHelper.showCustomMenu(
                    context: context,
                    details: details,
                    options: ['Start', 'In Progress'],
                  );
                  if (value != null) {
                    _siteStatusController.text = value;
                  }
        
                },
                child: AbsorbPointer(
                  child: _buildTextField(
                    label: 'Site Current Status',
                    hint: 'Select Status',
                    controller: _siteStatusController,
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 24.r,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  searchBottomSheet(
                    context,
                    controller: _siteLocationController,
                    hintText: 'Search location',
                  );
                },
                child: AbsorbPointer(
                  child: _buildTextField(
                    label: 'Site Location',
                    hint: 'Enter Location',
                    controller: _siteLocationController,
                    suffixIcon: Icon(
                      Icons.location_on_outlined,
                      size: 24.r,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
              _buildTextField(
                label: 'Types of Building',
                hint: 'Apartment',
                controller: _buildingTypeController,
              ),
        
              SizedBox(height: 8.h,),
              CustomText(
                textAlign: TextAlign.start,
                text: 'Add Photos',  color: AppColors.textPrimary,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
        
              SizedBox(height: 8.h,),
              GestureDetector(
                onTap: (){
                  PhotoPickerHelper.showPicker(
                    context: context,
                    onImagePicked: (file) {
        
                    });
                },
                child: Assets.icons.addImage.svg(
                  width: 345.w,
                  height: 108.h,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
     Widget? suffixIcon,
    required TextEditingController controller,
  }) {
    return CustomTextField(
      suffixIcon: suffixIcon,
      borderRadio: 12.r,
      controller: controller,
      labelText: label,
      hintText: hint,
      borderColor: Color(0xFFEDEDED),
      filColor: Colors.transparent,
    );
  }


  @override
  void dispose() {
    _siteOwnerController.dispose();
    _siteTitleController.dispose();
    _siteStatusController.dispose();
    _siteLocationController.dispose();
    _buildingTypeController.dispose();
    super.dispose();
  }
}
