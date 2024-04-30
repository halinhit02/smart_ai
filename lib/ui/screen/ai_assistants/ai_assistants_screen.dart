import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:smart_ai/ui/widgets/assistant_all_widget.dart';
import 'package:smart_ai/ui/widgets/assistant_item.dart';
import 'package:smart_ai/ui/widgets/custom_app_bar.dart';
import 'package:smart_ai/utils/constants/app_constants.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';

import '../../../utils/constants/app_routes.dart';

class AIAssistantsScreen extends StatefulWidget {
  const AIAssistantsScreen({super.key});

  @override
  State<AIAssistantsScreen> createState() => _AIAssistantsScreenState();
}

class _AIAssistantsScreenState extends State<AIAssistantsScreen> {
  int menuIndex = 0;
  ItemScrollController scrollController = ItemScrollController();
  late BuildContext menuItemCtx;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> selectedAssistants = AppConstants.assistants
        .where((element) =>
            element['type'] == AppConstants.menuAssistants[menuIndex])
        .toList();
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'AI Assistants',
      ),
      body: Column(
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
                  menuItemCtx = itemCtx;
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
                        right: index == AppConstants.menuAssistants.length - 1
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
                            color: Theme.of(context).colorScheme.primary,
                          )),
                      child: Text(
                        AppConstants.menuAssistants[index],
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? Colors.white
                                  : Theme.of(context).colorScheme.primary,
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
                      childAspectRatio: 0.81,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeLarge,
                    ),
                    itemBuilder: (itemCtx, index) => GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.createAssistantChat(
                            selectedAssistants[index]['title'] ?? '',
                            selectedAssistants[index]['description'] ?? '',
                            selectedAssistants[index]['index'].toString(),
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
      ),
    );
  }
}
