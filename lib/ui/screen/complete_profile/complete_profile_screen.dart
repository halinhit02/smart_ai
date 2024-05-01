import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:smart_ai/controller/auth_controller.dart';
import 'package:smart_ai/model/sign_up_model.dart';
import 'package:smart_ai/ui/widgets/custom_app_bar.dart';
import 'package:smart_ai/ui/widgets/custom_dropdown.dart';
import 'package:smart_ai/ui/widgets/label_text_field_widget.dart';
import 'package:smart_ai/utils/constants/app_config.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';

import '../../../utils/constants/images.dart';
import '../../../utils/constants/my_icons.dart';
import '../../../utils/helpers/file_helpers.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_image.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    TextEditingController dobController = TextEditingController();
    SignUpModel? signUpModel = SignUpModel(
      gender: AppConfig.genders.first,
    );
    Rx<XFile?> imageFile = Rx(null);

    return Scaffold(
      appBar: const CustomAppBar(),
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
                  Text(
                    'Complete your profile 📋',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  Text(
                    "Please enter your profile. Don't worry, only you can see your personal data. No one else will be able to see it. Or you can skip it for now.",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeLarge,
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
                              : const CustomImage(
                                  path: Images.defaultPhoto,
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
                    height: Dimensions.paddingSizeDefault,
                  ),
                  LabelTextFieldWidget(
                    label: 'Full Name',
                    hint: 'Full Name',
                    onTextChanged: (value) {
                      signUpModel.fullName = value;
                    },
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  LabelTextFieldWidget(
                    label: 'Email',
                    hint: 'Email',
                    onTextChanged: (value) {
                      signUpModel.email = value;
                    },
                  ),
                  const SizedBox(
                    height: Dimensions.radiusSizeDefault,
                  ),
                  LabelTextFieldWidget(
                    label: 'Date of Birth',
                    hint: 'Date of Birth',
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
                        signUpModel.birthday = selectedDate;
                      }
                    },
                    onTextChanged: (value) {
                      if (signUpModel.birthday != null) {
                        dobController.text =
                            DateFormat.yMd().format(signUpModel.birthday!);
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
                    value: AppConfig.genders.contains(signUpModel.gender)
                        ? signUpModel.gender
                        : AppConfig.genders.first,
                    buttonWidth: double.maxFinite,
                    dropdownColor: Colors.grey.shade100,
                    onChanged: (value) {
                      if (value != null) {
                        signUpModel.gender = value;
                      }
                    },
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  LabelTextFieldWidget(
                    label: 'Street Address',
                    hint: 'Street Address',
                    onTextChanged: (value) {
                      signUpModel.address = value;
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
                loading: authController.saveLoading.value,
                onTap: () {
                  authController.createUser(imageFile.value, signUpModel);
                },
                text: 'Save',
              ),
            ),
          ),
        ],
      )),
    );
  }
}
