import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/app_routes.dart';

class NotAccountWidget extends StatelessWidget {
  const NotAccountWidget({
    super.key,
    this.offNamed = false,
  });

  final bool offNamed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        TextButton(
          onPressed: () => offNamed
              ? Get.offNamed(AppRoutes.signUpRoute)
              : Get.toNamed(AppRoutes.signUpRoute),
          style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              textStyle: MaterialStateProperty.all(
                Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              )),
          child: const Text(
            'Sign up',
          ),
        ),
      ],
    );
  }
}
