
import 'package:charteur/assets/assets.gen.dart';
import 'package:charteur/core/helpers/photo_picker_helper.dart';
import 'package:charteur/core/widgets/files/filepath_container.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:charteur/features/views/common/sites/view_models/sites_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FileAddScreen extends StatefulWidget {
  const FileAddScreen({super.key});

  @override
  State<FileAddScreen> createState() => _FileAddScreenState();
}

class _FileAddScreenState extends State<FileAddScreen> {
  final  _sitesController = Get.find<SitesController>();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final TextEditingController _fileNameController = TextEditingController();

  String _filePath = '';

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
              CustomTextField(
                  labelText: 'File Name',
                  hintText: 'Enter File Name',
                borderColor: Color(0xFFEDEDED),
                  controller: _fileNameController,
                filColor : Colors.transparent,

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
              onPressed: ()async{
              if(_globalKey.currentState!.validate()){
                await _sitesController.uploadSiteFile(fileName: _fileNameController.text, filePath: _filePath);
              }
            },
              label: 'Upload File',
            ),
          ),
        ),
      ),
    );
  }



  @override
  void dispose() {
    _fileNameController.dispose();
    super.dispose();
  }
}
