import 'package:flutter/material.dart';

import '../../core/extensions/context.extension.dart';
import '../../core/extensions/rx.extension.dart';
import '../../core/ui/color.ui.dart';
import '../../core/ui/screen.ui.dart';
import '../../core/util/constants.dart';
import '../../infrastructure/state/my_profile.state.dart';
import '../home/home.page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentIndex = 0.rx;
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: StreamBuilder<int>(
        stream: currentIndex.stream,
        builder: (context, snapshot) => IndexedStack(
          index: currentIndex.value,
          children: const [
            HomePage(),
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Center(child: Text('Search Page')),
            ),
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Center(child: Text('Library Page')),
            ),
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Center(child: Text('Settings Page')),
            ),
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
    );
  }
}
