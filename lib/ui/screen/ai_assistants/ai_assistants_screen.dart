import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:smart_ai/controller/ads_controller.dart';
import 'package:smart_ai/controller/assistant_controller.dart';
import 'package:smart_ai/model/assistant_model.dart';
import 'package:smart_ai/ui/widgets/assistant_all_widget.dart';
import 'package:smart_ai/ui/widgets/assistant_item.dart';
import 'package:smart_ai/ui/widgets/custom_app_bar.dart';
import 'package:smart_ai/ui/widgets/custom_image.dart';
import 'package:smart_ai/utils/constants/app_constants.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';
import 'package:smart_ai/utils/constants/my_icons.dart';

import '../../../utils/constants/app_routes.dart';

class AIAssistantsScreen extends StatefulWidget {
  const AIAssistantsScreen({super.key});

  @override
  State<AIAssistantsScreen> createState() => _AIAssistantsScreenState();
}

class _AIAssistantsScreenState extends State<AIAssistantsScreen> {
  int menuIndex = 0;
  ItemScrollController scrollController = ItemScrollController();
  var assistantController = Get.find<AssistantController>();

  @override
  void initState() {
    super.initState();
    assistantController.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'AI Assistants',
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.upgradePlan),
            icon: const CustomImage(
              path: MyIcons.vip,
            ),
          ),
          const SizedBox(
            width: Dimensions.paddingSizeExtraSmall,
          ),
        ],
      ),
      body: Obx(
        () {
          List<AssistantModel> selectedAssistants = assistantController
              .assistantList
              .where((element) =>
                  element.type == AppConstants.menuAssistants[menuIndex])
              .toList();
          return assistantController.loading.isTrue
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    const SizedBox(
                      height: Dimensions.paddingSizeSmall,
                    ),
                    SizedBox(
                      height: 40,
                      child: ScrollablePositionedList.builder(
                          itemScrollController: scrollController,
                          itemCount: AppConstants.menuAssistants.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (itemCtx, index) {
                            bool isSelected = menuIndex == index;
                            return GestureDetector(
                              onTap: () {
                                menuIndex = index;
                                setState(() {});
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeLarge,
                                ),
                                margin: EdgeInsets.only(
                                  left: index == 0
                                      ? Dimensions.paddingSizeLarge
                                      : Dimensions.paddingSizeDefault,
                                  right: index ==
                                          AppConstants.menuAssistants.length - 1
                                      ? Dimensions.paddingSizeLarge
                                      : 0,
                                ),
                                decoration: BoxDecoration(
                                    color: isSelected
                                        ? Theme.of(context).colorScheme.primary
                                        : null,
                                    borderRadius: BorderRadius.circular(
                                      Dimensions.radiusSizeExtraLarge,
                                    ),
                                    border: Border.all(
                                      width: 2,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    )),
                                child: Text(
                                  AppConstants.menuAssistants[index],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: isSelected
                                            ? Colors.white
                                            : Theme.of(context)
                                                .colorScheme
                                                .primary,
                                      ),
                                ),
                              ),
                            );
                          }),
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeLarge,
                    ),
                    Expanded(
                      child: menuIndex == 0
                          ? AssistantAllWidget(
                              onMoreClicked: (index) {
                                menuIndex = index;
                                scrollController.jumpTo(index: index);
                                setState(() {});
                              },
                            )
                          : GridView.builder(
                              itemCount: selectedAssistants.length,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                crossAxisSpacing: Dimensions.paddingSizeDefault,
                                mainAxisSpacing: Dimensions.radiusSizeDefault,
                                childAspectRatio: 0.8,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingSizeLarge,
                              ),
                              itemBuilder: (itemCtx, index) => GestureDetector(
                                onTap: () {
                                  Get.find<AdsController>()
                                      .showInterstitialAd();
                                  Get.toNamed(
                                    AppRoutes.createAssistantChat(
                                      selectedAssistants[index].title,
                                      selectedAssistants[index].id,
                                    ),
                                  );
                                },
                                child: AssistantItem(
                                  item: selectedAssistants[index],
                                ),
                              ),
                            ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
