import 'dart:ui';

abstract class AppColor {
  // HIGHLIGHT
  Color highlight_1 = const Color(0x00000000);
  Color highlight_2 = const Color(0x00000000);
  Color highlight_3 = const Color(0x00000000);

  // SUPPORT
  Color green_1 = const Color(0x00000000);
  Color green_2 = const Color(0x00000000);
  Color green_3 = const Color(0x00000000);
  Color green_4 = const Color(0x00000000);

  Color red_1 = const Color(0x00000000);
  Color red_2 = const Color(0x00000000);
  Color red_3 = const Color(0x00000000);
  Color red_4 = const Color(0x00000000);

  Color blue_1 = const Color(0x00000000);
  Color blue_2 = const Color(0x00000000);
  Color blue_3 = const Color(0x00000000);
  Color blue_4 = const Color(0x00000000);

  Color violet_1 = const Color(0x00000000);
  Color violet_2 = const Color(0x00000000);
  Color violet_3 = const Color(0x00000000);
  Color violet_4 = const Color(0x00000000);

  Color onSupportLight = const Color(0x00000000);

  // BACKGROUND
  Color background = const Color(0x00000000);
  Color surface = const Color(0x00000000);

  Color onBackground_1 = const Color(0x00000000);
  Color onBackground_2 = const Color(0x00000000);
  Color onBackground_3 = const Color(0x00000000);
  Color onBackground_4 = const Color(0x00000000);
  Color onBackground_5 = const Color(0x00000000);
  Color onBackground_6 = const Color(0x00000000);
  Color onBackground_7 = const Color(0x00000000);
  Color onBackground_8 = const Color(0x00000000);
  Color onBackground_9 = const Color(0x00000000);

  // PRIMARY
  Color primary_0 = const Color(0x00000000);
  Color primary_1 = const Color(0x00000000);
  Color primary_2 = const Color(0x00000000);
  Color primary_3 = const Color(0x00000000);
  Color primary_4 = const Color(0x00000000);
  Color primary_5 = const Color(0x00000000);
  Color primary_6 = const Color(0x00000000);
  Color primary_7 = const Color(0x00000000);
  Color primary_8 = const Color(0x00000000);
  Color primary_9 = const Color(0x00000000);

  List<Color> primaryGradient = [
    const Color(0x00000000),
    const Color(0x00000000),
  ];
  Color onPrimaryDark = const Color(0x00000000);
  Color onPrimaryLight = const Color(0x00000000);
}

class AppLightTheme extends AppColor {
  AppLightTheme() {
    highlight_1 = const Color(0xffFFFFFF);
    highlight_2 = const Color(0xffFFF9E9);
    highlight_3 = const Color(0xffFFECBA);

    green_1 = const Color(0xffD9F6E7);
    green_2 = const Color(0xff98E9BE);
    green_3 = const Color(0xff24C771);
    green_4 = const Color(0xff0A925B);

    red_1 = const Color(0xffFFE9E2);
    red_2 = const Color(0xffF4BCB4);
    red_3 = const Color(0xffE85959);
    red_4 = const Color(0xffB92F24);

    blue_1 = const Color(0xffE4F3FF);
    blue_2 = const Color(0xff95CDFF);
    blue_3 = const Color(0xff556799);
    blue_4 = const Color(0xff3645B8);

    violet_1 = const Color(0xffF6E9FF);
    violet_2 = const Color(0xffE2BFFD);
    violet_3 = const Color(0xffBC66FC);
    violet_4 = const Color(0xff851CEA);

    onSupportLight = const Color(0xffFFFFFF);

    background = const Color(0xffF5F6F6);
    surface = const Color(0xffFFFFFF);

    onBackground_1 = const Color(0xffF9F8F8);
    onBackground_2 = const Color(0xffF0F0EF);
    onBackground_3 = const Color(0xffE2E2E1);
    onBackground_4 = const Color(0xffBFBFBF);
    onBackground_5 = const Color(0xffA1A1A0);
    onBackground_6 = const Color(0xff787877);
    onBackground_7 = const Color(0xff636363);
    onBackground_8 = const Color(0xff444443);
    onBackground_9 = const Color(0xff2A2A2A);

    primary_0 = const Color(0xffFFF9E9);
    primary_1 = const Color(0xffFFECBA);
    primary_2 = const Color(0xffF4D06F);
    primary_3 = const Color(0xffEFC031);
    primary_4 = const Color(0xffEBB200);
    primary_5 = const Color(0xffE8A600);
    primary_6 = const Color(0xffE89800);
    primary_7 = const Color(0xffE98600);
    primary_8 = const Color(0xffE97400);
    primary_9 = const Color(0xffE85100);

    primaryGradient = [const Color(0xffE89800), const Color(0xffF4D06F)];
    onPrimaryDark = const Color(0xff191522);
    onPrimaryLight = const Color(0xffFFFFFF);
  }
}

class AppDarkTheme extends AppColor {
  AppDarkTheme() {
    highlight_1 = const Color(0xffFFFFFF);
    highlight_2 = const Color(0xffFFF9E9).withAlpha(51); // 0.2 * 255 = 51
    highlight_3 = const Color(
      0xffFFECBA,
    ).withAlpha(77); // 0.3 * 255 = 76.5 ~ 77

    green_1 = const Color(0xffD9F6E7);
    green_2 = const Color(0xff98E9BE);
    green_3 = const Color(0xff24C771);
    green_4 = const Color(0xff24C771);

    red_1 = const Color(0xffFFE9E2);
    red_2 = const Color(0xffF4BCB4);
    red_3 = const Color(0xffE85959);
    red_4 = const Color(0xffEA5338);

    blue_1 = const Color(0xffE4F3FF);
    blue_2 = const Color(0xff95CDFF);
    blue_3 = const Color(0xff5C8DEB);
    blue_4 = const Color(0xff5C8DEB);

    violet_1 = const Color(0xffF6E9FF);
    violet_2 = const Color(0xffE2BFFD);
    violet_3 = const Color(0xffBC66FC);
    violet_4 = const Color(0xffBC66FC);

    onSupportLight = const Color(0xffFFFFFF);

    background = const Color(0xff232322);
    surface = const Color(0xff383837);

    onBackground_1 = const Color(0xff313130);
    onBackground_2 = const Color(0xff545453);
    onBackground_3 = const Color(0xff787877);
    onBackground_4 = const Color(0xffA1A1A0);
    onBackground_5 = const Color(0xffBFBFBF);
    onBackground_6 = const Color(0xffBFBFBF);
    onBackground_7 = const Color(0xffBFBFBF);
    onBackground_8 = const Color(0xffF6F6F5);
    onBackground_9 = const Color(0xffFFFFFF);

    primary_0 = const Color(0xffFFF9E9);
    primary_1 = const Color(0xffFFECBA);
    primary_2 = const Color(0xffF4D06F);
    primary_3 = const Color(0xffEFC031);
    primary_4 = const Color(0xffEBB200);
    primary_5 = const Color(0xffEBB200);
    primary_6 = const Color(0xffEBB200);
    primary_7 = const Color(0xffE98600);
    primary_8 = const Color(0xffE97400);
    primary_9 = const Color(0xffE85100);

    primaryGradient = [const Color(0xffE89800), const Color(0xffF4D06F)];
    onPrimaryDark = const Color(0xff191522);
    onPrimaryLight = const Color(0xffFFFFFF);
  }
}
