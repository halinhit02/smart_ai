import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:smart_ai/controller/ads_controller.dart';
import 'package:smart_ai/ui/screen/account/account_screen.dart';
import 'package:smart_ai/ui/screen/ai_assistants/ai_assistants_screen.dart';
import 'package:smart_ai/ui/screen/ai_image/ai_image_screen.dart';
import 'package:smart_ai/ui/screen/history/history_screen.dart';
import 'package:smart_ai/ui/screen/start_chat/start_chat_screen.dart';
import 'package:smart_ai/ui/widgets/custom_image.dart';
import 'package:smart_ai/utils/constants/app_config.dart';
import 'package:smart_ai/utils/constants/my_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    // Set OpenAI API key
    OpenAI.apiKey =
        FirebaseRemoteConfig.instance.getString(AppConfig.openAIKey);
    // Gemini init
    Gemini.init(
        apiKey: FirebaseRemoteConfig.instance.getString(AppConfig.geminiKey));
    WidgetsFlutterBinding.ensureInitialized()
        .addPostFrameCallback((_) => initPlugin());
  }

  Future initPlugin() async {
    final TrackingStatus status =
        await AppTrackingTransparency.trackingAuthorizationStatus;
    if (status == TrackingStatus.notDetermined) {
      // Show a custom explainer dialog before the system dialog
      await showCustomTrackingDialog(context);
      // Wait for dialog popping animation
      await Future.delayed(const Duration(milliseconds: 200));
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  }

  Future showCustomTrackingDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Dear User'),
        content: const Text(
          'We care about your privacy and data security. We keep this app free by showing ads. '
          'Can we continue to use your data to tailor ads for you?\n\nYou can change your choice anytime in the app settings. '
          'Our partners will collect data and use a unique identifier on your device to show you ads.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: pageIndex,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          onTap: (index) {
            pageIndex = index;
            setState(() {});
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: const CustomImage(
                  path: MyIcons.chatInactive,
                  size: 22,
                ),
                activeIcon: CustomImage(
                  path: MyIcons.chatActive,
                  color: Theme.of(context).colorScheme.primary,
                  size: 22,
                ),
                label: 'Chat'),
            BottomNavigationBarItem(
                icon: const CustomImage(
                  path: MyIcons.assistantsInactive,
                  size: 22,
                ),
                activeIcon: CustomImage(
                  path: MyIcons.assistantsActive,
                  color: Theme.of(context).colorScheme.primary,
                  size: 22,
                ),
                label: 'AI Assistants'),
            BottomNavigationBarItem(
                icon: const CustomImage(
                  path: MyIcons.imageInactive,
                  size: 22,
                ),
                activeIcon: CustomImage(
                  path: MyIcons.imageActive,
                  color: Theme.of(context).colorScheme.primary,
                  size: 22,
                ),
                label: 'AI Image'),
            BottomNavigationBarItem(
                icon: const CustomImage(
                  path: MyIcons.historyInactive,
                  size: 22,
                ),
                activeIcon: CustomImage(
                  path: MyIcons.historyActive,
                  size: 22,
                  color: Theme.of(context).colorScheme.primary,
                ),
                label: 'History'),
            BottomNavigationBarItem(
                icon: const CustomImage(
                  path: MyIcons.profileInactive,
                  size: 22,
                ),
                activeIcon: CustomImage(
                  path: MyIcons.profileActive,
                  color: Theme.of(context).colorScheme.primary,
                  size: 22,
                ),
                label: 'Account'),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: IndexedStack(
                index: pageIndex,
                children: const [
                  StartChatScreen(),
                  AIAssistantsScreen(),
                  AIImageScreen(),
                  HistoryScreen(),
                  AccountScreen(),
                ],
              ),
            ),
            GetBuilder<AdsController>(builder: (adsController) {
              return adsController.bannerAd != null
                  ? Container(
                      alignment: Alignment.center,
                      width: adsController.bannerAd!.size.width.toDouble(),
                      height: adsController.bannerAd!.size.height.toDouble(),
                      child: AdWidget(ad: adsController.bannerAd!),
                    )
                  : const SizedBox();
            }),
          ],
        ));
  }
}
