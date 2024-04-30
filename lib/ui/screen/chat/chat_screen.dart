import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_ai/ui/widgets/custom_app_bar.dart';
import 'package:smart_ai/ui/widgets/custom_button.dart';
import 'package:smart_ai/ui/widgets/custom_left_message.dart';

import 'package:smart_ai/ui/widgets/custom_right_message.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';

import '../../widgets/message_field_widget.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Hello there, I need some help.',
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.ellipsis_vertical,
              size: 20,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) => index % 2 == 0
                        ? CustomLeftMessage()
                        : CustomRightMessage(),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.paddingSizeLarge,
                        ),
                        child: CustomButton(
                          text: 'Stop generating...',
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(
                            Dimensions.radiusSizeDefault,
                          ),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.grey.shade100,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeLarge,
                            vertical: Dimensions.paddingSizeDefault,
                          ),
                          leading: Icon(
                            CupertinoIcons.square_fill,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          leadingPadding: const EdgeInsets.only(
                            right: Dimensions.paddingSizeSmall,
                          ),
                          textStyle:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.grey.shade800,
                                  ),
                          onTap: () {},
                        ),
                      ))
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeLarge,
              ),
              child: MessageFieldWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
