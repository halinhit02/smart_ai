import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:smart_ai/controller/auth_controller.dart';
import 'package:smart_ai/model/user_model.dart';
import 'package:smart_ai/ui/widgets/custom_app_bar.dart';
import 'package:smart_ai/ui/widgets/custom_button.dart';
import 'package:smart_ai/ui/widgets/custom_dropdown.dart';
import 'package:smart_ai/ui/widgets/label_text_field_widget.dart';
import 'package:smart_ai/utils/constants/app_config.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';
import 'package:smart_ai/utils/constants/my_icons.dart';
import 'package:smart_ai/utils/helpers/dialog_helpers.dart';
import 'package:smart_ai/utils/helpers/file_helpers.dart';

import '../../../utils/constants/images.dart';
import '../../widgets/custom_image.dart';

class ChangeProfileScreen extends StatelessWidget {
  const ChangeProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    TextEditingController dobController = TextEditingController();
    UserModel? userModel = authController.userModel.value?.copyWith();
    Rx<XFile?> imageFile = Rx(null);

    if (userModel == null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        DialogHelpers.showErrorMessage('Please login in again.');
      });
      return const SizedBox();
    }
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Change Profile',
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeLarge,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Obx(
                          () => imageFile.value != null
                              ? CustomImage(
                                  path: imageFile.value!.path,
                                  isFilePath: true,
                                  size: 92,
                                  isOval: true,
                                )
                              : CustomImage(
                                  path: userModel.photo ?? Images.defaultPhoto,
                                  size: 92,
                                  isOval: true,
                                  boxShape: BoxShape.circle,
                                ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                            onTap: () async {
                              var file = await FileHelpers.pickImage();
                              debugPrint(file?.path);
                              if (file != null) {
                                imageFile.value = file;
                              }
                            },
                            child: const CustomImage(
                              path: MyIcons.edit,
                              size: 24,
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeLarge,
                  ),
                  LabelTextFieldWidget(
                    label: 'Full Name',
                    hint: 'Full Name',
                    initValue: userModel.fullName,
                    onTextChanged: (value) {
                      userModel.fullName = value;
                    },
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  LabelTextFieldWidget(
                    label: 'Email',
                    hint: 'Email',
                    initValue: userModel.email,
                    onTextChanged: (value) {
                      userModel.email = value;
                    },
                  ),
                  const SizedBox(
                    height: Dimensions.radiusSizeDefault,
                  ),
                  LabelTextFieldWidget(
                    label: 'Date of Birth',
                    hint: 'Date of Birth',
                    initValue: userModel.birthday != null
                        ? DateFormat('dd/MM/yyyy').format(userModel.birthday!)
                        : '',
                    controller: dobController,
                    isDateSelected: true,
                    onTap: () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      if (selectedDate != null) {
                        String dateStr =
                            DateFormat('dd/MM/yyyy').format(selectedDate);
                        dobController.text = dateStr;
                        userModel.birthday = selectedDate;
                      }
                    },
                    onTextChanged: (value) {
                      if (userModel.birthday != null) {
                        dobController.text =
                            DateFormat.yMd().format(userModel.birthday!);
                      }
                    },
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Gender',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeSmall,
                  ),
                  CustomDropdownButton(
                    items: AppConfig.genderName,
                    values: AppConfig.genders,
                    hint: 'Gender',
                    value: AppConfig.genders.contains(userModel.gender)
                        ? userModel.gender
                        : userModel.gender,
                    buttonWidth: double.maxFinite,
                    dropdownColor: Colors.grey.shade100,
                    onChanged: (value) {
                      if (value != null) {
                        userModel.gender = value;
                      }
                    },
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  LabelTextFieldWidget(
                    label: 'Street Address',
                    hint: 'Street Address',
                    initValue: userModel.address,
                    onTextChanged: (value) {
                      userModel.address = value;
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeLarge,
              vertical: Dimensions.paddingSizeDefault,
            ),
            child: Obx(
              () => CustomButton(
                loading: authController.updatingUser.value,
                onTap: () =>
                    authController.editUser(imageFile.value, userModel),
                text: 'Save',
              ),
            ),
          ),
        ],
      )),
    );
  }
}
