import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_ai/controller/ads_controller.dart';
import 'package:smart_ai/controller/assistant_controller.dart';
import 'package:smart_ai/ui/widgets/assistant_item.dart';
import 'package:smart_ai/utils/constants/app_constants.dart';
import 'package:smart_ai/utils/constants/app_routes.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';

class AssistantAllWidget extends StatelessWidget {
  const AssistantAllWidget({
    super.key,
    this.onMoreClicked,
  });

  final Function(int)? onMoreClicked;

  @override
  Widget build(BuildContext context) {
    AssistantController assistantController = Get.find();
    List<String> menuAssistantList = AppConstants.menuAssistants.sublist(1);
    return Scaffold(
      body: ListView.builder(
          itemCount: menuAssistantList.length,
          itemBuilder: (itemCtx, index) {
            var selectedAssistants = assistantController.assistantList
                .where((element) => element.type == menuAssistantList[index])
                .toList();
            return Container(
              margin: const EdgeInsets.only(
                bottom: Dimensions.paddingSizeLarge,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: Dimensions.paddingSizeLarge,
                      ),
                      Expanded(
                        child: Text(
                          menuAssistantList[index],
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                      const SizedBox(
                        width: Dimensions.radiusSizeDefault,
                      ),
                      IconButton(
                        onPressed: onMoreClicked != null
                            ? () => onMoreClicked!(index + 1)
                            : null,
                        alignment: Alignment.centerRight,
                        icon: Icon(
                          CupertinoIcons.arrow_right,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(
                        width: Dimensions.paddingSizeDefault,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: Dimensions.radiusSizeDefault,
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 236),
                    child: ListView.builder(
                      itemExtent: 185,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: selectedAssistants.length,
                      itemBuilder: (itemCtx, index) => GestureDetector(
                        onTap: () {
                          Get.find<AdsController>().showInterstitialAd();
                          Get.toNamed(AppRoutes.createAssistantChat(
                            selectedAssistants[index].title,
                            selectedAssistants[index].id,
                          ));
                        },
                        child: AssistantItem(
                          item: selectedAssistants[index],
                          margin: EdgeInsets.only(
                            left: index == 0
                                ? Dimensions.paddingSizeLarge
                                : Dimensions.radiusSizeDefault,
                            right: index == selectedAssistants.length - 1
                                ? Dimensions.paddingSizeLarge
                                : 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
