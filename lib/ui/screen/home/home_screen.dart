import 'package:dart_openai/dart_openai.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
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
        body: IndexedStack(
          index: pageIndex,
          children: const [
            StartChatScreen(),
            AIAssistantsScreen(),
            AIImageScreen(),
            HistoryScreen(),
            AccountScreen(),
          ],
        ));
  }
}
