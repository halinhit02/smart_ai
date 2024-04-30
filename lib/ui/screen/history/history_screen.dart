import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_ai/ui/screen/history/widgets/history_item.dart';
import 'package:smart_ai/ui/widgets/custom_app_bar.dart';
import 'package:smart_ai/ui/widgets/custom_image.dart';
import 'package:smart_ai/utils/constants/app_routes.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';
import 'package:smart_ai/utils/constants/images.dart';
import 'package:smart_ai/utils/constants/my_icons.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isEmpty = false;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'History',
        actions: [
          IconButton(
              onPressed: () => Get.toNamed(AppRoutes.historySearchRoute),
              icon: const CustomImage(
                path: MyIcons.search,
                size: 22,
              )),
          IconButton(
            onPressed: () {},
            icon: const CustomImage(
              path: MyIcons.delete,
              size: 22,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {},
          child: isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomImage(
                      path: Images.empty,
                      height: Get.height * 0.2,
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeExtraLarge,
                    ),
                    Text(
                      'Empty',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade900,
                          ),
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeSmall,
                    ),
                    Text(
                      'You have no history.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey.shade900,
                          ),
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: 10,
                  itemBuilder: (itemCtx, index) => GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.chatRoute),
                    child: HistoryItem(),
                  ),
                ),
        ),
      ),
    );
  }
}
