import 'package:flutter/material.dart';
import 'package:smart_ai/ui/widgets/custom_button.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';

import 'description_item.dart';

class PlanItem extends StatelessWidget {
  const PlanItem({
    super.key,
    required this.shortDescription,
    required this.price,
    required this.duration,
    required this.descriptionList,
    this.currentPlan = false,
    this.mostPopular = false,
    this.freePlan = false,
    this.purchasing = false,
    this.onSelectPlan,
  });

  final String shortDescription;
  final String price;
  final String duration;
  final List<String> descriptionList;
  final bool currentPlan;
  final bool mostPopular;
  final bool freePlan;
  final bool purchasing;
  final Function()? onSelectPlan;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(
            Dimensions.paddingSizeLarge,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                Dimensions.radiusSizeDefault,
              ),
              border: Border.all(
                width: 1,
                color: Colors.grey.shade200,
              )),
          child: Column(
            children: [
              currentPlan
                  ? Text(
                      price,
                      style: Theme.of(context).textTheme.headlineLarge,
                    )
                  : RichText(
                      text: TextSpan(
                      text: price,
                      children: [
                        TextSpan(
                          text: ' / $duration',
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                    )),
              const SizedBox(
                height: Dimensions.paddingSizeExtraSmall,
              ),
              Text(
                currentPlan
                    ? 'Your current plan'
                    : freePlan
                        ? 'Starter plan'
                        : shortDescription,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: Dimensions.paddingSizeDefault,
                ),
                child: Divider(
                  thickness: 1,
                  color: Colors.grey.shade200,
                ),
              ),
              ...List.generate(
                descriptionList.length,
                (index) => Padding(
                  padding: EdgeInsets.only(
                    top: index != 0 ? Dimensions.paddingSizeDefault : 0,
                  ),
                  child: DescriptionItem(
                    description: descriptionList[index],
                  ),
                ),
              ),
              if (!currentPlan && !freePlan)
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeDefault,
                      ),
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey.shade200,
                      ),
                    ),
                    CustomButton(
                      text: 'Select plan',
                      color: Theme.of(context).colorScheme.primary,
                      onTap: onSelectPlan,
                      loading: purchasing,
                      textStyle:
                          Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        mostPopular
            ? Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeSmall,
                    vertical: Dimensions.paddingSizeExtraSmall,
                  ),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(Dimensions.radiusSizeDefault),
                        bottomLeft:
                            Radius.circular(Dimensions.radiusSizeDefault),
                      )),
                  child: Text(
                    'Most Popular',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
