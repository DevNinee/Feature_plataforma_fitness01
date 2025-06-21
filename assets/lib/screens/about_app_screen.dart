import 'package:flutter/material.dart';
import '../screens/privacy_policy_screen.dart';
import '../screens/terms_and_conditions_screen.dart';
import '../screens/medical_policy_screen.dart';
import '../../extensions/extension_util/widget_extensions.dart';
import '../../extensions/shared_pref.dart';
import '../../extensions/widgets.dart';
import '../extensions/common.dart';
import '../main.dart';
import '../utils/app_common.dart';
import '../utils/app_constants.dart';
import '../utils/app_images.dart';
import 'about_us_screen.dart';

class AboutAppScreen extends StatefulWidget {
  static String tag = '/AboutAppScreen';

  const AboutAppScreen({super.key});

  @override
  AboutAppScreenState createState() => AboutAppScreenState();
}

class AboutAppScreenState extends State<AboutAppScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(languages.lblAboutApp, context: context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            mOption(ic_rate_us, languages.lblPrivacyPolicy, () {
              const PrivacyPolicyScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
            }).visible(getStringAsync(PRIVACY_POLICY).isNotEmpty),
            const Divider(height: 0).visible(getStringAsync(PRIVACY_POLICY).isNotEmpty),
            mOption(ic_terms, languages.lblTermsOfServices, () {
              const TermsAndConditionScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
            }).visible(getStringAsync(TERMS_SERVICE).isNotEmpty),
            const Divider(height: 0).visible(getStringAsync(TERMS_SERVICE).isNotEmpty),

            mOption(ic_info, languages.lblAboutUs, () {
              const AboutUsScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
            }),

            mOption(ic_info, 'Informações médicas', () {
              const MedicalPolicyScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
            }),


          ],
        ),
      ),
    );
  }
}
