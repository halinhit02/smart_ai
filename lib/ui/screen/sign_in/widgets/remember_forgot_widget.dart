import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_ai/utils/constants/app_routes.dart';

import '../../../../utils/constants/dimensions.dart';
import '../../../widgets/custom_check_box.dart';

class RememberForgotWidget extends StatelessWidget {
  const RememberForgotWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCheckBox(
          value: true,
          onChanged: (value) {},
        ),
        const SizedBox(
          width: Dimensions.paddingSizeExtraSmall,
        ),
        Expanded(
          child: Text(
            'Remember me',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        const SizedBox(
          width: Dimensions.radiusSizeDefault,
        ),
        TextButton(
          onPressed: () => Get.toNamed(AppRoutes.forgotPasswordRoute),
          style: ButtonStyle(
              textStyle: MaterialStatePropertyAll(
                  Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ))),
          child: const Text(
            'Forgot password?',
          ),
        ),
      ],
    );
  }
}
