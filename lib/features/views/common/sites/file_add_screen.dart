import 'package:auto_route/auto_route.dart';
import 'package:charteur/assets/assets.gen.dart';
import 'package:charteur/core/helpers/photo_picker_helper.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class FileAddScreen extends StatefulWidget {
  const FileAddScreen({super.key});

  @override
  State<FileAddScreen> createState() => _FileAddScreenState();
}

class _FileAddScreenState extends State<FileAddScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final TextEditingController _fileNameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: 'Add a File'),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: _globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                label: 'File Name',
                hint: 'Enter File Name',
                controller: _fileNameController,
              ),
            
              SizedBox(height: 8.h,),
              CustomText(
                fontSize: 12.sp,
                text: 'Upload pdf Architectural Site Plan ',bottom: 6.h, fontWeight: FontWeight.w500,),
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
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(16.w),
          child: CustomButton(onPressed: (){
            if(_globalKey.currentState!.validate()){

            }
          },
            label: 'Upload File',
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
    _fileNameController.dispose();
    super.dispose();
  }
}
