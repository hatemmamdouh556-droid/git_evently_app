import 'package:evently_project/l10n/app_localizations.dart';
import 'package:evently_project/providers/app_language_provider.dart';
import 'package:evently_project/providers/app_theme_provider.dart';
import 'package:evently_project/utils/AppAssets.dart';
import 'package:evently_project/utils/AppColors.dart';
import 'package:evently_project/utils/AppStyles.dart';
import 'package:evently_project/utils/app_routes.dart';
import 'package:evently_project/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController pageController = PageController();
  String selectedLanguage = 'en';
  ThemeMode selectedTheme = ThemeMode.light;
  int currentPage = 0;

  final List<String> images = [
    AppAssets.intro_1,
    AppAssets.intro_2,
    AppAssets.intro_3,
    AppAssets.intro_4,
  ];
  final List<String> images_dark = [
    AppAssets.intro_1Dark,
    AppAssets.intro_2Dark,
    AppAssets.intro_3Dark,
    AppAssets.intro_4Dark,
  ];

  void nextPage() {
    if (currentPage < images.length - 1) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pushNamed(AppRoutes.homeRouteNamed);
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void initState() {
    super.initState();
    final themeProvider = Provider.of<AppThemeProvider>(context, listen: false);
    final languageProvider = Provider.of<AppLanguageProvider>(context, listen: false);

    selectedTheme = themeProvider.appTheme;
    selectedLanguage = languageProvider.appLanguage;
  }

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    final loc = AppLocalizations.of(context)!;

    late final List<String> titles = [
      loc.introTitle1,
      loc.introTitle2,
      loc.introTitle3,
      loc.introTitle4,
    ];

    late final List<String> description = [
      loc.introDesc1,
      loc.introDesc2,
      loc.introDesc3,
      loc.introDesc4,
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

        elevation: 0,
        centerTitle: true,

        leading: currentPage > 0
            ? IconButton(
                onPressed: previousPage,
                icon: Icon(
                  Icons.arrow_back,
                  color: selectedTheme == ThemeMode.dark
                      ? AppColors.whiteColor
                      : Theme.of(context).cardColor,
                ),
              )
            : null,

        title: Image.asset(AppAssets.logo, width: 100),

        actions: [
          if (currentPage != 0 && currentPage != images.length - 1)
            TextButton(
              onPressed: nextPage,
              child: Text(
                AppLocalizations.of(context)!.next,
                style: TextStyle(
                  color: selectedTheme == ThemeMode.light
                      ? AppColors.blueDarkColor
                      : AppColors.whiteColor,
                ),
              ),
            ),
        ],
      ),

      body: Column(
        children: [
          SizedBox(height: height * 0.02),

          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: images.length,

              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },

              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.02),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Image.asset(
                        selectedTheme == ThemeMode.dark
                            ? images_dark[index]
                            : images[index],
                        height: 400,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          images.length,
                              (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: 8,
                            width: currentPage == index ? 24 : 8,
                            decoration: BoxDecoration(
                              color: currentPage == index
                                  ? Theme.of(context).cardColor
                                  : Theme.of(context).cardColor.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      Text(
                        titles[index],
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),

                      SizedBox(height: 8),

                      Text(
                        description[index],
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),

                      if (currentPage == 0) ...{
                        SizedBox(height: height * 0.02),
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.language,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                languageProvider.changeLanguage('en');
                                selectedLanguage = 'en';
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: height * 0.02,
                                  vertical: width * 0.02,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: selectedLanguage == 'en'
                                      ? Theme.of(context).cardColor
                                      : AppColors.transparent,
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.english,
                                  style: TextStyle(
                                    color: selectedLanguage == 'en'
                                        ? AppColors.whiteColor
                                        : Theme.of(context).cardColor,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                languageProvider.changeLanguage('ar');

                                selectedLanguage = 'ar';
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: height * 0.02,
                                  vertical: width * 0.02,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: selectedLanguage == 'ar'
                                      ? Theme.of(context).cardColor
                                      : AppColors.transparent,
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.arabic,
                                  style: TextStyle(
                                    color: selectedLanguage == 'ar'
                                        ? AppColors.whiteColor
                                        : Theme.of(context).cardColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.01),
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.theme,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: height * 0.02,
                                vertical: width * 0.005,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: selectedTheme == ThemeMode.light
                                    ? Theme.of(context).cardColor
                                    : AppColors.transparent,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectedTheme = ThemeMode.light;
                                  });
                                  themeProvider.changeTheme(ThemeMode.light);
                                },
                                icon: Icon(
                                  Icons.wb_sunny_outlined,
                                  size: 25,
                                  color: selectedTheme == ThemeMode.light
                                      ? AppColors.whiteColor
                                      : Theme.of(context).cardColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: height * 0.02,
                                vertical: width * 0.005,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: selectedTheme == ThemeMode.light
                                    ? AppColors.transparent
                                    : Theme.of(context).cardColor,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectedTheme = ThemeMode.dark;
                                  });
                                  themeProvider.changeTheme(ThemeMode.dark);
                                },
                                icon: Icon(
                                  Icons.dark_mode_outlined,
                                  size: 25,
                                  color: selectedTheme == ThemeMode.light
                                      ? Theme.of(context).cardColor
                                      : AppColors.whiteColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      },

                      Spacer(),

                      SizedBox(
                        width: double.infinity,
                        height: 50,

                        child: ElevatedButton(
                          onPressed: nextPage,

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).cardColor,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),

                          child: Text(
                            currentPage == 0
                                ? AppLocalizations.of(context)!.let_s_start
                                : currentPage == images.length - 1
                                ? AppLocalizations.of(context)!.get_started
                                : AppLocalizations.of(context)!.next,
                            style: AppStyles.bold20White,
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                    ],
                  ),
                );
              },
            ),

          ),


          SizedBox(height: height * 0.02),
        ],
      ),
    );
  }
}
