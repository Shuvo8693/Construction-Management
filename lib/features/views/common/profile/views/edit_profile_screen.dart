import 'dart:io';
import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:charteur/features/views/common/profile/repository/profile_repository.dart';
import 'package:charteur/features/views/common/profile/view_models/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? imageFile;
 late final ProfileController  controller ;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ProfileController(ProfileRepository()));
  }

  @override
  void dispose() {
    // ✅ Dispose all controllers here, safe after screen is gone
    Get.delete<ProfileController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, size: 20.r, color: AppColors.textPrimary),
        ),
        title: CustomText(
          text: 'Edit Information',
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ── Avatar ──────────────────────────────────────
              Center(
                child: CustomImageAvatar(
                  fileImage: imageFile,
                  onImagePicked: (file) {
                    imageFile = File(file.path);
                    setState(() {});
                  },
                  showBorder: true,
                  image: controller.profileModel.value?.data?.profileImage??'',
                  radius: 50.r,
                ),
              ),

              SizedBox(height: 24.h),
              // {
              //   "name": "John Doe",
              //   "phoneNumber": "+1234567890",
              //   "address": "123 Main Street, New York, USA",
              //   "experience": 5,
              //   "expertiseArea": "Civil Engineering",
              //   "employmentType": "Full-time"
              // }
              // ── Profile Info ─────────────────────────────────
              _SectionCard(
                title: 'Profile Info',
                children: [
                  CustomTextField(labelText: 'Full Name',    controller: controller.fullNameController,borderColor: Colors.grey,),
                  CustomTextField(labelText: 'Phone Number', controller: controller.phoneController,  keyboardType: TextInputType.phone,borderColor: Colors.grey),
                  CustomTextField(labelText: 'Email',        controller: controller.emailController,  keyboardType: TextInputType.emailAddress,borderColor: Colors.grey,readOnly: true),
                  CustomTextField(labelText: 'Address',      controller: controller.addressController,borderColor: Colors.grey),
                ],
              ),

              SizedBox(height: 16.h),

              // ── Professional Info ────────────────────────────
              _SectionCard(
                title: 'Professional Info',
                children: [
                  CustomTextField(labelText: 'Employment Type',  controller: controller.employmentTypeController,borderColor: Colors.grey),
                  CustomTextField(labelText: 'Expertise Area',  controller: controller.expertiseController,borderColor: Colors.grey),
                  CustomTextField(labelText: 'Experience', controller: controller.experienceController,borderColor: Colors.grey),
                ],
              ),

              // ── Company Info ─────────────────────────────────
              // _SectionCard(
              //   title: 'Company Info',
              //   children: [
              //     CustomTextField(labelText: 'Company Name', controller: controller.companyNameController,borderColor: Colors.grey),
              //     CustomTextField(labelText: 'Location',     controller: controller.locationController,borderColor: Colors.grey),
              //     CustomTextField(labelText: 'Phone Number', controller: controller.companyPhoneController, keyboardType: TextInputType.phone,borderColor: Colors.grey),
              //     CustomTextField(labelText: 'Email',        controller: controller.companyEmailController, keyboardType: TextInputType.emailAddress,borderColor: Colors.grey,),
              //   ],
              // ),

              SizedBox(height: 24.h),

              // ── Update Button ────────────────────────────────
              Obx(() => CustomButton(
                label: 'Update Profile',
                isLoading: controller.isUpdateLoading.value,
                onPressed: () => controller.updateProfile(
                  filePath: imageFile?.path,
                  fileName: imageFile?.path.split('/').last,
                ),
              )),

              SizedBox(height: 24.h),
            ],
          ),
        );
      }),
    );
  }
}

// ── Section Card ──────────────────────────────────────────────────────────────
class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SectionCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
          bottom: 10.h,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.primaryColor.withOpacity(0.15)),
          ),
          child: Column(
            children: children
                .map((e) => Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: e,
            ))
                .toList(),
          ),
        ),
      ],
    );
  }
}