import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/app_routes.dart';

class ReadyAccountWidget extends StatelessWidget {
  const ReadyAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        TextButton(
          onPressed: () => Get.offNamed(AppRoutes.signInRoute),
          style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              textStyle: MaterialStateProperty.all(
                Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              )),
          child: const Text(
            'Sign in',
          ),
        ),
      ],
    );
  }
}
