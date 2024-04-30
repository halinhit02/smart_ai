import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_ai/controller/auth_controller.dart';
import 'package:smart_ai/model/user_model.dart';
import 'package:smart_ai/ui/widgets/custom_app_bar.dart';
import 'package:smart_ai/ui/widgets/custom_button.dart';
import 'package:smart_ai/ui/widgets/custom_dropdown.dart';
import 'package:smart_ai/ui/widgets/label_text_field_widget.dart';
import 'package:smart_ai/utils/constants/app_config.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';
import 'package:smart_ai/utils/helpers/dialog_helpers.dart';

class ChangeProfileScreen extends StatelessWidget {
  const ChangeProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    TextEditingController dobController = TextEditingController();
    UserModel? userModel = authController.userModel.value?.copyWith();
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  Text(
                    'Gender',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
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
                loading: authController.saveLoading.value,
                onTap: () {},
                text: 'Save',
              ),
            ),
          ),
        ],
      )),
    );
  }
}
