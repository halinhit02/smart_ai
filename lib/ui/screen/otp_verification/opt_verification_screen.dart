import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_ai/controller/auth_controller.dart';
import 'package:smart_ai/ui/widgets/custom_app_bar.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';

class OTPVerificationScreen extends StatelessWidget {
  const OTPVerificationScreen({
    super.key,
    required this.redirectRoute,
  });

  final String redirectRoute;

  @override
  Widget build(BuildContext context) {
    final TextEditingController codeController = TextEditingController();
    AuthController authController = Get.find();
    Timer? countdownTimer;
    RxInt remainDuration = 0.obs;

    final defaultPinTheme = PinTheme(
      width: (Get.width - 50) / 6,
      height: (Get.width - 50) / 6,
      textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(
          Dimensions.radiusSizeDefault,
        ),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
        color: Theme.of(context).colorScheme.primary,
        width: 2,
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Colors.grey.shade200,
      ),
    );

    void startCountDown() {
      remainDuration.value = 60;
      countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (remainDuration.value == 0) {
          countdownTimer?.cancel();
          return;
        }
        remainDuration.value -= 1;
      });
    }

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeLarge,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: Dimensions.paddingSizeSmall,
            ),
            Text(
              'OTP code verification 🔐',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(
              height: Dimensions.paddingSizeSmall,
            ),
            Text(
              'We have sent an OTP code to your phone number ${authController.phoneNumber}. Enter the OTP code below to verify.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: Dimensions.paddingSizeDefault,
            ),
            Obx(
              () => authController.verifyOtpLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeLarge,
                      ),
                      child: Pinput(
                        length: 6,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        submittedPinTheme: submittedPinTheme,
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        androidSmsAutofillMethod:
                            AndroidSmsAutofillMethod.smsRetrieverApi,
                        showCursor: true,
                        listenForMultipleSmsOnAndroid: true,
                        autofocus: true,
                        controller: codeController,
                        onCompleted: (code) =>
                            authController.verifyOtp(code, redirectRoute),
                      ),
                    ),
            ),
            const SizedBox(
              height: Dimensions.paddingSizeDefault,
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive code?",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeSmall,
                  ),
                  Obx(
                    () => remainDuration.value > 0
                        ? RichText(
                            text: TextSpan(
                              text: "You can resend code in ",
                              children: [
                                TextSpan(
                                    text: remainDuration.value.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        )),
                                const TextSpan(text: ' s'),
                              ],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          )
                        : TextButton(
                            style: ButtonStyle(
                                textStyle: MaterialStatePropertyAll(
                              Theme.of(context).textTheme.bodyMedium,
                            )),
                            onPressed: () {
                              startCountDown();
                              authController
                                  .verifyPhone(authController.phoneNumber);
                            },
                            child: Text(
                              'Resend code'.tr,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
