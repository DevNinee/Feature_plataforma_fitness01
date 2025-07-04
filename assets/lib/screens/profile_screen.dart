import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mighty_fitness/screens/home_screen.dart';
import 'package:mighty_fitness/screens/workout_history_screen.dart';
import '../screens/reminder_screen.dart';
import '../extensions/common.dart';
import '../screens/subscription_detail_screen.dart';
import '../../extensions/constants.dart';
import '../../extensions/extension_util/context_extensions.dart';
import '../../extensions/extension_util/int_extensions.dart';
import '../../extensions/extension_util/string_extensions.dart';
import '../../extensions/extension_util/widget_extensions.dart';
import '../../extensions/system_utils.dart';
import '../../screens/assign_screen.dart';
import '../../screens/blog_screen.dart';
import '../../screens/edit_profile_screen.dart';
import '../../screens/setting_screen.dart';
import '../../screens/sign_in_screen.dart';
import '../extensions/colors.dart';
import '../extensions/confirmation_dialog.dart';
import '../extensions/decorations.dart';
import '../extensions/text_styles.dart';
import '../main.dart';
import '../service/auth_service.dart';
import '../utils/app_colors.dart';
import '../utils/app_common.dart';
import '../utils/app_images.dart';
import 'about_app_screen.dart';
import 'favourite_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Widget mOtherInfo(String title, String value, String heading) {
    return Container(
      decoration: boxDecorationWithRoundedCorners(borderRadius: radius(12), backgroundColor: primaryOpacity),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(text: value, style: boldTextStyle(size: 18, color: primaryColor)),
                const WidgetSpan(child: Padding(padding: EdgeInsets.only(right: 4))),
                TextSpan(text: heading, style: boldTextStyle(size: 14, color: primaryColor)),
              ],
            ),
          ),
          6.height,
          Text(title, style: secondaryTextStyle(size: 12, color: textColor)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: appStore.isDarkMode ? Brightness.light : Brightness.light,
        systemNavigationBarIconBrightness: appStore.isDarkMode ? Brightness.light : Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: appStore.isDarkMode ? cardDarkColor : cardLightColor,
        body: Observer(
          builder: (context) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(height: context.height() * 0.4, color: primaryColor),
                      Align(
                        alignment: Alignment.center,
                        child: Text(languages.lblProfile, style: boldTextStyle(size: 20, color: white)).paddingTop(context.statusBarHeight + 16),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: context.height() * 0.2),
                        height: context.height() * 0.9,
                        decoration: boxDecorationWithRoundedCorners(
                          backgroundColor: appStore.isDarkMode ? context.scaffoldBackgroundColor : context.cardColor,
                          borderRadius: radiusOnly(topRight: defaultRadius, topLeft: defaultRadius),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: context.height() * 0.1, right: 16, left: 16),
                        child: Column(
                          children: [
                            16.height,
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 4),
                              decoration: boxDecorationWithRoundedCorners(
                                  backgroundColor: appStore.isDarkMode ? socialBackground : context.cardColor,
                                  boxShadow: [BoxShadow(color: shadowColorGlobal, offset: const Offset(0, 1), spreadRadius: 2, blurRadius: 10, blurStyle: BlurStyle.outer)],
                                  borderRadius: radius(14)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          Container(
                                            decoration: boxDecorationWithRoundedCorners(boxShape: BoxShape.circle, border: Border.all(width: 2, color: primaryColor)),
                                            child: cachedImage(userStore.profileImage.validate(), height: 65, width: 65, fit: BoxFit.cover).cornerRadiusWithClipRRect(100).paddingAll(1),
                                          ),
                                          Container(
                                            decoration: boxDecorationWithRoundedCorners(boxShape: BoxShape.circle, border: Border.all(width: 2, color: white), backgroundColor: primaryColor),
                                            padding: const EdgeInsets.all(4),
                                            child: Image.asset(ic_edit, color: white, height: 14, width: 14),
                                          )
                                        ],
                                      ),
                                      12.width,
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("${userStore.fName.validate().capitalizeFirstLetter()} ${userStore.lName.capitalizeFirstLetter()}", style: boldTextStyle(size: 20)),
                                          2.height,
                                          Text(userStore.email.validate(), style: secondaryTextStyle()),
                                        ],
                                      ).expand(),
                                    ],
                                  ).paddingSymmetric(horizontal: 16).onTap(() async {
                                    bool? res = await const EditProfileScreen().launch(context);
                                    if (res == true) {
                                      setState(() {});
                                    }
                                  }),
                                  20.height,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      mOtherInfo(languages.lblWeight, userStore.weight.isEmptyOrNull ? "-" : userStore.weight.validate(),
                                              userStore.weight.isEmptyOrNull ? "" : userStore.weightUnit.validate())
                                          .expand(),
                                      12.width,
                                      mOtherInfo(languages.lblHeight, userStore.height.isEmptyOrNull ? "-" : userStore.height.validate(),
                                              userStore.height.isEmptyOrNull ? "" : userStore.heightUnit.validate())
                                          .expand(),
                                      12.width,
                                      mOtherInfo(languages.lblAge, userStore.age.isEmptyOrNull ? "-" : userStore.age.validate(), userStore.age.isEmptyOrNull ? "" : languages.lblYear).expand(),
                                    ],
                                  ).paddingSymmetric(horizontal: 16),
                                ],
                              ),
                            ),
                            8.height,
                            mOption(ic_blog, languages.lblBlog, () {
                              const BlogScreen().launch(context);
                            }),
                            const Divider(height: 0, color: grayColor),

                            // ///TODO
                            // mOption(ic_blog, "Videos", () {
                            //   VideoScreen().launch(context);
                            // }),
                            const Divider(height: 0, color: grayColor),

                            if (userStore.subscription == "1")
                              mOption(ic_subscription_plan, languages.lblSubscriptionPlans, () {
                                const SubscriptionDetailScreen().launch(context);
                              }),
                            const Divider(height: 0, color: grayColor),
                            mOption(ic_fav_outline, languages.lblFavoriteWorkoutAndNutristions, () {
                              const FavouriteScreen(index: 0).launch(context);
                            }),
                            const Divider(height: 0, color: grayColor),
                            mOption(ic_reminder, languages.lblDailyReminders, () {
                              const ReminderScreen().launch(context);
                            }),
                            const Divider(height: 0, color: grayColor),
                            mOption(ic_assigned, languages.lblPlan, () {
                              const AssignScreen().launch(context);
                            }),
                            const Divider(height: 0, color: grayColor),
                            mOption(ic_setting, languages.lblSettings, () {
                              const SettingScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
                            }),
                            const Divider(height: 0, color: grayColor),
                            mOption(ic_info, languages.lblAboutApp, () {
                              const AboutAppScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
                            }),
                            const Divider(height: 0, color: grayColor),
                            mOption(ic_report, 'Workout History', () {

                              const WorkoutHistoryScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
                            }),
                            const Divider(height: 0, color: grayColor),
                            mOption(ic_logout, languages.lblLogout, () {
                              showConfirmDialogCustom(context,
                                  dialogType: DialogType.DELETE,
                                  title: languages.lblLogoutMsg,
                                  primaryColor: primaryColor,
                                  positiveText: languages.lblLogout,
                                  image: ic_logout, onAccept: (buildContext) {
                                logout(context, onLogout: () {
                                  isFirstTimeGraph = false;
                                  const SignInScreen().launch(context, isNewTask: true);
                                });
                                finish(context);
                              });
                            }),
                            20.height,
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
