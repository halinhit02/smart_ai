import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_ai/ui/screen/onboard/widgets/onboard_page_builder.dart';
import 'package:smart_ai/ui/widgets/custom_button.dart';
import 'package:smart_ai/utils/constants/app_routes.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';
import 'package:smart_ai/utils/constants/images.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    RxInt pageIndex = 0.obs;
    const pages = [
      OnboardPageBuilder(
        imagePath: Images.onboard1,
        title: 'The best AI Chatbot app in this century',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor...',
      ),
      OnboardPageBuilder(
        imagePath: Images.onboard2,
        title: 'Various AI Assistants to help you more',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor...',
      ),
      OnboardPageBuilder(
        imagePath: Images.onboard3,
        title: 'Try premium for your unlimited usage',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor...',
      ),
    ];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeLarge,
          ),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    pageIndex.value = index;
                  },
                  children: pages,
                ),
              ),
              const SizedBox(
                height: Dimensions.paddingSizeExtraLarge,
              ),
              Obx(
                () => AnimatedSmoothIndicator(
                  activeIndex: pageIndex.value,
                  count: pages.length,
                  effect: ExpandingDotsEffect(
                    dotWidth: 8,
                    dotHeight: 8,
                    spacing: 4,
                    dotColor: Colors.grey.shade300,
                    activeDotColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(
                height: Dimensions.paddingSizeExtraLarge,
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: Dimensions.paddingSizeDefault,
                  bottom: Dimensions.paddingSizeSmall,
                ),
                decoration: BoxDecoration(
                    border: Border(
                  top: BorderSide(
                    width: 1,
                    color: Colors.grey.shade100,
                  ),
                )),
                child: Row(
                  children: [
                    Expanded(
                        child: CustomButton(
                      text: 'Skip',
                      textColor: Theme.of(context).colorScheme.primary,
                      onTap: () => Get.offAndToNamed(AppRoutes.welcomeRoute),
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                    )),
                    const SizedBox(
                      width: Dimensions.paddingSizeDefault,
                    ),
                    Expanded(
                        child: CustomButton(
                      text: 'Next',
                      textColor: Colors.white,
                      onTap: () {
                        if (pageIndex.value < pages.length - 1) {
                          pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        } else {
                          Get.offAndToNamed(AppRoutes.welcomeRoute);
                        }
                      },
                    )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
