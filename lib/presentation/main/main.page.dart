import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/config/get_it.dart';
import '../../core/extensions/context.extension.dart';
import '../../core/extensions/rx.extension.dart';
import '../../core/ui/color.ui.dart';
import '../../core/ui/screen.ui.dart';
import '../../core/util/constants.dart';
import '../../domain/repository/profile.repository.dart';
import '../../infrastructure/routing/app_pages.dart';
import '../../infrastructure/state/my_profile.state.dart';
import '../home/home.page.dart';
import '../library/library.page.dart';
import '../search/search.page.dart';
import '../settings_page/settings.page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final currentIndex = 0.rx;
  final profileRepository = getIt.get<ProfileRepository>();

  @override
  void initState() {
    super.initState();
  }

  Future<void> setProfile() async {
    final profileRes = await profileRepository.getProfile();
    AppPages.navKey.currentContext?.provider
        .read(myProfileStateProvider.notifier)
        .setProfile(profileRes.data!);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          surfaceTintColor: colorTransparent,
        ),
        body: StreamBuilder<int>(
          stream: currentIndex.stream,
          builder: (context, snapshot) => IndexedStack(
            index: currentIndex.value,
            children: const [
              HomePage(),
              SearchPage(),
              LibraryPage(),
              SettingsPage(),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          width: screenWidth(context),
          padding: const EdgeInsets.only(top: 4, bottom: 8),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: colorLightGrey,
                width: 0.5,
              ),
            ),
          ),
          child: StreamBuilder<int>(
            stream: currentIndex.stream,
            builder: (context, snapshot) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () => currentIndex.value = 0,
                  icon: Icon(
                    Icons.home,
                    color:
                        currentIndex.value == 0 ? colorPrimary : colorLightGrey,
                  ),
                ),
                IconButton(
                  onPressed: () => currentIndex.value = 1,
                  icon: Icon(
                    Icons.search,
                    color:
                        currentIndex.value == 1 ? colorPrimary : colorLightGrey,
                  ),
                ),
                IconButton(
                  onPressed: () => currentIndex.value = 2,
                  icon: Icon(
                    Icons.library_books,
                    color:
                        currentIndex.value == 2 ? colorPrimary : colorLightGrey,
                  ),
                ),
                IconButton(
                  onPressed: () => currentIndex.value = 3,
                  icon: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: Image.network(
                        context.provider
                                .read(myProfileStateProvider)
                                ?.avatarUrl ??
                            Constants.DEFAULT_AVATAR,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
