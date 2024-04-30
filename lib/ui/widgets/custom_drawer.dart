import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_ai/ui/widgets/custom_image.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';
import 'package:smart_ai/utils/constants/my_icons.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeLarge,
                ),
                child: Row(
                  children: [
                    const CustomImage(
                      path: MyIcons.appIcon,
                      size: 48,
                    ),
                    const SizedBox(
                      width: Dimensions.paddingSizeDefault,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SmartAI',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          'smart-ai@halinhit.com',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.black87,
                                    height: 1.8,
                                  ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){},
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSizeLarge,
                  ),
                  margin: const EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSizeLarge,
                    horizontal: Dimensions.paddingSizeLarge,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      Dimensions.radiusSizeDefault,
                    ),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: Dimensions.paddingSizeDefault,
                      ),
                      Container(
                        padding:
                            const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          CupertinoIcons.star_fill,
                          color: Colors.orange,
                          size: 16,
                        ),
                      ),
                      const SizedBox(
                        width: Dimensions.paddingSizeDefault,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Upgrade to PRO!',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(
                              height: Dimensions.paddingSizeExtraSmall,
                            ),
                            Text(
                              'Enjoy all the benefits and explore more possibilities.',
                              style:
                                  Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Colors.white,
                                        fontSize: 10,
                                        height: 1.5,
                                      ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          CupertinoIcons.chevron_forward,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSizeDefault,
                    horizontal: Dimensions.paddingSizeLarge,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        CupertinoIcons.add_circled,
                        size: 22,
                      ),
                      const SizedBox(
                        width: Dimensions.paddingSizeLarge,
                      ),
                      Text(
                        'New Chat',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSizeDefault,
                    horizontal: Dimensions.paddingSizeLarge,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        CupertinoIcons.time,
                        size: 22,
                      ),
                      const SizedBox(
                        width: Dimensions.paddingSizeLarge,
                      ),
                      Text(
                        'History',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 1,
                height: Dimensions.paddingSizeLarge,
                color: Colors.grey.shade300,
                indent: Dimensions.paddingSizeLarge,
                endIndent: Dimensions.paddingSizeLarge,
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSizeDefault,
                    horizontal: Dimensions.paddingSizeLarge,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        CupertinoIcons.settings_solid,
                        size: 22,
                      ),
                      const SizedBox(
                        width: Dimensions.paddingSizeLarge,
                      ),
                      Text(
                        'History',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
