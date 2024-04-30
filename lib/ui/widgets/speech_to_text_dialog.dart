import 'package:flutter/material.dart';
import 'package:smart_ai/ui/widgets/custom_image.dart';
import 'package:smart_ai/utils/constants/app_constants.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';
import 'package:smart_ai/utils/constants/my_icons.dart';

class SpeechToTechWidget extends StatefulWidget {
  const SpeechToTechWidget({super.key});

  @override
  State<SpeechToTechWidget> createState() => _SpeechToTechWidgetState();
}

class _SpeechToTechWidgetState extends State<SpeechToTechWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Dimensions.paddingSizeLarge,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeExtraLarge,
        vertical: Dimensions.paddingSizeExtraLarge,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppConstants.appName,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 250,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Align(
                    alignment: Alignment.center,
                    child: CustomImage(
                      path: MyIcons.voice,
                      size: 42,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          Text(
            'Try saying something',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(
            height: Dimensions.paddingSizeLarge,
          ),
          Text(
            'Listening...',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
