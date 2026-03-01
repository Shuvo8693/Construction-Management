import 'package:auto_route/auto_route.dart';
import 'package:charteur/assets/assets.gen.dart';
import 'package:charteur/core/helpers/menu_show_helper.dart';
import 'package:charteur/core/helpers/photo_picker_helper.dart';
import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/files/filepath_container.dart';
import 'package:charteur/core/widgets/search_bottom_sheet.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:charteur/features/views/common/sites/view_models/sites_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class SiteAddScreen extends StatefulWidget {
  const SiteAddScreen({super.key});

  @override
  State<SiteAddScreen> createState() => _SiteAddScreenState();
}

class _SiteAddScreenState extends State<SiteAddScreen> {

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final  _sitesController = Get.find<SitesController>();

  String _filePath ='';

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
                controller: _sitesController.siteOwnerController,
              ),
              _buildTextField(
                label: 'Site Tittle',
                hint: 'Downtown Mall Projects',
                controller: _sitesController.siteTitleController,
              ),
              GestureDetector(
                onTapDown: (details) async {
                  final value = await MenuShowHelper.showCustomMenu(
                    context: context,
                    details: details,
                    options: ['To-Do', 'In-Progress'],
                  );
                  if (value != null) {
                    _sitesController.siteStatusController.text = value;
                  }
        
                },
                child: AbsorbPointer(
                  child: _buildTextField(
                    label: 'Site Current Status',
                    hint: 'Select Status',
                    controller: _sitesController.siteStatusController,
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 24.r,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
              _buildTextField(
                label: 'Location',
                hint: 'Enter Location',
                controller: _sitesController.siteLocationController,
              ),
              // GestureDetector(
              //   onTap: (){
              //     searchBottomSheet(
              //       context,
              //       controller: _siteLocationController,
              //       hintText: 'Search location',
              //     );
              //   },
              //   child: AbsorbPointer(
              //     child: _buildTextField(
              //       label: 'Site Location',
              //       hint: 'Enter Location',
              //       controller: _siteLocationController,
              //       suffixIcon: Icon(
              //         Icons.location_on_outlined,
              //         size: 24.r,
              //         color: AppColors.textSecondary,
              //       ),
              //     ),
              //   ),
              // ),

              GestureDetector(
                onTapDown: (details) async {
                  final value = await MenuShowHelper.showCustomMenu(
                    context: context,
                    details: details,
                    options: ['Residential', 'Commercial', 'Industrial', 'Mixed-Use', 'Infrastructure', 'Other'],      // enumValues: [Residential, Commercial, Industrial, Mixed-Use, Infrastructure, Other]
                  );
                  if (value != null) {
                    _sitesController.buildingTypeController.text = value;
                  }

                },
                child: AbsorbPointer(
                  child: _buildTextField(
                    label: 'Types of Building',
                    hint: 'Apartment',
                    controller: _sitesController.buildingTypeController,
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 24.r,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
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
                      setState(() {
                        _filePath = file.path;
                      });
        
                    });
                },
                child: Assets.icons.addImage.svg(
                  width: 345.w,
                  height: 108.h,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10.h,),
              if(_filePath.isNotEmpty)
                buildFilePathContainer(_filePath, (){
                  setState(() {
                    _filePath = '';
                  });
                })

            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(16.w),
          child: Obx(()=>
             CustomButton(
               isLoading: _sitesController.isLoading.value,
               onPressed: (){
              if(_globalKey.currentState!.validate()){
                _sitesController.addSite(filePath: _filePath,fileName: 'shuvo');
              }
            },
              label: 'Add Site',
            ),
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
}
