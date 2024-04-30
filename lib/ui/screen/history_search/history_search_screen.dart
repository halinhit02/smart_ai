import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_ai/ui/screen/history_search/widgets/not_found_screen.dart';
import 'package:smart_ai/ui/screen/history_search/widgets/result_search_item.dart';
import 'package:smart_ai/ui/widgets/custom_app_bar.dart';
import 'package:smart_ai/ui/widgets/custom_image.dart';
import 'package:smart_ai/ui/widgets/custom_text_field.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';
import 'package:smart_ai/utils/constants/my_icons.dart';

class HistorySearchScreen extends StatelessWidget {
  const HistorySearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isNotFound = false;
    return Scaffold(
      appBar: CustomAppBar(
        forceMaterialTransparency: true,
        titleSpacing: 0,
        titleWidget: Padding(
          padding: const EdgeInsets.only(
            right: Dimensions.paddingSizeLarge,
          ),
          child: CustomTextField(
            prefixIcon: const CustomImage(
              path: MyIcons.search,
              size: 18,
            ),
            suffixIcon: const Icon(
              CupertinoIcons.clear,
              size: 18,
            ),
            hint: '',
          ),
        ),
      ),
      body: SafeArea(
          child: isNotFound
              ? NotFoundScreen()
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: Dimensions.paddingSizeLarge,
                        right: Dimensions.paddingSizeSmall,
                        top: Dimensions.radiusSizeDefault,
                        bottom: Dimensions.paddingSizeExtraSmall,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Recent Searches',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade800,
                                  ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            alignment: Alignment.centerRight,
                            icon: const Icon(
                              CupertinoIcons.clear,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Color(0xFFEEEEEE),
                      indent: Dimensions.paddingSizeLarge,
                      endIndent: Dimensions.paddingSizeLarge,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (itemCtx, index) => ResultSearchItem(),
                      ),
                    ),
                  ],
                )),
    );
  }
}
