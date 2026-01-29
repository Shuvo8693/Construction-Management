import 'dart:io';
import 'package:charteur/core/helpers/photo_picker_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:charteur/core/theme/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/widgets.dart';

class CustomImageAvatar extends StatelessWidget {
  const CustomImageAvatar({
    super.key,
    this.radius = 26,
    this.image,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.fileImage,  this.showBorder = false,  this.onImagePicked,
  });

  final double radius;
  final String? image;
  final File? fileImage;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final bool showBorder;
  final   Function(XFile file)? onImagePicked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: top ?? 0,
        right: right ?? 0,
        left: left ?? 0,
        bottom: bottom ?? 0,
      ),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(showBorder ? 1.r : 0),
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: radius.r,
              backgroundColor: Colors.grey.shade200,
              child: fileImage != null
                  ? ClipOval(
                child: Image.file(
                  fileImage!,
                  width: 2 * radius.r,
                  height: 2 * radius.r,
                  fit: BoxFit.cover,
                ),
              )
                  : CustomNetworkImage(
                boxShape: BoxShape.circle,
                imageUrl: (image != null && image!.isNotEmpty)
                    ? "$image"
                    : "https://templates.joomla-monster.com/joomla30/jm-news-portal/components/com_djclassifieds/assets/images/default_profile.png",
              ),
            ),
          ),
          if(onImagePicked != null)
          Positioned(
            bottom: 8.h,
            right: 0,
            child: CustomContainer(
              onTap: () {
                PhotoPickerHelper.showPicker(context: context, onImagePicked: onImagePicked!);
              },
              paddingAll: 6.r,
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
              child: Center(
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                  size: 16.r,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
